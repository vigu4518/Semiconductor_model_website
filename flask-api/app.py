from flask import Flask, request, jsonify
import joblib
import numpy as np
import os

app = Flask(__name__)

# Load both models
model2 = joblib.load("model.pkl")        # 2-param model
model3 = joblib.load("3_model.pkl")      # 3-param model

# Constant channel length for 2-param model
CHANNEL_LENGTH = 0.35

@app.route("/", methods=["GET"])
def health():
    return jsonify({"status": "ok"})

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json

        p1 = float(data['p1'])
        p2 = float(data['p2'])
        model_type = data.get("type", "2")   # default = 2

        if model_type == "2":
            # Use 2-param model (with fixed channel length)
            input_data = np.array([[p1, p2, CHANNEL_LENGTH]])
            prediction = model2.predict(input_data)

        else:
            # Use 3-param model
            p3 = float(data['p3'])
            input_data = np.array([[p1, p2, p3]])
            prediction = model3.predict(input_data)

        return jsonify({
            "result": float(prediction[0])
        })

    except Exception as e:
        return jsonify({
            "error": str(e)
        })

if __name__ == "__main__":
    print("Flask server running...")
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
