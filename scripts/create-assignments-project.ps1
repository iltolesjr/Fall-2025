<#
.SYNOPSIS
  Create (or reuse) a GitHub Projects (Beta) board and populate it with issues for each assignment from tracker files.
.DESCRIPTION
  Scans assignment tracker files (ENGL-1110-tracker.md, ITEC-1475-tracker.md) to extract assignments with their status,
  creates GitHub Issues for each assignment, adds them to a Project (V2), and sets their Status based on tracker.
  Status mapping: "Not Started" → "Todo", "In Progress" → "In Progress", "Completed" → "Done"

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
  Uses GitHub Projects (beta) GraphQL (ProjectV2). Reads assignment status from tracker files to organize by completion.
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

# Ensure gh auth (skip in dry-run mode for testing)
Step "Checking gh auth status"
if (-not $DryRun) {
  $null = gh auth status 2>$null
  if ($LASTEXITCODE -ne 0) { Die "gh not authenticated. Run: gh auth login" }
} else {
  Info "[DryRun] Skipping auth check"
}

# 1. Get owner ID
Step "Resolving user node ID"
if (-not $DryRun) {
  $queryUser = @'
query($login:String!){ user(login:$login){ id } }
'@
  $userIdJson = gh api graphql -f query="$queryUser" -f login=$User | ConvertFrom-Json
  $userId = $userIdJson.data.user.id
  if (-not $userId) { Die "Could not resolve user id for $User" }
} else {
  $userId = "fake-user-id-for-dry-run"
  Info "[DryRun] Using fake user ID"
}

# 2. Find or create project
Step "Locating existing project titled '$ProjectTitle'"
if (-not $DryRun) {
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
    $created = gh api graphql -f query="$createProject" -f owner=$userId -f title="$ProjectTitle" | ConvertFrom-Json
    $project = $created.data.createProjectV2.projectV2
  } else { Info "Project exists: $($project.url)" }
  $projectId = $project.id
  if (-not $projectId) { Die "Project creation failed." }
} else {
  Info "[DryRun] Would locate or create project '$ProjectTitle'"
  $projectId = "fake-project-id"
  $project = [pscustomobject]@{ id = $projectId; title = $ProjectTitle; url = "https://github.com/users/$User/projects/1" }
}

# 3. Fetch fields to find Status
Step "Fetching project fields"
if (-not $DryRun) {
  $queryFields = @'
query($pid:ID!){ node(id:$pid){ ... on ProjectV2 { fields(first:50){ nodes { ... on ProjectV2SingleSelectField { id name options { id name } } } } } } }
'@
  $fields = gh api graphql -f query="$queryFields" -f pid=$projectId | ConvertFrom-Json
  $statusField = $fields.data.node.fields.nodes | Where-Object { $_.name -eq 'Status' } | Select-Object -First 1
  if (-not $statusField) { Warn "No 'Status' field found. Items will be added without setting status." }
  else {
    # Get all status options for mapping
    $todoOption = $statusField.options | Where-Object { $_.name -match '^(todo|to do)$' } | Select-Object -First 1
    $inProgressOption = $statusField.options | Where-Object { $_.name -match '^(in progress|in-progress)$' } | Select-Object -First 1
    $doneOption = $statusField.options | Where-Object { $_.name -match '^(done|completed)$' } | Select-Object -First 1
    
    if (-not $todoOption) { $todoOption = $statusField.options | Where-Object { $_.name -match 'todo' } | Select-Object -First 1 }
    if (-not $inProgressOption) { $inProgressOption = $statusField.options | Where-Object { $_.name -match 'progress' } | Select-Object -First 1 }
    if (-not $doneOption) { $doneOption = $statusField.options | Where-Object { $_.name -match 'done' } | Select-Object -First 1 }
  }
} else {
  Info "[DryRun] Would fetch project fields and status options"
  $statusField = [pscustomobject]@{ id = "fake-field-id"; name = "Status" }
  $todoOption = [pscustomobject]@{ id = "opt-todo"; name = "Todo" }
  $inProgressOption = [pscustomobject]@{ id = "opt-progress"; name = "In Progress" }
  $doneOption = [pscustomobject]@{ id = "opt-done"; name = "Done" }
}

# 4. Parse tracker files to extract assignments with status
if (-not (Test-Path $AssignmentsPath)) { Die "Assignments path '$AssignmentsPath' not found." }
Step "Parsing assignment tracker files"

$items = @()
$trackerFiles = Get-ChildItem -Path $AssignmentsPath -File -Filter "*-tracker.md"

