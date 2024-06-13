#!/bin/bash

# Function to capture download and upload speeds for a specific interface
capture_speed() {
    interface=$1
    ifstat -i $interface 1 1 | tail -n 1 | awk '{print "Download: " $1 " KB/s, Upload: " $2 " KB/s"}'
}

# Replace 'eth0' with the actual network interface on VPS1
vps_interface="eth0"

# Main loop to continuously capture speeds and send to bot
while true
do
    vps_speed=$(capture_speed $vps_interface)

    # Sending data to your bot API endpoint
    curl -X POST -d "VPS2 Speed: $vps_speed" http://81.161.238.84:5000/bot/speed

    sleep 5  # Adjust interval (in seconds) as needed
done
