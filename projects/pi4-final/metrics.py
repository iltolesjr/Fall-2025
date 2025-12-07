import psutil
import time
from datetime import datetime

# Robust CPU temperature fetch: handle different sensor keys

def get_cpu_temp():
    temps = psutil.sensors_temperatures()
    if not temps:
        return None
    # Common keys on Raspberry Pi
    for key in ("cpu-thermal", "cpu_thermal", "soc-thermal", "coretemp"):
        if key in temps and temps[key]:
            return temps[key][0].current
    # Fallback: first available sensor
    first = next(iter(temps.values()))
    if first:
        return first[0].current
    return None


def read_metrics():
    cpu_temp = get_cpu_temp()
    # psutil.getloadavg may not exist on some platforms
    if hasattr(psutil, "getloadavg"):
        load1, load5, load15 = psutil.getloadavg()
    else:
        # Approximate with CPU percent
        load1 = psutil.cpu_percent(interval=0.1) / 100.0
        load5 = 0.0
        load15 = 0.0
    disk = psutil.disk_usage("/")
    return {
        "time": datetime.now().isoformat(timespec="seconds"),
        "cpu_temp": cpu_temp,
        "load1": round(load1, 2),
        "disk_used_pct": round(disk.percent, 1),
    }


def main():
    print("time,cpu_temp,load1,disk_used_pct")
    while True:
        m = read_metrics()
        print(f"{m['time']},{m['cpu_temp']},{m['load1']},{m['disk_used_pct']}")
        time.sleep(5)


if __name__ == "__main__":
    main()
