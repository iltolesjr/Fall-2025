# Lennox Lab Output Interpretation Guide

**Quick Reference for Understanding collect_lennox_outputs.sh Results**

---

## How to Read Your Output File

When you run `collect_lennox_outputs.sh`, it creates a file called `lennox-lab-outputs.txt` that contains the results of various system checks. This guide helps you understand what each section means and whether your output indicates success or problems.

---

## Section-by-Section Interpretation

### 1. Hostnamectl Output

**What to Look For:**
```
Static hostname: lennox-server-[YourStarID]
Operating System: Linux Mint 22.1 (or Ubuntu Server XX.XX)
Kernel: Linux X.X.X-XX-generic
Architecture: x86-64
```

**✅ Good Output:**
- Hostname shows `lennox-server-` followed by your StarID
- Operating System shows Linux Mint or Ubuntu
- Kernel version is displayed
- Architecture is x86-64

**❌ Problem Indicators:**
- Hostname is still default (like `ubuntu` or `mint`)
- Missing any of the key information fields

**Action if Problem:**
```bash
sudo hostnamectl set-hostname lennox-server-[YourStarID]
```

---

### 2. Network Information (ip addr show)

**What to Look For:**
```
inet [IP-ADDRESS]/24 brd [BROADCAST] scope global dynamic
```

**✅ Good Output:**
- Shows an IP address (like `10.14.75.235/24` or `192.168.1.100/24`)
- Interface is UP (shows `UP,LOWER_UP` in angle brackets)
- Both inet (IPv4) and inet6 (IPv6) addresses present

**❌ Problem Indicators:**
- No IP address shown
- Interface shows DOWN
- Only loopback (127.0.0.1) address visible

**What It Means:**
- Your network connection is working if you see a real IP address
- The `/24` indicates your subnet mask (255.255.255.0)

---

### 3. User Account Check (id serveradmin)

**✅ Good Output:**
```
uid=1001(serveradmin) gid=1001(serveradmin) groups=1001(serveradmin),27(sudo)
```

**Interpretation:**
- User exists with a UID (user ID)
- User is in the `sudo` group (shows `,27(sudo)` or similar)
- This means the user has administrative privileges

**❌ Problem Output:**
```
serveradmin user not found
```

**What to Do:**
```bash
sudo adduser serveradmin
sudo usermod -aG sudo serveradmin
```

---

### 4. SSH Configuration

**✅ Good Output:**
```
PermitRootLogin prohibit-password
PasswordAuthentication yes
Port 22
```

**Interpretation:**
- SSH server is installed and configured
- Root login is restricted (good security practice)
- Password authentication is enabled
- SSH is running on standard port 22

**❌ Problem Output:**
```
grep: /etc/ssh/sshd_config: No such file or directory
```

**What This Means:**
- SSH server (openssh-server) is not installed
- You need to install it to complete the lab

**Action:**
```bash
sudo apt install openssh-server -y
```

---

### 5. UFW Firewall Status

**✅ Good Output:**
```
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere
80/tcp                     ALLOW       Anywhere
```

**Interpretation:**
- Firewall is enabled and active
- SSH (port 22) is allowed through firewall
- HTTP (port 80) is allowed for web server
- Security rules are properly configured

**⚠️ Warning Output:**
```
ERROR: You need to be root to run this script
```

**What This Means:**
- The collection script was NOT run with `sudo`
- Many commands won't show complete information without root access
- **Solution**: Re-run with `sudo ./collect_lennox_outputs.sh`

**❌ Problem Output:**
```
Status: inactive
```

**What to Do:**
```bash
sudo ufw enable
```

---

### 6. Apache Web Server Status

**✅ Good Output:**
```
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled)
     Active: active (running) since [date]
```

**Interpretation:**
- Apache is installed
- Service is enabled (will start automatically on boot)
- Service is currently running
- Web server is operational

**❌ Problem Output:**
```
Unit apache2.service could not be found.
```

**What This Means:**
- Apache is not installed
- This is a required service for the lab

**Action:**
```bash
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
```

---

### 7. Local Web Server Test (curl localhost)

**✅ Good Output:**
```
HTTP/1.1 200 OK
Date: [current date]
Server: Apache/2.4.XX (Ubuntu)
Content-Type: text/html
```

**Interpretation:**
- Web server is responding correctly
- HTTP status 200 means "OK" - successful request
- Apache is serving web pages
- Server is working properly

**❌ Problem Output:**
```
curl: (7) Failed to connect to localhost port 80
```

**What This Means:**
- Apache is either not installed or not running
- Port 80 is not accepting connections

**Action:**
```bash
sudo systemctl start apache2
# Then test again
curl -I localhost
```

---

### 8. Disk Space (df -h)

**What to Look For:**
```
/dev/sda2        31G   12G   18G  40% /
```

**✅ Good Output:**
- Root partition (/) has available space
- Usage is below 80%
- Multiple GB available

**⚠️ Warning Signs:**
- Usage above 90% - may need to clean up
- Less than 1GB available - disk is nearly full

**What the Numbers Mean:**
- `31G` = Total disk size
- `12G` = Used space
- `18G` = Available space
- `40%` = Percentage used

---

### 9. Memory Usage (free -h)

**What to Look For:**
```
              total        used        free      shared  buff/cache   available
Mem:          2.9Gi       1.8Gi       382Mi        68Mi       1.0Gi       1.1Gi
```

**✅ Good Output:**
- System has at least 1GB total RAM
- Available memory is at least 500MB
- System is not swapping excessively

**Interpretation:**
- `total` = Total RAM installed
- `used` = RAM currently in use by programs
- `available` = RAM available for new programs (most important number)

**⚠️ Warning Signs:**
- Available memory below 100MB
- Swap usage is high (multiple GB)
- System may be slow or unresponsive

