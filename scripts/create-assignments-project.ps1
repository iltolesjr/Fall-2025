<#
.SYNOPSIS
  Create (or reuse) a GitHub Projects (Beta) board and populate it with issues for each assignment file.
.DESCRIPTION
  Scans the local assignments directory, creates one Issue per assignment file (skips tracker/readme files),
  then adds each issue to a Project (V2) and sets its Status (default Todo).

  Requires: gh CLI authenticated with repo + project: write scope.
.PARAMETER User
  GitHub username (owner of the project / repo).
.PARAMETER Repo
  Repository name (defaults to current folder name).
.PARAMETER ProjectTitle
  Title of the GitHub Project (default: "Fall 2025 Assignments").
.PARAMETER AssignmentsPath
  Relative path to assignments root (default: 'assignments').
.PARAMETER DryRun
  Show actions only.
.PARAMETER VerboseScan
  List every file considered / skipped.
.NOTES
  Uses GitHub Projects (beta) GraphQL (ProjectV2). Columns are simulated via the built-in single-select Status field.
.LINK
  https://docs.github.com/en/issues/planning-and-tracking-with-projects/learning-about-projects/about-projects
#>
param(
  [Parameter(Mandatory=$true)][string]$User,
  [string]$Repo = (Split-Path -Leaf (Get-Location)),
  [string]$ProjectTitle = 'Fall 2025 Assignments',
  [string]$AssignmentsPath = 'assignments',
  [switch]$DryRun,
  [switch]$VerboseScan
)

function Step($m){ Write-Host "==> $m" -ForegroundColor Cyan }
function Info($m){ Write-Host $m -ForegroundColor DarkGray }
function Warn($m){ Write-Warning $m }
function Die($m){ Write-Error $m; exit 1 }

# 0. Preflight
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { Die "gh CLI not found. Install: winget install --id GitHub.cli -e" }

# Ensure gh auth
Step "Checking gh auth status"
$null = gh auth status 2>$null
if ($LASTEXITCODE -ne 0) { Die "gh not authenticated. Run: gh auth login" }

# 1. Get owner ID
Step "Resolving user node ID"
$queryUser = @'
query($login:String!){ user(login:$login){ id } }
'@
$userIdJson = gh api graphql -f query="$queryUser" -f login=$User | ConvertFrom-Json
$userId = $userIdJson.data.user.id
if (-not $userId) { Die "Could not resolve user id for $User" }

# 2. Find or create project
Step "Locating existing project titled '$ProjectTitle'"
$queryProjects = @'
query($login:String!){ user(login:$login){ projectsV2(first:50){ nodes { id title url } } } }
'@
$projList = gh api graphql -f query="$queryProjects" -f login=$User | ConvertFrom-Json
$project = $projList.data.user.projectsV2.nodes | Where-Object { $_.title -eq $ProjectTitle } | Select-Object -First 1
if (-not $project) {
  Step "Creating project '$ProjectTitle'"
  $createProject = @'
mutation($owner:ID!,$title:String!){ createProjectV2(input:{ownerId:$owner,title:$title}){ projectV2 { id title url } } }
'@
  if (-not $DryRun){
    $created = gh api graphql -f query="$createProject" -f owner=$userId -f title="$ProjectTitle" | ConvertFrom-Json
    $project = $created.data.createProjectV2.projectV2
  } else { Info "[DryRun] Would create project" }
} else { Info "Project exists: $($project.url)" }
$projectId = $project.id
if (-not $projectId -and -not $DryRun) { Die "Project creation failed." }

# 3. Fetch fields to find Status
Step "Fetching project fields"
$queryFields = @'
query($pid:ID!){ node(id:$pid){ ... on ProjectV2 { fields(first:50){ nodes { ... on ProjectV2SingleSelectField { id name options { id name } } } } } } }
'@
$fields = gh api graphql -f query="$queryFields" -f pid=$projectId | ConvertFrom-Json
$statusField = $fields.data.node.fields.nodes | Where-Object { $_.name -eq 'Status' } | Select-Object -First 1
if (-not $statusField) { Warn "No 'Status' field found. Items will be added without setting status." }
else {
  $todoOption = $statusField.options | Where-Object { $_.name -match 'todo|to do' } | Select-Object -First 1
  if (-not $todoOption) { $todoOption = $statusField.options | Select-Object -First 1 }
}

