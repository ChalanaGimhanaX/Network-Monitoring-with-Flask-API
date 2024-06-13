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
    if "vps1ip" in request.remote_addr:
        speed_data["VPS1"] = data
    elif "vps2ip" in request.remote_addr:
        speed_data["VPS2"] = data

    return jsonify({'message': 'Data received successfully'})

@app.route('/bot/speed', methods=['GET'])
def get_speed_data():
    return jsonify(speed_data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
