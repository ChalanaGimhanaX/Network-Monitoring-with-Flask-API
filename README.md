# Network Monitoring with Flask API

Monitor the network speeds (download/upload) of multiple VPS instances using speedtest-cli and a centralized Flask API for data collection and display.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

* **Automated Setup:**  Easily set up new VPS instances for monitoring using the `bootstrap.sh` script.
* **Real-time Monitoring:** Capture and send network speed data to the Flask API for continuous tracking.
* **Centralized Data:**  Store and access historical speed data from all monitored VPS instances.
* **Customizable API:**  The Flask app can be easily extended to support additional features or data points.
* **Lightweight and Efficient:** Minimal resource usage on the VPS instances.

## Prerequisites

### All VPS Instances

* **Operating System:**  Linux (Ubuntu/Debian preferred)
* **Packages:** `git`, `curl`, `speedtest-cli` (install via `apt install speedtest`), `python3`, `python3-venv`
* **Network Access:**  Outbound access to the internet and the API server.

### API Server VPS

* **Packages:** `python3`, `python3-venv`, `flask`

## Installation and Setup

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/ChalanaGimhanaX/VPS-Network-Monitering-api-.git](https://github.com/ChalanaGimhanaX/VPS-Network-Monitering-api-.git)
   cd VPS-Network-Monitering-api- 
2.Make Scripts Executable:
  chmod +x api/start_flask.sh vps1/speedtest.sh vps2/speedtest.sh bootstrap.sh

3.Bootstrap Each VPS:
* On the API Server VPS: ./bootstrap.sh api
* On VPS1 (Monitoring Target): ./bootstrap.sh vps1
* On VPS2 (Monitoring Target): ./bootstrap.sh vps2
 (Replace vps1 and vps2 with the names of your VPS folders)

##Usage
1.Start the API Server: On your API server VPS, navigate to the api directory and run ./start_flask.sh. This will start the Flask application.

2.Monitor Data:
 * API Endpoint: Access http://<your_api_server_ip>:5000/bot/speed in your browser to view the latest speed data.
 * Custom Script: Use the provided Python script (fetch_speed_data.py) on your local machine to fetch and display the speed data continuously.

Configuration
 * API Endpoint: Modify the API_ENDPOINT variable in speedtest.sh scripts on the monitoring VPS instances to point to your actual API server.
 * Cron Jobs: Cron jobs are set up in start_flask.sh and speedtest.sh to automatically run the scripts on boot and periodically. You can adjust the frequency in the crontab files if needed.
   
Additional Information
 * Security: Consider adding authentication or restricting access to your API server for production environments.
 * Data Persistence: The current implementation stores data in memory. For long-term storage, you might want to integrate a database.

**License**
This project is licensed under the MIT License.
**Key Enhancements**

* **Clear Structure:** The README is organized into sections with headers for easy navigation.
* **Feature Highlights:** The features are prominently listed to attract users.
* **Concise Instructions:** The installation and usage steps are clear and easy to follow.
* **Additional Information:** Guidance on security and data persistence is provided.
* **License:** The MIT license badge is included to clarify usage permissions.
