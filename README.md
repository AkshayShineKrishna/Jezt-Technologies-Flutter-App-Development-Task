# Jezt Technologies : Flutter App Development Task
![Demo](demo.gif)

## Table of Content
- [Demo](#demo)
- [✅ Objectives](#-objectives-)
- [🚀 How to Run the Project](#-how-to-run-the-project)
- [📁 Folder Structure Overview](#-folder-structure-overview)
  - [📌 presentation](#-presentation)
  - [🌐 services](#-services)
  - [🧩 models](#-models)
  - [🔗 endpoints](#-endpoints)

## ✅ Objectives :
- Login using Jezt Technologies API.
- Display dashboard data after successful login.
- Logout functionality.

## 🚀 How to Run the Project

1. **Clone the repository**:
   ```bash
   git clone https://github.com/AkshayShineKrishna/Jezt-Technologies-Flutter-App-Development-Task.git
   cd Jezt-Technologies-Flutter-App-Development-Task
   ```

2. **Get dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

> Make sure you have an emulator running or a physical device connected.

---

## 📁 Folder Structure Overview

```plaintext
.
├── endpoints/
├── models/
├── presentation/
└── services/
```

### 📌 `presentation/`
- Contains all **UI and screens** used in the app.
- Example: `ScreenHome`, `ScreenDashboard`.

### 🌐 `services/`
- Responsible for **handling HTTP web requests** using Dio.
- Example: `login`, `logout`, `dashboard` API calls are made here.

### 🧩 `models/`
- Holds **data models** used to convert JSON responses from the API into Dart classes.
- Example: `LoginResponse`, `DashBoardResponse`.

### 🔗 `endpoints/`
- Stores all **API endpoint constants** such as:
  - `login`
  - `dashboard`
  - `logout`

---

