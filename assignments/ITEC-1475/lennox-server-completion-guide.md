# Lennox Server Setup Lab Completion Guide - ITEC 1475

**Course**: ITEC 1475-80  
**Assignment**: Lennox Server Setup Lab  
**Time Needed**: 2-3 hours  

## Quick Start Checklist

### Pre-Lab Preparation
- [ ] Ensure you have access to a Linux system (Ubuntu Server/Desktop recommended)
- [ ] Have terminal access with sudo privileges  
- [ ] Verify internet connectivity for package downloads
- [ ] Create a folder for storing screenshots
- [ ] Have your StarID ready for server naming

### Lab Steps Progress Tracker

#### Step 1: Initial System Setup ⏱️ (~15 minutes)
- [ ] Run system update: `sudo apt update && sudo apt upgrade -y`
- [ ] Check system information: `hostnamectl` and `uname -a`
- [ ] **📸 Screenshot**: System update completion and info
- [ ] Note your current system version: ________________

#### Step 2: Configure Hostname and Network ⏱️ (~10 minutes)
- [ ] Set hostname: `sudo hostnamectl set-hostname lennox-server-<YourStarID>`
- [ ] Verify hostname: `hostnamectl`
- [ ] Check network: `ip addr show`
- [ ] **📸 Screenshot**: New hostname and network configuration
- [ ] Record your IP address: ________________

#### Step 3: Create Administrative User ⏱️ (~10 minutes)
- [ ] Create user: `sudo adduser serveradmin`
- [ ] Set secure password for new user
- [ ] Add to sudo group: `sudo usermod -aG sudo serveradmin`
- [ ] Verify user: `id serveradmin` and `groups serveradmin`
- [ ] **📸 Screenshot**: User creation and group assignment
- [ ] Username chosen: ________________

#### Step 4: Configure Basic Security ⏱️ (~20 minutes)
- [ ] Backup SSH config: `sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup`
- [ ] Check SSH settings: `sudo grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config`
- [ ] Install UFW: `sudo apt install ufw -y`
- [ ] Configure firewall rules:
  - [ ] `sudo ufw default deny incoming`
  - [ ] `sudo ufw default allow outgoing`
  - [ ] `sudo ufw allow ssh`
  - [ ] `sudo ufw enable`
- [ ] Check firewall status: `sudo ufw status verbose`
- [ ] **📸 Screenshot**: SSH config and firewall status

#### Step 5: Install Essential Services ⏱️ (~25 minutes)
- [ ] Install basic packages: `sudo apt install -y curl wget htop net-tools tree nano vim`
- [ ] Install Apache: `sudo apt install -y apache2`
- [ ] Enable Apache: `sudo systemctl enable apache2`
- [ ] Start Apache: `sudo systemctl start apache2`
- [ ] Check Apache status: `sudo systemctl status apache2`
- [ ] Test locally: `curl localhost`
- [ ] **📸 Screenshot**: Apache service status and local test

#### Step 6: Configure System Monitoring ⏱️ (~15 minutes)
- [ ] View system resources with `htop` (press Q to quit)
- [ ] Check disk usage: `df -h`
- [ ] Check memory: `free -h`
- [ ] View processes: `ps aux | head -10`
- [ ] Check recent logs: `sudo journalctl --since "1 hour ago" | head -20`
- [ ] **📸 Screenshot**: System resource information
- [ ] Note available disk space: ________________

#### Step 7: Create Server Documentation ⏱️ (~10 minutes)
- [ ] Create info file: `sudo nano /etc/server-info.txt`
- [ ] Add required information:
  - Server Name: ________________
  - Administrator: ________________
  - Setup Date: ________________
  - IP Address: ________________
  - OS Version: ________________
- [ ] Save and verify: `cat /etc/server-info.txt`
- [ ] **📸 Screenshot**: Completed server documentation

#### Step 8: Test Server Accessibility ⏱️ (~15 minutes)
- [ ] Test connectivity: `ping -c 3 google.com`
- [ ] Check active services: `sudo systemctl list-units --type=service --state=active | grep -E "apache2|ssh|ufw"`
- [ ] View listening ports: `sudo netstat -tlnp`
- [ ] Test user switching: `su - serveradmin` (then `whoami` and `exit`)
- [ ] **📸 Screenshot**: Connectivity tests and service verification

### Submission Preparation ⏱️ (~20 minutes)
- [ ] Organize all screenshots in chronological order
- [ ] Label each screenshot clearly with step numbers
- [ ] Create submission document with all requirements
- [ ] Include brief explanations showing understanding
- [ ] Double-check all screenshots are readable
- [ ] Verify all configuration details are documented
- [ ] Submit to appropriate assignment folder

## Common Commands Reference

| Task | Command | Purpose |
|------|---------|---------|
| Update system | `sudo apt update && sudo apt upgrade -y` | Update packages |
| Set hostname | `sudo hostnamectl set-hostname <name>` | Change server name |
| Check hostname | `hostnamectl` | Display hostname info |
| View network | `ip addr show` | Show IP configuration |
| Create user | `sudo adduser <username>` | Add new user account |
| Add to sudo | `sudo usermod -aG sudo <username>` | Grant admin privileges |
| Check user | `id <username>` | Show user information |
| Install packages | `sudo apt install -y <package>` | Install software |
| Check service | `sudo systemctl status <service>` | View service status |
| Enable service | `sudo systemctl enable <service>` | Auto-start service |
| Start service | `sudo systemctl start <service>` | Start service now |
| View disk usage | `df -h` | Show disk space |
| View memory | `free -h` | Show RAM usage |
| Test connectivity | `ping -c 3 <address>` | Network test |

## Troubleshooting Guide

### Common Issues and Solutions

**Issue**: Package installation fails  
**Solution**: Check internet connection, run `sudo apt update` first

**Issue**: Permission denied errors  
**Solution**: Use `sudo` for system commands, check user permissions

**Issue**: Service won't start  
**Solution**: Check logs with `sudo journalctl -u <service>`, verify configuration

**Issue**: Firewall blocks access  
**Solution**: Review rules with `sudo ufw status`, add necessary exceptions

**Issue**: User creation fails  
**Solution**: Ensure username is unique and follows naming conventions

**Issue**: Apache test returns error  
**Solution**: Verify service is running, check port 80 availability

**Issue**: Screenshots are unclear  
**Solution**: Use full-screen terminal, increase font size, capture complete output

### Getting Help

- Check system logs: `sudo journalctl -n 50`
- Search for error messages online
- Ask instructor for technical assistance
- Use Copilot for command explanations
- Review lab instructions carefully

## Success Tips

- Take screenshots immediately after each successful command
- Keep a terminal log of all commands used
- Document any customizations or variations
- Test each step before proceeding to the next
- Ask for help early if you encounter issues
- Keep your system running during group coordination phases

## Time Management

- **Morning Setup** (1 hour): Steps 1-3
- **Afternoon Configuration** (1 hour): Steps 4-6  
- **Evening Documentation** (30 minutes): Steps 7-8
- **Final Review** (30 minutes): Screenshot organization and submission

---

**Next Step**: Start with the [Lennox Server Setup Lab Instructions](lennox-server-setup.md) and begin with Step 1!

*This completion guide is designed to help you track progress efficiently and maintain academic workflow organization.*