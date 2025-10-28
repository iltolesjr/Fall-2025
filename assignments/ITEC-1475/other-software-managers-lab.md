# On-Campus Lab: Other Software Managers - ITEC 1475

**Course**: ITEC 1475-60 Linux System Administration  
**Instructor**: Ira Toles  
**Semester**: Fall 2025  
**Lab Type**: On-Campus Lab Activity  
**Due Date**: October 5, 2025 at 11:59 PM  

## Lab Overview

This on-campus lab introduces you to alternative software package managers beyond the standard apt/dpkg system. You will explore snap, flatpak, and other modern package management systems used in Linux distributions. The lab focuses on understanding when and why to use different package managers, their advantages, and practical installation and management techniques.

## Learning Objectives

- Understand different Linux package management systems
- Install and configure snap and flatpak package managers
- Compare and contrast traditional and modern package managers
- Install applications using multiple package management systems
- Manage software updates across different package managers
- Troubleshoot common package manager issues

## Prerequisites

- Access to your Linux Mint system
- Basic Linux command line knowledge
- Sudo/administrative privileges
- Active internet connection for package downloads

## Lab Activities

### Activity 1: Understanding Package Managers (15 minutes)

**Concepts to Explore:**
- Traditional package managers (apt, dpkg, rpm, yum)
- Modern universal package managers (snap, flatpak, AppImage)
- Differences in packaging approach and sandboxing
- Use cases for each package manager type

**Discussion Points:**
- When would you choose snap vs flatpak vs traditional packages?
- What are the security implications of different package managers?
- How do package managers handle dependencies?

### Activity 2: Installing Snap (20 minutes)

**Tasks:**
1. Check if snap is installed:
   ```bash
   snap version
   ```

2. Install snapd if not present:
   ```bash
   sudo apt update
   sudo apt install snapd
   ```

3. Verify snap service is running:
   ```bash
   sudo systemctl status snapd
   ```

4. List available snap applications:
   ```bash
   snap find
   snap find "text editor"
   ```

5. Install an application via snap:
   ```bash
   sudo snap install <application-name>
   ```

**Documentation Required:**
- Screenshot of snap version command
- Screenshot of successful snap installation
- List 3 applications you found interesting

### Activity 3: Installing Flatpak (20 minutes)

**Tasks:**
1. Install flatpak package manager:
   ```bash
   sudo apt update
   sudo apt install flatpak
   ```

2. Add Flathub repository:
   ```bash
   flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```

3. Search for available applications:
   ```bash
   flatpak search <application-name>
   ```

4. Install an application via flatpak:
   ```bash
   flatpak install flathub <application-id>
   ```

5. List installed flatpak applications:
   ```bash
   flatpak list
   ```

**Documentation Required:**
- Screenshot of flatpak installation
- Screenshot of Flathub repository addition
- Screenshot of installed flatpak application

### Activity 4: Comparing Package Managers (15 minutes)

**Tasks:**
1. Check storage usage of different package types:
   ```bash
   df -h
   snap list
   flatpak list
   apt list --installed | wc -l
   ```

2. Compare the same application across package managers (if available)

3. Test application launch speed from different package managers

4. Review update mechanisms:
   ```bash
   sudo apt update && sudo apt upgrade
   sudo snap refresh
   flatpak update
   ```

**Documentation Required:**
- Screenshot comparing disk usage
- Notes on performance differences
- Observations about update processes

### Activity 5: Managing Installed Software (15 minutes)

**Tasks:**
1. Remove a snap application:
   ```bash
   sudo snap remove <application-name>
   ```

2. Remove a flatpak application:
   ```bash
   flatpak uninstall <application-id>
   ```

3. View application information:
   ```bash
   snap info <application-name>
   flatpak info <application-id>
   apt show <package-name>
   ```

4. Check for updates:
   ```bash
   snap refresh --list
   flatpak update --appstream
   ```

**Documentation Required:**
- Screenshot of application removal
- Screenshot of application information output
- List of pending updates (if any)

## Submission Requirements

Create a document that includes:

