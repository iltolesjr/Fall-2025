# Raspberry Pi 4 — Final Project

Two solid, gradable options:

1. Network: Pi-hole + system metrics
   - Deliverables: Pi-hole running as DNS sinkhole; a simple dashboard (Grafana or text-based) showing CPU temp, load, disk, and top blocked domains.
   - Why it grades well: clear setup, measurable output (blocked queries), screenshots, and a short reflection.

2. Sensors: Aquarium/Room monitor (DS18B20 temp)
   - Deliverables: Read DS18B20 temperature via 1-Wire; log to CSV; optional web display; service autostart.
   - Why it grades well: real hardware interaction, clean code, and a graph.

## A. Common Setup

1. OS prep (already installed): Ensure SSH is enabled.

1. Connect from Windows (PowerShell):

```powershell
# Replace with your Pi's IP
ssh pi@192.168.1.###
```

1. Update packages on the Pi:

```bash
sudo apt update && sudo apt -y upgrade
```

1. Copy project files from Windows to the Pi (optional, using SSH alias `pi4`):

```powershell
# Create the folder on the Pi
ssh pi4 "mkdir -p /home/pi/projects/pi4-final/systemd"

# Copy scripts
scp "projects/pi4-final/metrics.py" pi4:/home/pi/projects/pi4-final/
scp "projects/pi4-final/temp_logger.py" pi4:/home/pi/projects/pi4-final/

# Copy service units
scp "projects/pi4-final/systemd/pi_metrics.service" pi4:/home/pi/projects/pi4-final/systemd/
scp "projects/pi4-final/systemd/pi_temp_logger.service" pi4:/home/pi/projects/pi4-final/systemd/
```

## B. Option 1: Pi-hole + Metrics

1. Install Pi-hole:

```bash
curl -sSL https://install.pi-hole.net | bash
```

- Set upstream DNS (e.g., Cloudflare 1.1.1.1), choose a static IP, note the web password.
- Point one device’s DNS to the Pi IP to verify blocking.

1. Metrics (simple):

```bash
sudo apt -y install python3-pip
pip3 install psutil
```

Create `metrics.py`:

```python
import psutil, time
from datetime import datetime

def read_metrics():
    temps = psutil.sensors_temperatures()
    cpu_temp = None
    if 'cpu-thermal' in temps: cpu_temp = temps['cpu-thermal'][0].current
    load = psutil.getloadavg() if hasattr(psutil, 'getloadavg') else (0,0,0)
    disk = psutil.disk_usage('/')
    return {
        'time': datetime.now().isoformat(timespec='seconds'),
        'cpu_temp': cpu_temp,
        'load1': load[0],
        'disk_used_pct': round(disk.percent, 1)
    }

if __name__ == '__main__':
    print('time,cpu_temp,load1,disk_used_pct')
    while True:
        m = read_metrics()
        print(f"{m['time']},{m['cpu_temp']},{m['load1']},{m['disk_used_pct']}")
        time.sleep(5)
```

Run:

```bash
python3 metrics.py | tee metrics.csv
```
Take a screenshot of terminal output and Pi-hole dashboard (Queries Blocked).

## C. Option 2: DS18B20 Temperature Monitor

1. Enable 1-Wire:

```bash
sudo raspi-config
# Interface Options > 1-Wire > Enable; reboot
```
1. Wiring: DS18B20 to 3.3V, GND, and GPIO4 (pin 7) with a 4.7kΩ pull-up between data and 3.3V.

1. Read sensor:

```bash
sudo apt -y install python3-pip
pip3 install w1thermsensor
```
Create `temp_logger.py`:

```python
from w1thermsensor import W1ThermSensor
from datetime import datetime
import time

sensor = W1ThermSensor()
print('time,temperature_c')
while True:
    t = sensor.get_temperature()
    print(f"{datetime.now().isoformat(timespec='seconds')},{t:.2f}")
    time.sleep(5)
```

Run:

```bash
python3 temp_logger.py | tee temps.csv
```
Plot in Excel later or import into Grafana/Loki if you want bonus points.

## D. Autostart (service)

Create a systemd service so your script starts on boot. Example units are provided under `projects/pi4-final/systemd/`.

Install one of them:

```bash
sudo cp /home/pi/projects/pi4-final/systemd/pi_metrics.service /etc/systemd/system/
# or
sudo cp /home/pi/projects/pi4-final/systemd/pi_temp_logger.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable --now pi_metrics.service
# or
sudo systemctl enable --now pi_temp_logger.service

sudo systemctl status pi_metrics.service
# or
sudo systemctl status pi_temp_logger.service
```

## E. Final Deliverables Checklist

- 4–6 screenshots:
  - Pi-hole admin (blocked queries and top domains) OR sensor logs terminal + CSV
  - A settings screen (DNS or raspi-config 1-Wire)
  - A service status (`systemctl status`)
- Short write-up (5–7 sentences):
  - What you built, why it matters, what you measured, one problem you solved, and one improvement next time.

## F. Fallback Plan (no hardware)

- Do Option 1 only (Pi-hole + metrics). No external sensors required.

Notes:

- Keep language simple.
- Save code under `projects/pi4-final/` on the Pi; mirror here if you want version history.
