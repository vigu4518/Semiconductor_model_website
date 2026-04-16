# Semiconductor Threshold Voltage Predictor

Spring Boot web app with a JSP frontend for predicting semiconductor threshold voltage. The app collects model inputs from the user and sends them to a Flask prediction API.

## Tech Stack

- Java 17
- Spring Boot 3
- JSP
- Maven
- Docker
- Render

## Project Structure

```text
src/main/java/com/example/website/demo/
  Application.java
  HomeCotroller.java

src/main/resources/
  application.properties
  static/style.css

src/main/webapp/
  index.jsp
```

## Run Locally

Start the Spring Boot app:

```powershell
.\mvnw.cmd spring-boot:run
```

Open:

```text
http://localhost:8080
```

By default, prediction requests are sent to:

```text
http://localhost:5000/predict
```

If your Flask API is running somewhere else, set `PREDICT_API_URL` before starting the app:

```powershell
$env:PREDICT_API_URL="http://localhost:5000/predict"
.\mvnw.cmd spring-boot:run
```

## Build

```powershell
.\mvnw.cmd clean package -DskipTests
```

The WAR file is created in:

```text
target/website.demo-0.0.1-SNAPSHOT.war
```

## Deploy Website To Render

This project includes:

- `Dockerfile`
- `render.yaml`
- `.dockerignore`

Steps:

1. Push this project to GitHub.
2. In Render, choose **New > Blueprint**.
3. Connect the GitHub repository.
4. Render will detect `render.yaml`.
5. Set the environment variable:

```text
PREDICT_API_URL=https://your-flask-api-service.onrender.com/predict
```

6. Deploy.

## Deploy Flask API

The Flask API code is not included in this repository yet. The website expects the Flask service to provide this endpoint:

```text
POST /predict
```

Expected JSON request:

```json
{
  "type": "2",
  "p1": "1.2e17",
  "p2": "5.0"
}
```

For the 3-parameter model:

```json
{
  "type": "3",
  "p1": "1.2e17",
  "p2": "5.0",
  "p3": "0.18"
}
```

Expected JSON response:

```json
{
  "result": "0.72"
}
```

After deploying the Flask API, copy its Render URL and use it as `PREDICT_API_URL` for the Spring Boot website.

## GitHub Upload

If this folder is not already a Git repository:

```powershell
git init
git add .
git commit -m "Initial Render deployment setup"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

Replace `YOUR_USERNAME` and `YOUR_REPOSITORY` with your GitHub account and repository name.
