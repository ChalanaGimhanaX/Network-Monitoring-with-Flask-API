#!/bin/bash

# Update the package list and install necessary packages
sudo apt-get update
sudo apt-get install -y git curl ifstat python3 python3-venv

# Clone the repository
git clone https://github.com/yourusername/network-monitoring.git

# Run the setup scripts based on the server type
if [ "$1" == "api" ]; then
    cd network-monitoring/api
    ./start_flask.sh
elif [ "$1" == "vps1" ]; then
    cd network-monitoring/vps1
    ./speedtest.sh
elif [ "$1" == "vps2" ]; then
    cd network-monitoring/vps2
    ./speedtest.sh
else
    echo "Invalid argument. Please specify 'api', 'vps1', or 'vps2'."
fi
