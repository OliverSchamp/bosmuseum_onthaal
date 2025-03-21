#!/usr/bin/env python3

import RPi.GPIO as GPIO
import subprocess
import time

# GPIO pin setup
BUTTON_PIN = 17  # Adjust to your chosen GPIO pin
GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON_PIN, GPIO.IN)

# Callback function to run the bash script
def button_pressed(channel):
    print("Button pressed!")
    subprocess.run(["/path/to/button_script.sh"])

# Detect rising edge (button press) with debounce
GPIO.add_event_detect(BUTTON_PIN, GPIO.RISING, callback=button_pressed, bouncetime=300)

# Keep the script running
try:
    print("Monitoring button on GPIO 17. Press Ctrl+C to exit.")
    while True:
        time.sleep(1)  # Keep the script alive
except KeyboardInterrupt:
    print("Exiting...")
finally:
    GPIO.cleanup()  # Clean up GPIO settings