foreach ($trackerFile in $trackerFiles) {
  $courseName = $trackerFile.BaseName -replace '-tracker$',''
  Info "Processing tracker: $($trackerFile.Name) (Course: $courseName)"
  
  $content = Get-Content $trackerFile.FullName -Raw
  $lines = $content -split "`r?`n"
  
  $inTable = $false
  $headerPassed = $false
  
  foreach ($line in $lines) {
    # Detect table rows (starting with |)
    if ($line -match '^\s*\|') {
      if (-not $inTable) {
        $inTable = $true
        continue  # Skip header row
      }
      if (-not $headerPassed) {
        $headerPassed = $true
        continue  # Skip separator row
      }
      
      # Parse table row: | Assignment | Due Date | ... | Status | ... |
      $cells = $line -split '\|' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
      if ($cells.Count -ge 3) {
        $assignmentName = $cells[0] -replace '^\*\*|\*\*$',''  # Remove bold markdown
        $assignmentName = $assignmentName.Trim()
        
        # Find Status column (typically 3rd or 4th column)
        $status = 'Not Started'
        foreach ($cell in $cells) {
          if ($cell -match '(Not Started|In Progress|Completed)') {
            $status = $Matches[1]
            break
          }
        }
        
        if ($assignmentName -and $assignmentName -ne 'Assignment') {
          $items += [pscustomobject]@{ 
            Title = "[$courseName] $assignmentName"
            Course = $courseName
            Status = $status
            Path = $trackerFile.Name
          }
          if ($VerboseScan) { Info "  Found: $assignmentName (Status: $status)" }
        }
      }
    }
    # Exit table when we hit a line that doesn't start with |
    elseif ($inTable) {
      $inTable = $false
      $headerPassed = $false
    }
  }
}

if ($items.Count -eq 0) { Die "No assignments found in tracker files." }
Info "Found $($items.Count) assignments from tracker files"

# 5. Fetch existing issues to avoid duplicates
Step "Collecting existing issues"
if (-not $DryRun) {
  $issueJson = gh issue list --limit 200 --json title,number | ConvertFrom-Json
  $existingTitles = $issueJson.title
} else {
  Info "[DryRun] Would check for existing issues"
  $existingTitles = @()
}

$createdIssues = @()
foreach ($it in $items) {
  if ($existingTitles -contains $it.Title) {
    if ($VerboseScan){ Info "Issue exists: $($it.Title)" }
    continue
  }
  Step "Creating issue: $($it.Title)"
  $body = "**Course**: $($it.Course)`n**Status**: $($it.Status)`n**Tracker**: $($it.Path)`n`nThis issue was automatically generated from the assignment tracker."
  if (-not $DryRun){
    $created = gh issue create --title "$($it.Title)" --body "$body" --label "$($it.Course)" --json number,title,url | ConvertFrom-Json
    $createdIssues += $created
  } else {
    Info "[DryRun] Would create issue: $($it.Title) with label $($it.Course)"
  }
}

# 6. Add issues to project with appropriate status
if (-not $DryRun){
  $issueNumbers = gh issue list --limit 300 --json number,title | ConvertFrom-Json
  foreach ($it in $items) {
    $issueObj = $issueNumbers | Where-Object { $_.title -eq $it.Title } | Select-Object -First 1
    if (-not $issueObj) { continue }
    Step "Adding to project: $($it.Title) [Status: $($it.Status)]"
    
    # Get issue node id
    $issueQuery = @'
query($owner:String!,$repo:String!,$number:Int!){ repository(owner:$owner,name:$repo){ issue(number:$number){ id } } }
'@
    $issueNode = gh api graphql -f query="$issueQuery" -f owner=$User -f repo=$Repo -F number=$($issueObj.number) | ConvertFrom-Json
    $issueId = $issueNode.data.repository.issue.id
    
    # Add to project
    $addMutation = @'
mutation($pid:ID!,$cid:ID!){ addProjectV2ItemById(input:{projectId:$pid,contentId:$cid}){ item { id } } }
'@
    $addResult = gh api graphql -f query="$addMutation" -f pid=$projectId -f cid=$issueId | ConvertFrom-Json
    $itemId = $addResult.data.addProjectV2ItemById.item.id
    
    # Set status based on tracker status
    if ($statusField){
      $statusOption = $null
      switch ($it.Status) {
        'Completed' { $statusOption = $doneOption }
        'In Progress' { $statusOption = $inProgressOption }
        'Not Started' { $statusOption = $todoOption }
        default { $statusOption = $todoOption }
      }
      
      if ($statusOption) {
        $setStatus = @'
mutation($pid:ID!,$item:ID!,$field:ID!,$opt:String!){ updateProjectV2ItemFieldValue(input:{projectId:$pid,itemId:$item,fieldId:$field,value:{singleSelectOptionId:$opt}}){ projectV2Item { id } } }
'@
        $null = gh api graphql -f query="$setStatus" -f pid=$projectId -f item=$itemId -f field=$($statusField.id) -f opt=$($statusOption.id)
        Info "  Set status to: $($statusOption.name)"
      }
    }
  }
} else {
  Info "[DryRun] Would add issues to project and set status based on tracker"
  foreach ($it in $items) {
    Info "  $($it.Title) -> Status: $($it.Status)"
  }
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
