# On-Campus vCenter Lab: Other Software Managers - ITEC 1475

**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Semester**: Fall 2025  
**Lab Type**: Linux Software Management  

## Lab Overview

The purpose of this lab is to review how software is installed and managed on Linux systems. In this lab you will:

- Review the basics of Debian and RedHat package managers
- Learn about additional software management and installation tools like:
  - Snap
  - Flatpak
  - AppImage
  - Containers (docker)
  - Bundled .tar or .tgz files
  - Source code or binary files

## Important Instructions - READ CAREFULLY

**Create a new document. Read through the lab below in full, every word, then go back to the top and take action (doing or typing something) where the text is highlighted. Answer questions in green text by copy-and-pasting the question from the lab into your document, then answer the question, possibly adding a requested screenshot. When you're done with the lab, submit your document to the appropriate assignment folder (see the bottom of this document).**

**Please carefully read each section BEFORE you take action. Everything you need to know is listed in each section. Some sections tell you exactly what to do, some sections are testing you on what you read in the textbook, and in some sections you may need to do more research (looking at man pages, looking at other chapters in your books, or even doing some Googling).**

## Connect to the ITEC vCenter Cluster

For this lab, you MUST use the ITEC vCenter cluster (possibly by first remotely connecting to an ITEC remote desktop system if your own system is underpowered). Please follow the instructions in the OpenVPN and Access the ITEC vCenter document to run OpenVPN and get connected (remember to authenticate to the vCenter with `mpls\starid` and your StarID password). Then use the vCenter web interface (or the VMware window) to connect to the vCenter cluster.

---

## Part 1: Traditional Package Managers Review

### Debian/Ubuntu Package Management (APT)

The Advanced Package Tool (APT) is the primary package manager for Debian-based systems like Ubuntu.

**Basic Commands:**
```bash
# Update package list
sudo apt update

# Upgrade all packages
sudo apt upgrade

# Install a package
sudo apt install <package-name>

# Remove a package
sudo apt remove <package-name>

# Search for packages
apt search <keyword>
```

📝 **Question 1**: What command would you use to search for available web server packages?

**Highlighted Action**: Update your system package list and take a screenshot showing the number of packages that can be upgraded.

```bash
sudo apt update
```

**📸 Screenshot Required**: Terminal showing `apt update` results

---

### RedHat/CentOS Package Management (YUM/DNF)

YUM (Yellowdog Updater Modified) and its successor DNF are used on RedHat-based systems.

**Basic Commands:**
```bash
# Update package list
sudo yum check-update  # or: sudo dnf check-update

# Install a package
sudo yum install <package-name>  # or: sudo dnf install <package-name>

# Remove a package
sudo yum remove <package-name>  # or: sudo dnf remove <package-name>

# Search for packages
yum search <keyword>  # or: dnf search <keyword>
```

📝 **Question 2**: What is the main difference between APT and YUM/DNF package managers?

---

## Part 2: Snap Package Manager

Snap is a software packaging and deployment system developed by Canonical (creators of Ubuntu). Snaps are self-contained packages that include all dependencies.

### Installing Snap

**Highlighted Action**: Check if snap is already installed:

```bash
snap --version
```

If not installed, install it:

```bash
sudo apt update
sudo apt install snapd
```

**📸 Screenshot Required**: Output of `snap --version`

### Using Snap

**Highlighted Action**: Search for and install a snap package:

```bash
# Search for packages
snap find <application-name>

# Install a snap package
sudo snap install <package-name>

# List installed snaps
snap list
```

**Practice Task**: Install the `hello-world` snap to test the system:

```bash
sudo snap install hello-world
hello-world
```

**📸 Screenshot Required**: Output showing hello-world snap installation and execution

📝 **Question 3**: What are two advantages of using Snap packages compared to traditional package managers?

---

## Part 3: Flatpak Package Manager

Flatpak is another universal package manager for Linux, similar to Snap but with different architecture and sandboxing approach.

### Installing Flatpak

