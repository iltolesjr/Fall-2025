# Zero‑Touch Linux Mint 22 Final Project

This folder contains the post‑install automation and a step‑by‑step guide to create a USB and finish configuration automatically.

Mint uses a live installer (not Ubuntu autoinstall). We implement zero‑touch via a strong post‑install script that is safe to run once after the OS boots.

## Files
- `final-setup.sh` — post‑install script: creates user, enables SSH/Samba/Apache, sets hostname/timezone/locale, installs packages, sets a share, and is idempotent

## Use your ISO
You provided:
```
C:\Users\irato\Downloads\linuxmint-22-cinnamon-64bit.iso
```

## Build the USB (Windows)
1. Use Rufus (or Raspberry Pi Imager if preferred) to write the ISO to a USB drive.
2. Boot the target laptop from the USB and install Mint with defaults (auto‑partition or guided install).
3. Set a temporary admin user during install (you can keep or remove later).

## Run the post‑install automation
Copy `final-setup.sh` to the laptop (e.g., via USB or network), then:

```bash
sudo chmod +x ~/final-setup.sh
sudo ./final-setup.sh
```

Defaults:
- user: `student` (sudo group, no password set — prefer SSH keys)
- hostname: `lab-linux-autoinstall`
- timezone: `America/Chicago`
- locale: `en_US.UTF-8`
- share: `/srv/share` (guest ok)
- services: SSH, Samba, Apache, Python, UFW installed

Edit the variables at the top of `final-setup.sh` if you want different values.

## Screenshots to capture
- Hostname and IP (output of the script)
- SSH login from another machine (or terminal screenshot)
- Samba share visible in Windows Explorer (\\lab-linux-autoinstall\autoshare)
- Apache default page in browser (http://IP/)
- Directory listing showing `/srv/share`
- Journal output if you wrap the script with systemd (optional)

## Optional: wrap with systemd to run automatically once
Create `/etc/systemd/system/final-setup.service`:

```
[Unit]
Description=Final setup automation
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/root/final-setup.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Place `final-setup.sh` in `/root`, then:
```
sudo systemctl enable final-setup.service
sudo systemctl start final-setup.service
```

## Notes
- Mint’s installer doesn’t support Ubuntu’s autoinstall.yaml; this approach is the reliable path for zero‑touch outcomes.
- To go deeper, we can build a custom ISO (via Cubic) that embeds this script and runs automatically on first boot.
- If you decide to use Ubuntu 24.04 LTS instead, I can generate a full `autoinstall.yaml` with cloud‑init.
