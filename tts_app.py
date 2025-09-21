from flask import Flask, request, send_file
from gtts import gTTS
import os

app = Flask(__name__)

@app.route("/tts", methods=["POST"])
def tts():
    text = request.json.get("text", "")
    if not text:
        return {"error": "No text provided"}, 400

    tts = gTTS(text=text, lang="en")
    filename = "/tmp/output.mp3"
    tts.save(filename)

    return send_file(filename, mimetype="audio/mpeg")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
