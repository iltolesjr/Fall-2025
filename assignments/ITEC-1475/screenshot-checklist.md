# ITEC-1475 Screenshot & Submission Checklist

This checklist shows recommended screenshots and items to include for the Lennox / ITEC-1475 labs. Use the `screenshots/` folder and the naming convention described at the repo root.

## Files to capture
- [ ] `assignments/ITEC-1475/scripts/collect_lennox_outputs.sh` — top of file (shebang + header)
- [ ] Terminal showing `bash: ... No such file or directory` when script path is wrong
- [ ] Terminal running the script with `sudo` and showing `Lennox Lab outputs collected on: ...`
- [ ] `lennox-lab-outputs.txt` — show Hostnamectl, ip addr, the UFW error, and the final "Done. Outputs saved" line
- [ ] `assignments/ITEC-1475/lennox-server-setup.md` — any specific commands the lab asks for (screenshot of key steps)
- [ ] `assignments/ITEC-1475/lennox-server-completion-guide.md` — screenshot of your completion checkboxes or evidence requested by the guide
- [ ] `assignments/ITEC-1475/lennox-server-submission.md` — screenshot of the submission form or summary required for the assignment

## Suggested screenshot filenames
- `screenshots/01-missing-script.png` — missing script error
- `screenshots/02-script-source.png` — script open in editor
- `screenshots/03-script-fixed.png` — script after fixes
- `screenshots/04-script-run.png` — sudo run showing timestamp
- `screenshots/05-output-file.png` — sample lines from `lennox-lab-outputs.txt`

## Redaction note
If any outputs contain sensitive data (internal IPs, MACs, serials, machine IDs), either redact them in the screenshot or do not commit the raw `lennox-lab-outputs.txt` file — instead include a sanitized excerpt or screenshot.

---

If you want, I can also:
- Insert inline highlighted samples in the `assignments/ITEC-1475` markdown files (using GitHub-friendly highlighting) so you see exactly which lines to screenshot in each lab file.
- Create a commit that adds `screenshots/` and these checklist files automatically.

Tell me which of the above you'd like me to do next (create the commit and push, add more highlighted files for other labs, or open a PR).
