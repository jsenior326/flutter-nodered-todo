# To-Do List Application

A simple to-do list project made with Node-RED, Docker, and Flutter.

## Requirements
- Flutter
- Docker

## Running the Project
### 1. Clone the repository
```bash
git clone https://github.com/[YOUR_GITHUB_USERNAME]/flutter-nodered-todo.git
cd flutter-nodered-todo
```

### 2. Start the back-end ([Node-RED](https://nodered.org/))
Node-RED is deployed using [Docker](https://www.docker.com/). This terminal window should remain open while running the project.
```bash
docker compose up
```

### 3. Start the front-end [Flutter Web App](https://flutter.dev/)
Run the flutter application in a new terminal window. This window should remain open while running the project.
```bash
flutter run -d chrome
```