---

### 10. Server Documentation File

**✅ Good Output:**
```
Lennox Server Configuration
===========================
Server Name: lennox-server-[YourStarID]
Administrator: [Your Name / StarID]
Setup Date: 2025-10-28
IP Address: 10.14.75.235
OS Version: Linux Mint 22.1
Services Installed: Apache2, UFW, SSH
```

**Interpretation:**
- Documentation file exists
- All required information is present
- Server is properly documented

**❌ Problem Output:**
```
/etc/server-info.txt not found
```

**What to Do:**
Create the file with all required information (see lab instructions).

---

### 11. Network Connectivity Test (ping)

**✅ Good Output:**
```
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 13.5/13.5/13.8/0.16 ms
```

**Interpretation:**
- Internet connection is working
- 0% packet loss means reliable connection
- Response times under 100ms are good

**❌ Problem Output:**
```
3 packets transmitted, 0 received, 100% packet loss
```

**What This Means:**
- No internet connectivity
- DNS or routing problems
- Check network configuration

---

### 12. Active Services Check

**✅ Good Output:**
```
apache2.service     loaded active running   The Apache HTTP Server
ssh.service         loaded active running   OpenBSD Secure Shell server
ufw.service         loaded active exited    Uncomplicated firewall
```

**Interpretation:**
- All required services are running
- Apache (web server) is active
- SSH (remote access) is active
- UFW (firewall) is configured (exited status is normal)

**❌ Problem Output:**
```
(no output or only one service listed)
```

**What This Means:**
- Required services are not installed or not running
- Need to complete installation steps

---

### 13. Listening Ports (netstat)

**✅ Good Output:**
```
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -
```

**Interpretation:**
- Port 22 (SSH) is listening for connections
- Port 80 (HTTP) is listening for web requests
- Server is ready to accept connections

**⚠️ Note:**
```
ERROR: You need to be root to run this script
```
This appears when script is not run with sudo - shows limited information only.

---

## Common Output Patterns

### Pattern 1: Script Not Run with Sudo

**Indicators:**
- Multiple "ERROR: You need to be root" messages
- "Permission denied" errors
- Limited information in various sections

**Solution:**
```bash
sudo ./collect_lennox_outputs.sh
```

---

### Pattern 2: Fresh System (Nothing Installed)

**Indicators:**
- "serveradmin user not found"
- "apache2.service could not be found"
- "No such file or directory" for /etc/ssh/sshd_config
- "/etc/server-info.txt not found"

**What This Means:**
- System is in initial state
- Lab steps have not been completed yet
- This is normal if you're just starting

**Action:**
Follow the lab instructions from Step 1 through Step 8.

---

### Pattern 3: Partially Complete Lab

**Indicators:**
- Some services found, others missing
- Mix of success and "not found" messages
- User may or may not exist

**What This Means:**
- You've started the lab but haven't completed all steps
- Need to continue from where you left off

**Action:**
Review the feedback document to see which steps are incomplete.

---

### Pattern 4: Fully Completed Lab

**Indicators:**
- ✅ Hostname is set to lennox-server-[StarID]
- ✅ serveradmin user exists and is in sudo group
- ✅ SSH config shows settings (no "not found" error)
- ✅ UFW status shows "active" with rules
- ✅ Apache status shows "active (running)"
- ✅ curl localhost shows HTTP 200 response
- ✅ Server-info.txt file exists with complete information
- ✅ All services are listed as active

**What This Means:**
- Lab is complete!
- Ready for screenshot capture and submission
- All required components are installed and configured

---

## Quick Troubleshooting

### Issue: "command not found" errors

**Possible Causes:**
- Package not installed
- Typo in command name
- Need to use sudo

**Solution:**
```bash
sudo apt update
sudo apt install [missing-package]
```

---

### Issue: Service won't start

**Check the logs:**
```bash
sudo journalctl -u [service-name] -n 50
```

**Common fixes:**
```bash
# Restart the service
sudo systemctl restart [service-name]

# Check if port is already in use
sudo netstat -tlnp | grep [port-number]
```

---

### Issue: Network connectivity problems

**Check basic connectivity:**
```bash
# Check if interface is up
ip addr show

# Check default gateway
ip route show

# Test DNS resolution
nslookup google.com
```

---

## Summary: What Makes Good Output?

A complete and successful `lennox-lab-outputs.txt` file should show:

1. ✅ Custom hostname with your StarID
2. ✅ Network configuration with valid IP address
3. ✅ serveradmin user in sudo group
4. ✅ SSH configuration file exists and shows settings
5. ✅ UFW firewall is active with proper rules
6. ✅ Apache service is active and running
7. ✅ curl localhost returns HTTP 200
8. ✅ Adequate disk space and memory available
9. ✅ Server-info.txt file exists with documentation
10. ✅ All required services are listed as active
11. ✅ Network connectivity test passes
12. ✅ No "Permission denied" or "need to be root" errors

**If any of these are not present in your output, review the corresponding lab step and complete it.**

---

## Using This Guide

1. Run your collection script: `sudo ./collect_lennox_outputs.sh`
2. Open the generated `lennox-lab-outputs.txt` file
3. Go through each section in this guide
4. Compare your output to the examples
5. Identify any problems or missing components
6. Complete the required steps to fix issues
7. Re-run the collection script to verify completion

---

**Need More Help?**
- Review `lennox-output-analysis-feedback.md` for personalized analysis
- Check `lennox-server-completion-guide.md` for step-by-step instructions
- Ask instructor for assistance with specific errors
- Use GitHub Copilot to explain unfamiliar commands

---

*This guide helps you become self-sufficient in understanding system output and diagnosing configuration issues - important skills for server administration.*
