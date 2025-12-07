from w1thermsensor import W1ThermSensor
from datetime import datetime
import time

# Simple DS18B20 temperature logger
# Enable 1-Wire via raspi-config, wire sensor to GPIO4 (pin 7) with 4.7kΩ pull-up


def main():
    sensor = W1ThermSensor()
    print("time,temperature_c")
    while True:
        t = sensor.get_temperature()
        print(f"{datetime.now().isoformat(timespec='seconds')},{t:.2f}")
        time.sleep(5)


if __name__ == "__main__":
    main()