# 4. Scan assignments
if (-not (Test-Path $AssignmentsPath)) { Die "Assignments path '$AssignmentsPath' not found." }
Step "Scanning assignment files"
$allFiles = Get-ChildItem -Path $AssignmentsPath -Recurse -File -Include *.md
$items = @()
foreach ($f in $allFiles) {
  $rel = Resolve-Path -Relative $f.FullName
  if ($f.Name -match 'tracker\.md$') { if ($VerboseScan){ Info "Skip tracker: $rel" }; continue }
  if ($f.Name -match '^README\.md$') { if ($VerboseScan){ Info "Skip readme: $rel" }; continue }
  # Build issue title from path parts
  $titleParts = @()
  $segments = ($f.FullName -replace '\\','/').Split('/')
  $assignIndex = [Array]::IndexOf($segments, $AssignmentsPath)
  if ($assignIndex -ge 0) { $titleParts = $segments[($assignIndex+1)..($segments.Length-1)] }
  $rawTitle = ($titleParts -join ' / ').Replace('.md','')
  if (-not $rawTitle) { continue }
  $items += [pscustomobject]@{ Title = $rawTitle; Path = $rel }
}
if ($items.Count -eq 0) { Die "No assignment files found." }
Info "Found $($items.Count) candidate assignments"

# 5. Fetch existing issues to avoid duplicates
Step "Collecting existing issues"
$issueJson = gh issue list --limit 200 --json title,number | ConvertFrom-Json
$existingTitles = $issueJson.title

$createdIssues = @()
foreach ($it in $items) {
  if ($existingTitles -contains $it.Title) {
    if ($VerboseScan){ Info "Issue exists: $($it.Title)" }
    continue
  }
  Step "Creating issue: $($it.Title)"
  $body = "Generated from file: $($it.Path)\n\nStatus: Todo"
  if (-not $DryRun){
    $created = gh issue create --title "$($it.Title)" --body "$body" --json number,title,url | ConvertFrom-Json
    $createdIssues += $created
  } else {
    Info "[DryRun] Would create issue: $($it.Title)"
  }
}

# 6. Add issues to project
if (-not $DryRun){
  $issueNumbers = gh issue list --limit 300 --json number,title | ConvertFrom-Json
  foreach ($it in $items) {
    $issueObj = $issueNumbers | Where-Object { $_.title -eq $it.Title } | Select-Object -First 1
    if (-not $issueObj) { continue }
    Step "Adding to project: $($it.Title)"
    # Get issue node id
    $issueQuery = @'
query($owner:String!,$repo:String!,$number:Int!){ repository(owner:$owner,name:$repo){ issue(number:$number){ id } } }
'@
    $issueNode = gh api graphql -f query="$issueQuery" -f owner=$User -f repo=$Repo -F number=$($issueObj.number) | ConvertFrom-Json
    $issueId = $issueNode.data.repository.issue.id
    $addMutation = @'
mutation($pid:ID!,$cid:ID!){ addProjectV2ItemById(input:{projectId:$pid,contentId:$cid}){ item { id } } }
'@
    $addResult = gh api graphql -f query="$addMutation" -f pid=$projectId -f cid=$issueId | ConvertFrom-Json
    $itemId = $addResult.data.addProjectV2ItemById.item.id
    if ($statusField -and $todoOption){
      $setStatus = @'
mutation($pid:ID!,$item:ID!,$field:ID!,$opt:String!){ updateProjectV2ItemFieldValue(input:{projectId:$pid,itemId:$item,fieldId:$field,value:{singleSelectOptionId:$opt}}){ projectV2Item { id } } }
'@
      $null = gh api graphql -f query="$setStatus" -f pid=$projectId -f item=$itemId -f field=$($statusField.id) -f opt=$($todoOption.id)
    }
  }
} else {
  Info "[DryRun] Would add issues to project and set status"
}

Step "Summary"
Write-Host "Project: $ProjectTitle" -ForegroundColor Green
Write-Host "Total assignment files: $($items.Count)" -ForegroundColor Green
if (-not $DryRun){
  Write-Host "New issues created: $($createdIssues.Count)" -ForegroundColor Green
  Write-Host "Project URL (refresh in browser): $($project.url)" -ForegroundColor Yellow
} else {
  Write-Host "(DryRun) No network changes performed" -ForegroundColor Yellow
}
