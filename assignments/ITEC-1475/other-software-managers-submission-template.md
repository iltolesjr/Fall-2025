# Other Software Managers Lab Submission

**Student Name**: [Your Name]  
**StarID**: [Your StarID]  
**Course**: ITEC 1475-60 Linux System Administration  
**Instructor**: Ira Toles  
**Date Completed**: [Completion Date]  
**Due Date**: October 5, 2025 at 11:59 PM  

---

## Lab Summary

[Write a brief paragraph summarizing what you learned in this lab. Discuss key differences between package managers you discovered and your overall experience with snap and flatpak.]

---

## Activity Screenshots

### Activity 2: Installing Snap ✅

#### Screenshot 1: Snap Version Check
![Snap Version](screenshots/01-snap-version.png)

**Notes**: [Describe what this screenshot shows]

---

#### Screenshot 2: Snap Application Installation
![Snap Install](screenshots/02-snap-install.png)

**Application Installed**: [Application name]  
**Command Used**: `sudo snap install [app-name]`

**Interesting Applications Found**:
1. [Application 1] - [Brief description]
2. [Application 2] - [Brief description]
3. [Application 3] - [Brief description]

---

### Activity 3: Installing Flatpak ✅

#### Screenshot 3: Flatpak Installation
![Flatpak Install](screenshots/03-flatpak-install.png)

**Notes**: [Describe the installation process]

---

#### Screenshot 4: Flathub Repository Addition
![Flathub Setup](screenshots/04-flathub-setup.png)

**Command Used**: `flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

---

#### Screenshot 5: Flatpak Application Installation
![Flatpak App Install](screenshots/05-flatpak-app-install.png)

**Application Installed**: [Application name and ID]  
**Command Used**: `flatpak install flathub [app-id]`

---

### Activity 4: Comparing Package Managers ✅

#### Screenshot 6: Disk Usage Comparison
![Disk Usage](screenshots/06-disk-usage.png)

**Commands Used**:
```bash
df -h
snap list
flatpak list
apt list --installed | wc -l
```

**Observations**:
- Total snap applications: [number]
- Total flatpak applications: [number]
- Total apt packages: [number]
- Disk space used by snaps: [size]
- Disk space used by flatpaks: [size]

**Performance Notes**: [Your observations about launch speed and performance]

---

### Activity 5: Managing Installed Software ✅

#### Screenshot 7: Application Information
![App Info](screenshots/07-app-info.png)

**Commands Used**:
```bash
snap info [app-name]
flatpak info [app-id]
apt show [package-name]
```

---

#### Screenshot 8: Application Removal
![App Removal](screenshots/08-app-removal.png)

**Removed Applications**:
- Snap application: [name]
- Flatpak application: [name]

---

## Package Manager Comparison Table

| Feature | apt/dpkg | snap | flatpak |
|---------|----------|------|---------|
| **Installation Speed** | [Your observation] | [Your observation] | [Your observation] |
| **Disk Usage** | [Your observation] | [Your observation] | [Your observation] |
| **Sandboxing** | [Your observation] | [Your observation] | [Your observation] |
| **Update Frequency** | [Your observation] | [Your observation] | [Your observation] |
| **Application Availability** | [Your observation] | [Your observation] | [Your observation] |
| **Ease of Use** | [Your observation] | [Your observation] | [Your observation] |
| **Dependency Management** | [Your observation] | [Your observation] | [Your observation] |

---

## Reflection Questions

### 1. Which package manager did you find easiest to use and why?

[2-3 sentences discussing your experience with the different package managers and which one you found most user-friendly]

---

### 2. What are the advantages of universal package managers like snap and flatpak?

[2-3 sentences explaining the benefits of universal package managers, such as cross-distribution compatibility, sandboxing, or ease of updates]

---

### 3. When would you choose traditional apt over snap/flatpak?

[2-3 sentences discussing scenarios where traditional package managers would be preferable, such as system packages, resource constraints, or integration needs]

---

### 4. What challenges did you encounter during the lab?

[2-3 sentences describing any difficulties you faced and how you resolved them, or note if the lab went smoothly]

---

## Technical Documentation

### Applications Installed During Lab

**Snap Applications**:
1. [Application name] - [Purpose/description]
2. [Application name] - [Purpose/description]

**Flatpak Applications**:
1. [Application name] - [Purpose/description]
2. [Application name] - [Purpose/description]

### Errors Encountered and Resolutions

**Issue 1**: [Description of problem]
- **Solution**: [How you resolved it]

**Issue 2**: [Description of problem]
- **Solution**: [How you resolved it]

[Or write "No significant errors encountered" if applicable]

### Most Useful Commands

1. `[command]` - [Why it was useful]
2. `[command]` - [Why it was useful]
3. `[command]` - [Why it was useful]

---

## Submission Checklist ✅

- [x] Lab summary paragraph completed
- [x] All 8 required screenshots included and clearly labeled
- [x] Screenshots show complete terminal output and are readable
- [x] Comparison table filled out with observations
- [x] All 4 reflection questions answered (2-3 sentences each)
- [x] Technical documentation complete
- [x] Applications installed listed
- [x] Errors and resolutions documented
- [x] Most useful commands identified
- [x] Document formatting professional and organized
- [x] File named correctly: [StarID]-other-software-managers-lab.pdf/.md
- [x] Submitted to correct assignment folder before deadline

---

## Lab Completion Details

**Date Started**: [Date you started in class]  
**Date Completed**: [Date you finished]  
**Time Invested**: [Estimated hours]  
**Overall Experience**: [Brief note about your lab experience]

---

*This submission follows the requirements outlined in the On-Campus Lab: Other Software Managers assignment for ITEC 1475-60. Work completed individually with documentation of personal learning and technical achievement.*

**Submission Date**: [Date]  
**Status**: Ready for Review ✅
