This folder contains suggested screenshots for the Lennox / ITEC-1475 lab submissions.

Naming convention (numeric prefix keeps order):
- 01-missing-script.png — terminal showing "No such file or directory" when attempting to run the script
- 02-script-source.png — editor view of `assignments/ITEC-1475/scripts/collect_lennox_outputs.sh` (top of file)
- 03-script-fixed.png — editor showing the fixed script (after applying suggested corrections)
- 04-script-run.png — terminal showing the script run with sudo and the header "Lennox Lab outputs collected on: ..."
- 05-output-file.png — editor or terminal showing the `lennox-lab-outputs.txt` contents (Hostnamectl, ip addr, Done line)
- 06-git-commit.png — terminal showing `git status`/`git commit` when staging and committing files
- 07-github.png — optional: GitHub web UI showing the new files

Tips:
- Crop images so only the relevant terminal/editor area is visible.
- Use PNG and include a short caption (filename + what it shows) if your workflow supports it.
- If output contains sensitive information (internal IPs, MAC addresses, machine IDs), redact before committing. See `screenshots/README-redaction.md` for guidance.

If you want, I can create example highlighted markdown copies of key files to show exactly which lines to capture.
