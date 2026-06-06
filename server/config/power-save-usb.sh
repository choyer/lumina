#!/bin/bash
# ©crh 5 June 2026
# Shut off USB ports to reduce idle power.
# NOTE: doing so will limit the possibility of using a usb keyboard 
# to debug, if needed.

# HowTo:
# Make this script executable via:
# sudo chmod +x /usr/local/bin/power-save-usb.sh
#
# Add as cron boot event:
# sudo crontab -e
# 
# Append the following text:
# @reboot /usr/local/bin/power-save-usb.sh

# Logically shut off both usb ports and stop power handshakes thru kernel status rewrite at boot.
echo 0 > /sys/bus/usb/devices/usb1/authorized
echo 0 > /sys/bus/usb/devices/usb2/authorized

