# VPS Network Monitoring with Flask and Bash

A prototype for collecting Linux network-interface throughput from VPS instances and viewing the latest readings through a Python Flask API.

The Bash collectors use `ifstat` to sample incoming and outgoing traffic and send readings over HTTP. This measures current interface traffic; it is not an internet speed benchmark.

## Architecture

`VPS collector (Bash + ifstat) → HTTP POST /bot/speed → Flask → HTTP GET /bot/speed`

- Collectors send readings every five seconds.
- The API keeps the latest reading for each of two configured VPS instances in memory.
- Clients can retrieve the latest readings as JSON.
- There is no database or historical data retention; restarting the API clears the readings.

## Technology

Python, Flask, Bash, Linux, `ifstat`, and `curl`.

## Development setup

### 1. Clone the repository

```bash
git clone https://github.com/ChalanaGimhanaX/Network-Monitoring-with-Flask-API.git
cd Network-Monitoring-with-Flask-API
```

On Ubuntu or Debian, install the prerequisites:

```bash
sudo apt-get update
sudo apt-get install -y python3 python3-venv ifstat curl
```

### 2. Configure the API and collectors

Before running the project:

- In `api/app.py`, replace the `vps1ip` and `vps2ip` placeholders in the source-IP checks with the collector addresses visible to the API.
- In each collector script, replace the hard-coded HTTP destination with your API server's URL.
- Set `vps_interface` to the actual network interface on each collector host.

The current source-IP checks use substring matching. Treat this as prototype routing logic, not authentication.

### 3. Start the API

From the repository root:

```bash
cd api
python3 -m venv .venv
source .venv/bin/activate
python -m pip install flask
python app.py
```

The development server listens on port `5000`.

### 4. Start a collector

On the corresponding VPS, from the repository root after configuration:

```bash
bash vps1/speedtest.sh
```

Use the corresponding script in `vps2/` for the second collector. Stop a foreground collector with Ctrl+C.

### 5. Read the latest data

```bash
curl http://YOUR_API_SERVER:5000/bot/speed
```

## Current limitations

- The API runs with Flask debug mode enabled and has no authentication or TLS configuration. Use a controlled development environment; production deployment needs a production server, authentication, and transport protection.
- Readings are stored only in memory.
- Collector destinations and interface names require manual configuration.
- `bootstrap.sh` and `api/start_flask.sh` contain legacy repository paths; the startup script also has a placeholder cron path. Use the manual steps above until those scripts are updated.
- Source-IP routing needs adjustment for NAT or reverse proxies.

## Possible next steps

Add configuration through environment variables, authenticated collector identities, persistent time-series storage, automated tests, and a dashboard.
