#!/usr/bin/env python3

import RPi.GPIO as GPIO
import subprocess
import time

# GPIO pin setup
BUTTON_PIN = 11  # Adjust to your chosen GPIO pin
GPIO.setmode(GPIO.BOARD)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)

# Callback function to run the bash script
def button_pressed():
    print("Button pressed!")
    subprocess.run(["/home/dietpi/bosmuseum_onthaal/projecten/automatisch_ppt/pull_ppt.sh"])
    subprocess.run(["/home/dietpi/bosmuseum_onthaal/projecten/automatisch_ppt/update_ppt_2.sh"])

# Detect rising edge (button press) with debounce
#GPIO.add_event_detect(BUTTON_PIN, GPIO.RISING, callback=button_pressed, bouncetime=300)

# Keep the script running
try:
    print("Monitoring button on GPIO 17. Press Ctrl+C to exit.")
    while True:
        if GPIO.input(BUTTON_PIN) == GPIO.HIGH:
            button_pressed()
        time.sleep(0.1)  # Keep the script alive
except KeyboardInterrupt:
    print("Exiting...")
finally:
    GPIO.cleanup()  # Clean up GPIO settings
