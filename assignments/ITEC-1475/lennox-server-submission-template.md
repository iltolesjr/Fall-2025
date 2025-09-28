# Lennox Server Setup Lab Submission

**Student Name**: [Your Name]  
**StarID**: [Your StarID]  
**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Date Completed**: [Completion Date]  

## Lab Completion Summary

### Server Configuration Details ✅
- **Server Hostname**: [Your chosen hostname]
- **Administrator Username**: [Username you created]
- **IP Address**: [Your server IP address]
- **Operating System**: [Ubuntu version/details]
- **Services Installed**: Apache2, UFW Firewall, Essential packages

### Requirements Met ✅
- [x] System updated and configured
- [x] Server hostname set with StarID
- [x] Administrative user account created
- [x] Basic security measures implemented
- [x] Essential server services installed
- [x] System monitoring tools configured
- [x] Server documentation created
- [x] Connectivity and accessibility verified
- [x] All required screenshots captured and labeled

---

## Screenshot Documentation

### Step 1: Initial System Setup ✅
**Commands Used**: 
- `sudo apt update && sudo apt upgrade -y`
- `hostnamectl`
- `uname -a`

**Screenshot 1**: System update completion and system information
![System Setup Screenshot](screenshots/01-system-setup.png)

**System Details Noted**:
- OS Version: [Your OS version]
- Kernel Version: [Kernel version]
- Architecture: [System architecture]

---

### Step 2: Hostname and Network Configuration ✅
**Commands Used**: 
- `sudo hostnamectl set-hostname lennox-server-<StarID>`
- `hostnamectl`
- `ip addr show`

**Screenshot 2**: New hostname and network configuration
![Hostname Network Screenshot](screenshots/02-hostname-network.png)

**Configuration Details**:
- New Hostname: [Your hostname]
- IP Address: [Your IP]
- Network Interface: [Primary interface name]

---

### Step 3: Administrative User Creation ✅
**Commands Used**: 
- `sudo adduser serveradmin`
- `sudo usermod -aG sudo serveradmin`
- `id serveradmin`
- `groups serveradmin`

**Screenshot 3**: User account creation and group assignment
![User Creation Screenshot](screenshots/03-user-creation.png)

**User Account Details**:
- Username: [Your chosen username]
- Groups: [Listed groups]
- UID: [User ID number]

---

### Step 4: Basic Security Configuration ✅
**Commands Used**: 
- `sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup`
- `sudo grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config`
- `sudo apt install ufw -y`
- `sudo ufw default deny incoming`
- `sudo ufw default allow outgoing`
- `sudo ufw allow ssh`
- `sudo ufw enable`
- `sudo ufw status verbose`

**Screenshot 4**: SSH configuration and firewall setup
![Security Configuration Screenshot](screenshots/04-security-config.png)

**Security Measures Implemented**:
- SSH backup configuration created
- UFW firewall enabled and configured
- Default policies set (deny incoming, allow outgoing)
- SSH access allowed through firewall

---

### Step 5: Essential Services Installation ✅
**Commands Used**: 
- `sudo apt install -y curl wget htop net-tools tree nano vim`
- `sudo apt install -y apache2`
- `sudo systemctl enable apache2`
- `sudo systemctl start apache2`
- `sudo systemctl status apache2`
- `curl localhost`

**Screenshot 5**: Apache service installation and status
![Services Installation Screenshot](screenshots/05-services-install.png)

**Services Configured**:
- Apache2 web server installed and running
- Essential administrative tools installed
- Service auto-start enabled
- Local web server test successful

---

### Step 6: System Monitoring Configuration ✅
**Commands Used**: 
- `htop` (viewed and quit)
- `df -h`
- `free -h`
- `ps aux | head -10`
- `sudo journalctl --since "1 hour ago" | head -20`

**Screenshot 6**: System resource monitoring information
![System Monitoring Screenshot](screenshots/06-system-monitoring.png)

**System Resources Observed**:
- Available Disk Space: [Amount available]
- Memory Usage: [RAM usage details]
- Active Processes: [Number of processes]
- Recent System Activity: [Log entries noted]

---

### Step 7: Server Documentation Creation ✅
**Commands Used**: 
- `sudo nano /etc/server-info.txt`
- `cat /etc/server-info.txt`

**Screenshot 7**: Completed server documentation file
![Server Documentation Screenshot](screenshots/07-server-documentation.png)

**Documentation Contents**:
- Server name and purpose clearly documented
- Administrator contact information included
- Setup date and configuration details recorded
- Service inventory maintained

---

### Step 8: Server Accessibility Testing ✅
**Commands Used**: 
- `ping -c 3 google.com`
- `sudo systemctl list-units --type=service --state=active | grep -E "apache2|ssh|ufw"`
- `sudo netstat -tlnp`
- `su - serveradmin` (followed by `whoami` and `exit`)

**Screenshot 8**: Connectivity and service verification tests
![Accessibility Testing Screenshot](screenshots/08-accessibility-testing.png)

**Test Results**:
- Internet connectivity: [Successful/Details]
- Critical services running: [Apache2, SSH, UFW status]
- Network ports listening: [Port numbers and services]
- User account access: [Successful login verification]

---

## Technical Skills Demonstrated

### Linux System Administration
- Package management with apt
- Service management with systemctl
- User account administration
- File system navigation and editing
- Network configuration analysis

### Security Implementation
- Firewall configuration with UFW
- SSH security assessment
- User privilege management
- System backup procedures
- Access control implementation

### Server Configuration
- Web server installation and configuration
- System monitoring tool setup
- Documentation and inventory management
- Network connectivity testing
- Service status verification

### Problem-Solving Approach
- Systematic approach to server setup
- Command verification and testing
- Error checking and troubleshooting
- Documentation for future reference
- Security-conscious configuration

---

## Challenges Encountered and Solutions

### Challenge 1: [Describe any technical challenges you faced]
**Solution**: [How you resolved the issue]

### Challenge 2: [Any configuration or command issues]
**Solution**: [Steps taken to fix the problem]

### Challenge 3: [Network or service related challenges]
**Solution**: [Troubleshooting approach used]

---

## Learning Outcomes Achieved

### Technical Knowledge Gained
- Understanding of Linux server setup procedures
- Experience with system security configuration
- Familiarity with service management commands
- Network configuration and testing skills
- Documentation best practices

### Skills Applied
- Command line proficiency
- System administration fundamentals
- Security-conscious configuration
- Troubleshooting methodology
- Academic documentation standards

---

## Submission Checklist ✅
- [x] All 8 required screenshots included and clearly labeled
- [x] Screenshots show complete terminal output and are readable
- [x] Server configuration details documented accurately
- [x] Technical challenges and solutions described
- [x] Learning outcomes and skills demonstrated
- [x] Document formatting professional and organized
- [x] All lab requirements met per assignment instructions

---

**Submission Notes**: [Any additional comments about the lab experience or technical insights gained]

**Time Invested**: [Estimated hours spent on lab completion]

**Overall Experience**: [Brief reflection on the learning experience]

---

*This submission follows the requirements outlined in the Lennox Server Setup Lab assignment for ITEC 1475-80. All work completed individually with documentation of personal learning and technical achievement.*