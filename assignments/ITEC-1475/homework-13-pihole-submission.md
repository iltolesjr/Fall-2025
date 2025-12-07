# ITEC 1475 – Homework 13: Raspberry Pi Pi-hole Submission

Date: 2025-11-23
Student: Ira Toles
Course: ITEC 1475-60 Linux System Administration (Fa25)

## Overview
This document records my setup of Pi-hole on a Raspberry Pi, verifies functionality, and includes evidence of successful ad-blocking and DNS resolution from my network.

## Hardware and OS
- Device: Raspberry Pi 4 Model B
- OS: Raspberry Pi OS (Bookworm) 64-bit
- Network: Wired or Wi-Fi (note SSID and interface)

## 1. Raspberry Pi Preparation
- Enabled SSH via raspi-config
- Confirmed IP address: <fill in>
- Username used for SSH: <fill in>

## 2. Pi-hole Installation
- Installer: curl -sSL https://install.pi-hole.net | bash
- Interface selected: <eth0/wlan0>
- Upstream DNS: <Cloudflare 1.1.1.1 / Google 8.8.8.8 / other>
- Adlists: default enabled; gravity update run
- Admin password set

### Verification
- Pi-hole Admin UI reachable at: http://<pi-ip>/admin
- Status: Active (green)
- Recent Queries show blocked domains

## 3. Network Client Configuration
- Windows machine set DNS to Pi-hole IP
- Verified with nslookup and browsing tests

### Commands run (on Windows)
- Test-NetConnection -ComputerName <pi-ip> -Port 80
- nslookup example.com <pi-ip>

## 4. Evidence/Results
Attach or reference screenshots (stored under `screenshots/`):
- screenshots/pihole-dashboard.png – Admin dashboard showing queries blocked
- screenshots/pihole-gravity-update.png – `pihole -g` output
- screenshots/nslookup-to-pihole.png – nslookup using Pi-hole as DNS
- screenshots/pihole-query-log.png – Query log with blocked entries

## 5. Optional: Service Monitoring
I deployed optional monitoring scripts from `projects/pi4-final` on the Pi for CPU/temperature logging.
- Service: `pi_metrics.service` or `pi_temp_logger.service`
- Evidence: `systemctl status <service>` screenshot and CSV output sample

## 6. Issues and Resolutions
- SSH permissions on Windows OpenSSH config required hardening; fixed ACLs
- Identified correct Pi IP via router/console
- Resolved any DNS cache issues by flushing on Windows

## 7. Conclusion
Pi-hole was successfully installed and functioning. DNS queries from my Windows client resolved through Pi-hole with ads blocked. Admin dashboard confirms activity and gravity update.

## Appendix: Key Commands
On Raspberry Pi:
- pihole -g
- pihole -up
- pihole status
- sudo systemctl status pihole-FTL

On Windows PowerShell:
- Test-NetConnection -ComputerName <pi-ip> -Port 53
- ipconfig /all
- ipconfig /flushdns
- nslookup <domain> <pi-ip>

Notes:
- Replace <pi-ip>, <username>, and selections above with actual values used.
