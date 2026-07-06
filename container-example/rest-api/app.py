import socket

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def hello():
    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)
    return jsonify(
        message="Hello World",
        container="rest-api",
        hostname=hostname,
        ip=ip,
    )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