1. **Lab Summary** (1 paragraph)
   - Brief overview of what you learned
   - Key differences between package managers discovered

2. **Activity Screenshots** (minimum 8 required)
   - Snap installation and version check
   - Snap application installation
   - Flatpak installation
   - Flathub repository addition
   - Flatpak application installation
   - Package manager comparison (disk usage)
   - Application information output
   - Application removal confirmation

3. **Comparison Table**
   Create a table comparing apt, snap, and flatpak:
   
   | Feature | apt/dpkg | snap | flatpak |
   |---------|----------|------|---------|
   | Installation Speed | | | |
   | Disk Usage | | | |
   | Sandboxing | | | |
   | Update Frequency | | | |
   | Application Availability | | | |

4. **Reflection Questions** (2-3 sentences each)
   - Which package manager did you find easiest to use and why?
   - What are the advantages of universal package managers like snap and flatpak?
   - When would you choose traditional apt over snap/flatpak?
   - What challenges did you encounter during the lab?

5. **Technical Documentation**
   - List of all applications installed during the lab
   - Any errors encountered and how you resolved them
   - Commands that were most useful

## Submission Format

- **File Type**: PDF or Markdown document
- **File Name**: `[YourStarID]-other-software-managers-lab.pdf` or `.md`
- **Submit To**: Linked assignment folder in Canvas/D2L
- **Due**: October 5, 2025 at 11:59 PM

## Technical Notes

### Helpful Commands

```bash
# Snap commands
snap version                    # Check snap version
snap find <search-term>        # Search for applications
sudo snap install <app>        # Install application
snap list                      # List installed snaps
sudo snap remove <app>         # Remove application
sudo snap refresh              # Update all snaps
snap info <app>                # View app information

# Flatpak commands
flatpak --version              # Check flatpak version
flatpak search <search-term>   # Search for applications
flatpak install <remote> <app> # Install application
flatpak list                   # List installed applications
flatpak uninstall <app>        # Remove application
flatpak update                 # Update all applications
flatpak info <app>             # View app information

# Traditional apt commands
apt search <search-term>       # Search for packages
sudo apt install <package>     # Install package
apt list --installed           # List installed packages
sudo apt remove <package>      # Remove package
sudo apt update && upgrade     # Update system
apt show <package>             # View package information
```

### Troubleshooting Tips

**Snap Issues:**
- If snapd service won't start: `sudo systemctl start snapd`
- If snap commands hang: Reboot the system
- Clear snap cache: `sudo rm -rf /var/lib/snapd/cache/*`

**Flatpak Issues:**
- If Flathub won't add: Check internet connection and retry
- Permission issues: Ensure you're using correct user permissions
- Application won't launch: Check `flatpak run <app-id>` for error messages

**General Issues:**
- Disk space problems: Check with `df -h` and remove unused packages
- Update failures: Run `sudo apt update` first to refresh repositories
- Permission errors: Ensure you're using `sudo` where required

### Additional Resources

- Snap Store: https://snapcraft.io/store
- Flathub: https://flathub.org
- Flatpak Documentation: https://docs.flatpak.org
- Ubuntu Package Management Guide: https://ubuntu.com/server/docs/package-management

## Academic Integrity

- Complete all work individually during the on-campus lab session
- Screenshots must be from your own system and terminal
- You may collaborate with classmates for troubleshooting but document your own work
- Ask the instructor for help if you encounter technical difficulties
- Submit your own original documentation and reflections

## Grading Criteria

- **Lab Completion** (40%): All activities completed with proper screenshots
- **Documentation Quality** (30%): Clear, organized, and complete submission
- **Technical Understanding** (20%): Comparison table and reflection responses
- **Professionalism** (10%): Following submission guidelines and formatting

---

*This lab assignment is designed to work with GitHub Copilot for enhanced learning support and academic workflow management. Started in-class, completed individually for submission.*

**Note**: This lab activity was initiated during the on-campus session with instructor guidance. Complete all documentation requirements and submit by the due date even though you started the activities in the classroom.
