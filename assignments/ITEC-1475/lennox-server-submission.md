# Lennox Server Setup — Submission Document

Student: [Your Name / StarID]  
Course: ITEC 1475-80  
Assignment: Lennox Server Setup Lab  
Date: [YYYY-MM-DD]

---

## Quick instructions

1. Run the commands below on your Linux server (Ubuntu recommended).
2. Take screenshots for each required step (guidance below).
3. Save screenshots in a folder named `lennox-screenshots` and name them by step (e.g., `step1-update.png`).
4. Fill in the boxes below with short explanations and paste the screenshot filenames.
5. Zip the screenshots and this file and upload to the assignment folder.

---

## Commands to run (copy/paste into your server terminal)

## Step 1 — Initial system update & info

```bash
sudo apt update && sudo apt upgrade -y
hostnamectl
uname -a
```

Capture: full terminal showing update finished and `hostnamectl` output.

## Step 2 — Hostname and network

Replace [YourStarID] below with your StarID before running.

```bash
sudo hostnamectl set-hostname lennox-server-[YourStarID]
hostnamectl
ip addr show
```

Capture: `hostnamectl` showing new hostname and `ip addr show` showing IP address.

 
## Step 3 — Create administrative user

```bash
# change 'serveradmin' if you prefer another name
sudo adduser serveradmin
sudo usermod -aG sudo serveradmin
id serveradmin
groups serveradmin
```

Capture: `id` and `groups` output showing sudo membership.

## Step 4 — SSH backup and UFW firewall

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
sudo grep -E "PermitRootLogin|PasswordAuthentication|Port" /etc/ssh/sshd_config
sudo apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
sudo ufw status verbose
```

Capture: SSH grep output and `ufw status verbose`.

## Step 5 — Install services (Apache + utilities)

```bash
sudo apt install -y curl wget htop net-tools tree nano vim
sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2 --no-pager
curl -I localhost
```

Capture: `systemctl status apache2` and `curl -I localhost` response headers.

df -h
## Step 6 — Monitoring and logs

```bash
htop    # interactively view, press Q to quit
df -h
free -h
ps aux | head -15
sudo journalctl --since "1 hour ago" | head -30
```

Capture: outputs of `df -h`, `free -h`, and a snippet of `journalctl` showing no critical errors.

 
## Step 7 — Server documentation file

```bash
sudo bash -c 'cat > /etc/server-info.txt <<EOF
Lennox Server Configuration
===========================
Server Name: $(hostname)
Administrator: [Your Name / StarID]
Setup Date: $(date +%F)
IP Address: $(hostname -I | awk "{print \$1}")
OS Version: $(lsb_release -ds 2>/dev/null || uname -mrs)
Services Installed: Apache2, UFW
EOF'

sudo cat /etc/server-info.txt
```

Capture: output of `cat /etc/server-info.txt`.

 
## Step 8 — Connectivity & verification

```bash
ping -c 3 google.com
sudo systemctl list-units --type=service --state=active | grep -E "apache2|ssh|ufw"
sudo netstat -tlnp | head -20
su - serveradmin -c whoami
```

Capture: ping output, service list, `netstat` and `whoami` showing `serveradmin`.

---

 
## Screenshot checklist (copy these into your submission and add filenames)

- [ ] Step 1: system update & `hostnamectl` — filename:
- [ ] Step 2: hostname & `ip addr show` — filename:
- [ ] Step 3: user creation & `groups` — filename:
- [ ] Step 4: SSH config grep & `ufw status verbose` — filename:
- [ ] Step 5: Apache `systemctl status` and `curl -I localhost` — filename:
- [ ] Step 6: `df -h`, `free -h` and `journalctl` snippet — filename:
- [ ] Step 7: `/etc/server-info.txt` content — filename:
- [ ] Step 8: ping + services + `netstat` + `whoami` as `serveradmin` — filename:

---

 
## Short explanations (one or two sentences each)

1. System update & info:

2. Hostname & network:

3. Administrative user created:

4. SSH & firewall configured:

5. Apache installed and tested:

6. System monitoring & logs:

7. Server documentation file:

8. Connectivity & verification:

---

## Troubleshooting notes (if you had errors, document them here)


---

## Submission

1. Zip this file and `lennox-screenshots/` together (or create a single PDF with screenshots in order).
2. Upload to the course assignment folder with the filename: `lennox-setup-[StarID].zip`.
3. Reply to the assignment post with a brief note: "Completed Lennox Server Setup — [Your Name / StarID] — screenshots included."


---

If you want, I can also generate a small script that runs the non-interactive commands and saves the outputs to a log file to make screenshotting easier. Would you like that? Replace placeholders with your StarID and run it once, then capture the outputs/screenshots listed above.
