from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/api/register")
def register():
    return jsonify({"status": "ok", "action": "register"})

@app.route("/api/deposit")
def deposit():
    return jsonify({"status": "ok", "action": "deposit"})

@app.route("/api/withdraw")
def withdraw():
    return jsonify({"status": "ok", "action": "withdraw"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