**Highlighted Action**: Install Flatpak on your system:

```bash
sudo apt install flatpak
```

Add the Flathub repository (main Flatpak repository):

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

**📸 Screenshot Required**: Terminal showing successful Flatpak installation

### Using Flatpak

```bash
# Search for applications
flatpak search <application-name>

# Install an application
flatpak install flathub <application-id>

# List installed applications
flatpak list

# Run a Flatpak application
flatpak run <application-id>

# Update all applications
flatpak update
```

**Practice Task**: Search for a text editor application using Flatpak:

```bash
flatpak search text editor
```

**📸 Screenshot Required**: Results from flatpak search command

📝 **Question 4**: How do Flatpak and Snap differ in their approach to application sandboxing?

---

## Part 4: AppImage

AppImage is a format for distributing portable software on Linux. AppImages are self-contained executables that don't require installation.

### Understanding AppImage

AppImages are single executable files that contain the application and all its dependencies. They can be downloaded and run directly without installation.

📝 **Question 5**: What makes AppImage different from Snap and Flatpak?

### Using AppImage

**Highlighted Action**: Download and run an AppImage (example with a small test application):

1. Download an AppImage file (your instructor may provide a specific example)
2. Make it executable:
   ```bash
   chmod +x <application-name>.AppImage
   ```
3. Run it:
   ```bash
   ./<application-name>.AppImage
   ```

**Note**: AppImages do not auto-update. You must manually download newer versions.

📝 **Question 6**: In what scenarios would an AppImage be more useful than a Snap or Flatpak package?

---

## Part 5: Docker Containers

Docker is a containerization platform that packages applications and their dependencies into containers.

### Understanding Docker

Docker containers are lightweight, isolated environments that run applications. Unlike virtual machines, containers share the host system's kernel.

📝 **Question 7**: What is the primary difference between a Docker container and a virtual machine?

### Installing Docker

**Highlighted Action**: Install Docker on your system:

```bash
# Install prerequisites
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common

# Add Docker's GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# Verify installation
sudo docker --version
```

**📸 Screenshot Required**: Output of `docker --version`

### Basic Docker Commands

```bash
# Run a test container
sudo docker run hello-world

# List running containers
sudo docker ps

# List all containers (including stopped)
sudo docker ps -a

# Pull an image
sudo docker pull <image-name>

# Remove a container
sudo docker rm <container-id>
```

**Practice Task**: Run the hello-world Docker container:

```bash
sudo docker run hello-world
```

**📸 Screenshot Required**: Output from running hello-world container

📝 **Question 8**: Why might you choose to run an application in a Docker container rather than installing it directly on the host system?

---

## Part 6: Tarball Archives (.tar, .tgz)

Many Linux applications are distributed as compressed archives (tarballs) that must be manually extracted and installed.

### Working with Tarballs

**Common Extensions:**
- `.tar` - Uncompressed archive
- `.tar.gz` or `.tgz` - Gzip compressed archive
- `.tar.bz2` - Bzip2 compressed archive
- `.tar.xz` - XZ compressed archive

**Highlighted Action**: Practice extracting and exploring a tarball:

```bash
# Create a test tarball
mkdir test-app
echo "Application files" > test-app/readme.txt
tar -czf test-app.tar.gz test-app/

# Extract tar.gz archive
tar -xzf test-app.tar.gz

# List contents without extracting
tar -tzf test-app.tar.gz
```

**📸 Screenshot Required**: Terminal showing tarball creation and extraction

**Common Extraction Commands:**
```bash
# Extract .tar
tar -xf archive.tar

# Extract .tar.gz or .tgz
tar -xzf archive.tar.gz

# Extract .tar.bz2
tar -xjf archive.tar.bz2

# Extract .tar.xz
tar -xJf archive.tar.xz
```

📝 **Question 9**: After extracting a tarball, what file(s) should you look for to find installation instructions?

---

## Part 7: Source Code and Binary Installation

### Installing from Source Code

