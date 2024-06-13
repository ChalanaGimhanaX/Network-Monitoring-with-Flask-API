# Network Monitoring Setup

This repository contains scripts to set up network monitoring on multiple VPS instances. It captures download and upload speeds and sends the data to a central Flask-based API server.

## Repository Structure
network-monitoring/
├── api/
│ ├── app.py
│ ├── requirements.txt
│ └── start_flask.sh
├── vps1/
│ └── speedtest.sh
├── vps2/
│ └── speedtest.sh
└── bootstrap.sh

- `api/`: Contains the Flask application to receive and display network speed data.
- `vps1/`: Contains the script to capture and send network speed data from VPS1.
- `vps2/`: Contains the script to capture and send network speed data from VPS2.
- `bootstrap.sh`: A script to set up a new VPS instance.

## Requirements

### General Requirements

- Git
- Curl
- ifstat
- Python 3
- Python virtual environment (venv)

### API Hosting VPS

- Flask

## Setup Instructions

### 1. Clone the Repository

First, clone the repository to your VPS:

`bash
git clone https://github.com/ChalanaGimhanaX/VPS-Network-Monitering-api-.git
cd network-monitoring

2. Make Scripts Executable
   chmod +x api/start_flask.sh
   chmod +x vps1/speedtest.sh
   chmod +x vps2/speedtest.sh
   chmod +x bootstrap.sh

3. Use the Bootstrap Script
Run the bootstrap.sh script to set up the appropriate environment on each VPS.

On API Hosting VPS
./bootstrap.sh api
On VPS1
./bootstrap.sh vps1
On VPS2
./bootstrap.sh vps2

Scripts Details
bootstrap.sh
This script will update the package list, install necessary packages, clone the repository, and run the setup scripts based on the server type (api, vps1, or vps2).

api/start_flask.sh
This script will:

Navigate to the directory containing your Flask app.
Install dependencies using a virtual environment.
Start the Flask application.
Set up a cron job to run this script at boot time.
vps1/speedtest.sh and vps2/speedtest.sh
These scripts will:
Capture download and upload speeds for a specified network interface.
Send the speed data to the API server.
Set up a cron job to run the script at boot time.

Running the Flask Application
Ensure you have the following in your api/ directory:

app.py

from flask import Flask, request, jsonify

app = Flask(__name__)

# Dictionary to store the latest speed data
speed_data = {"VPS1": "", "VPS2": ""}

@app.route('/bot/speed', methods=['POST'])
def receive_speed_data():
    data = request.get_data(as_text=True)
    print("Received speed data:")
    print(data)
    
    # Determine if the data is from VPS1 or VPS2 based on the IP address
    if "134.209.110.62" in request.remote_addr:
        speed_data["VPS1"] = data
    elif "134.209.101.242" in request.remote_addr:
        speed_data["VPS2"] = data

    return jsonify({'message': 'Data received successfully'})

@app.route('/bot/speed', methods=['GET'])
def get_speed_data():
    return jsonify(speed_data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

Monitoring the Speed Data
Use the following Python script on your local machine to fetch and display the speed data:
import requests
import time

def fetch_speed_data(api_endpoint):
    while True:
        try:
            response = requests.get(api_endpoint)
            if response.status_code == 200:
                data = response.json()
                print("Received speed data:")
                print(f"VPS1: {data['VPS1']}")
                print(f"VPS2: {data['VPS2']}")
            else:
                print(f"Failed to fetch speed data. Status code: {response.status_code}")
        except requests.exceptions.RequestException as e:
            print(f"Error fetching speed data: {e}")
        
        time.sleep(10)  # Adjust interval (in seconds) as needed

if __name__ == "__main__":
    api_endpoint = "http://0.0.0.0:555/bot/speed"
    fetch_speed_data(api_endpoint)


Conclusion
By following these instructions, you can quickly set up network monitoring on new VPS instances using the scripts hosted in this repository. Simply run the bootstrap.sh script with the appropriate server type to automate the setup process.

This `README.md` file provides clear instructions on how to set up and use the scripts in your GitHub repository, making it easy to redeploy your monitoring setup on new VPS instances.


      
