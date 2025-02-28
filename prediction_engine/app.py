import os

from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({
        "service": "BrainCast Prediction Engine",
        "status": "running"
    })

@app.route('/predict/<channel_id>')
def predict(channel_id):
    # Placeholder for prediction logic
    return jsonify({
        "channel_id": channel_id,
        "predicted_title": "Why This New Technology Will Change Everything",
        "predicted_thumbnail_url": "https://placeholder.com/640x360",
        "predicted_description": "In this video, we explore the revolutionary technology that's about to transform the industry.",
        "confidence": 0.87
    })

if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