Some applications must be compiled from source code.

**Typical Process:**
1. Install build tools and dependencies
2. Extract source code
3. Configure the build
4. Compile the source
5. Install the compiled program

**Highlighted Action**: Install basic build tools:

```bash
sudo apt update
sudo apt install build-essential
```

**Common Build Process:**
```bash
# After extracting source code, typically:
./configure
make
sudo make install
```

📝 **Question 10**: What command installs the compiler and build tools needed to compile programs from source?

**📸 Screenshot Required**: Terminal showing build-essential installation

### Binary Installation

Pre-compiled binaries can be downloaded and executed directly.

**Steps:**
1. Download the binary file
2. Make it executable: `chmod +x binary-file`
3. Optionally move to `/usr/local/bin/` for system-wide access

📝 **Question 11**: Why might you prefer installing a pre-compiled binary over compiling from source?

---

## Part 8: Package Manager Comparison

📝 **Question 12**: Create a comparison table showing the advantages and disadvantages of each package management method covered in this lab. Consider factors like: ease of use, dependency management, system integration, portability, security updates, and disk space usage.

**Your table should include:**
- APT/YUM
- Snap
- Flatpak
- AppImage
- Docker
- Tarball
- Source Code

---

## Part 9: Reflection Questions

📝 **Question 13**: Based on what you learned in this lab, which software installation method would you recommend for:
- A system administrator managing multiple servers?
- A developer testing software on different Linux distributions?
- A user who wants the latest version of an application not in their distribution's repositories?

📝 **Question 14**: What security considerations should you keep in mind when installing software from different sources?

📝 **Question 15**: Reflect on the instruction at the beginning of this lab to "Read through the lab below in full, every word, then go back to the top and take action." Why do you think this instruction was given? Provide at least three specific examples from this lab where reading ahead before taking action would have been beneficial.

---

## Submission Requirements

### Documentation Checklist

- [ ] All 15 questions answered in your document
- [ ] Screenshot of `apt update` results
- [ ] Screenshot of `snap --version`
- [ ] Screenshot of hello-world snap installation
- [ ] Screenshot of Flatpak installation
- [ ] Screenshot of flatpak search results
- [ ] Screenshot of `docker --version`
- [ ] Screenshot of hello-world Docker container
- [ ] Screenshot of tarball operations
- [ ] Screenshot of build-essential installation
- [ ] Comparison table completed
- [ ] All reflection questions answered with thoughtful responses

### Submission Format

1. **Create a comprehensive document** with all questions and answers
2. **Copy-paste each question** from this lab before answering
3. **Insert screenshots** at appropriate locations
4. **Label all screenshots** clearly
5. **Submit document** to the vCenter Lab: Software Managers assignment folder

### Grading Criteria

- **Questions (60%)**: Complete and accurate answers to all 15 questions
- **Screenshots (25%)**: All required screenshots included and clearly labeled
- **Reflection (15%)**: Thoughtful analysis of software management methods and the "read first" instruction

---

## Technical Notes

### Why Read First?

This lab intentionally asks you to read everything before taking action because:

1. **Context matters**: Later sections may clarify or modify earlier instructions
2. **Resource planning**: You need to know what resources (disk space, time, permissions) are required
3. **Dependency awareness**: Some steps depend on others being completed in a specific order
4. **Avoiding mistakes**: Understanding the full scope prevents having to undo work
5. **Time management**: Knowing the full lab helps you plan your work session

**Notice**: In this lab, if you started installing packages without reading ahead, you might have:
- Missed important prerequisites
- Installed packages in the wrong order
- Wasted time on trial and error
- Overlooked critical security considerations

### Additional Resources

- APT documentation: `man apt`
- Snap documentation: https://snapcraft.io/docs
- Flatpak documentation: https://docs.flatpak.org
- Docker documentation: https://docs.docker.com
- AppImage documentation: https://appimage.org

---

*This lab assignment is designed to work with GitHub Copilot for enhanced learning support and academic workflow management.*
