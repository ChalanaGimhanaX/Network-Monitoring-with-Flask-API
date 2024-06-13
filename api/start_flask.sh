#!/bin/bash

# Navigate to the directory containing your Flask app
cd VPS-Network-Monitering-api-/api

# Install dependencies
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Start the Flask application
nohup python3 app.py > flask.log 2>&1 &

# Add a cron job to start this script at reboot
(crontab -l ; echo "@reboot /path/to/start_flask.sh") | crontab -
