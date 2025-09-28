# Lennox Server Setup Lab - ITEC 1475

**Course**: ITEC 1475-80  
**Instructor**: Brian Huilman  
**Semester**: Fall 2025  
**Lab Type**: Server Configuration and Network Services  

## Lab Overview

This lab introduces you to Lennox server setup and configuration. You will learn essential server administration skills including initial server configuration, network setup, basic security hardening, and service management. This is a beginner-friendly lab designed to build foundational server management competencies.

## Learning Objectives

- Understand basic server hardware and software requirements
- Configure initial server network settings
- Set up user accounts and basic security measures
- Install and configure essential server services
- Perform basic server monitoring and maintenance tasks
- Document server configuration for future reference

## Prerequisites

- Basic Linux command line knowledge
- Access to a Linux system (Ubuntu Server 20.04 LTS or newer recommended)
- Administrative (sudo) privileges
- Network connectivity for package installation

## Step-by-Step Instructions

### 1. Initial System Setup

Start by updating your system and setting basic configuration:

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Check system information
hostnamectl
uname -a
```

**📸 Screenshot Required**: Take a screenshot showing the system update completion and system information.

---

### 2. Configure Server Hostname and Network

Set up your server with a meaningful hostname:

```bash
# Set server hostname (replace 'lennox-server' with your preferred name)
sudo hostnamectl set-hostname lennox-server-<YourStarID>

# Verify hostname change
hostnamectl

# Check network configuration
ip addr show
```

**Replace `<YourStarID>` with your actual StarID** to create a unique server name.

**📸 Screenshot Required**: Take a screenshot showing the new hostname and network configuration.

---

### 3. Create Administrative User Account

Set up a dedicated administrative user for server management:

```bash
# Create new user (replace 'serveradmin' with your preferred username)
sudo adduser serveradmin

# Add user to sudo group for administrative privileges
sudo usermod -aG sudo serveradmin

# Verify user creation and group membership
id serveradmin
groups serveradmin
```

**📸 Screenshot Required**: Take a screenshot showing successful user creation and group assignment.

---

### 4. Configure Basic Security Settings

Implement essential security measures:

```bash
# Update SSH configuration for better security
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Check current SSH configuration
sudo grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config

# Install and configure UFW firewall
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

# Check firewall status
sudo ufw status verbose
```

**📸 Screenshot Required**: Take a screenshot showing the SSH configuration and firewall status.

---

### 5. Install Essential Server Services

Install and configure basic server services:

```bash
# Install essential packages
sudo apt install -y curl wget htop net-tools tree nano vim

# Install web server (Apache)
sudo apt install -y apache2

# Enable and start Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Check service status
sudo systemctl status apache2

# Test web server locally
curl localhost
```

**📸 Screenshot Required**: Take a screenshot showing Apache service status and the local web server test.

---

### 6. Configure System Monitoring

Set up basic system monitoring tools:

```bash
# Check system resources
htop &
# Press Q to quit htop after viewing

# Check disk usage
df -h

# Check memory usage
free -h

# Check running processes
ps aux | head -10

# Check system logs
sudo journalctl --since "1 hour ago" | head -20
```

**📸 Screenshot Required**: Take a screenshot showing system resource information (disk, memory, processes).

---

### 7. Create Server Documentation

Document your server configuration:

```bash
# Create a server info file
sudo nano /etc/server-info.txt
```

**Add the following information to the file:**
```
Lennox Server Configuration
===========================
Server Name: [Your Server Hostname]
Administrator: [Your Name/StarID]
Setup Date: [Current Date]
IP Address: [Your Server IP]
OS Version: [Ubuntu Version]
Services Installed: Apache2, UFW Firewall
```

**Save and verify:**
```bash
# Save and exit nano (Ctrl+X, Y, Enter)

# Verify the file
cat /etc/server-info.txt
```

**📸 Screenshot Required**: Take a screenshot showing the completed server documentation file.

---

### 8. Test Server Accessibility

Verify that your server is properly configured and accessible:

```bash
# Test network connectivity
ping -c 3 google.com

# Check all active services
sudo systemctl list-units --type=service --state=active | grep -E "apache2|ssh|ufw"

# Check listening ports
sudo netstat -tlnp

# Verify user can switch to administrative account
su - serveradmin
# (Enter password when prompted)
whoami
exit
```

**📸 Screenshot Required**: Take a screenshot showing successful connectivity tests and service status.

---

## Submission Requirements

### Documentation Checklist

- [ ] Screenshot of system update and system information
- [ ] Screenshot of hostname configuration and network settings
- [ ] Screenshot of user account creation and group assignment
- [ ] Screenshot of SSH configuration and firewall setup
- [ ] Screenshot of Apache service installation and status
- [ ] Screenshot of system resource monitoring information
- [ ] Screenshot of server documentation file
- [ ] Screenshot of connectivity and service verification tests
- [ ] All screenshots clearly labeled and organized
- [ ] Document submitted to appropriate assignment folder

### Submission Format

1. **Organize all screenshots** into a single document with clear section headers
2. **Include configuration details** such as chosen hostnames and usernames
3. **Add brief explanations** for each step showing understanding
4. **Ensure screenshots are readable** and show complete terminal output
5. **Submit document** to the Lennox Server Setup assignment folder

## Technical Notes

### Commands Reference

| Command | Purpose |
|---------|---------|
| `sudo apt update` | Update package lists |
| `sudo apt upgrade` | Upgrade installed packages |
| `hostnamectl` | Display/set system hostname |
| `sudo adduser <username>` | Create new user account |
| `sudo usermod -aG sudo <username>` | Add user to sudo group |
| `sudo ufw enable` | Enable UFW firewall |
| `sudo systemctl status <service>` | Check service status |
| `df -h` | Display disk usage |
| `free -h` | Display memory usage |
| `sudo netstat -tlnp` | Show listening ports |

### Troubleshooting Tips

- **Package installation fails**: Check internet connectivity and try `sudo apt update` first
- **Permission denied errors**: Ensure you're using `sudo` for system-level commands
- **Service won't start**: Check service logs with `sudo journalctl -u <service-name>`
- **Firewall blocks connections**: Review UFW rules with `sudo ufw status numbered`
- **User creation fails**: Ensure username doesn't already exist and follows naming conventions
- **Apache test fails**: Check if service is running and no other service is using port 80

### Security Considerations

- **Change default passwords**: Always use strong, unique passwords for new accounts
- **Regular updates**: Keep system and packages updated with security patches
- **Firewall rules**: Only open necessary ports and services
- **User privileges**: Follow principle of least privilege for user accounts
- **Log monitoring**: Regularly check system logs for unusual activity

## Academic Integrity

- Complete all work individually and demonstrate your own understanding
- Screenshots must be from your own server setup
- Document any challenges encountered and how you resolved them
- Ask instructor for help if you encounter technical difficulties
- Collaborate appropriately by sharing knowledge, not copying work

## Additional Resources

### Recommended Reading
- Ubuntu Server Guide: [https://ubuntu.com/server/docs](https://ubuntu.com/server/docs)
- Linux System Administration basics
- Network security fundamentals

### Next Steps
After completing this lab, you'll be prepared for:
- Advanced server configuration labs
- Web server management assignments
- Database server setup
- Network services configuration

---

*This lab assignment is designed to work with GitHub Copilot for enhanced learning support and academic workflow management. Feel free to ask Copilot for explanations of commands or troubleshooting assistance.*