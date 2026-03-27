# 📱 Flutter Clean Architecture Project

A scalable and production-ready Flutter application using **Riverpod**, **Dio**, and **Hive**, following a **feature-based clean architecture**.

---

## 🚀 Tech Stack

- **State Management:** Riverpod
- **Networking:** Dio
- **Local Database:** Hive
- **Architecture:** Feature-based Clean Architecture

---

## 📂 Project Structure

```plaintext
lib/
│
├── core/
│   ├── config/
│   │   ├── network/
│   │   ├── api_config.dart
│   │   ├── app_constant_config.dart
│   │   ├── asset_config.dart
│   │   ├── color_config.dart
│   │   ├── router_config.dart
│   │   ├── size_config.dart
│   │   └── theme_config.dart
│   │
│   ├── global/
│   │   ├── global_features/
│   │   ├── util/
│   │   └── widgets/
│
├── features/
│   ├── _demo/
│   │
│   ├── dashboard/
│   │   ├── controller/
│   │   ├── model/
│   │   ├── presentation/
│   │   │   ├── component/
│   │   │   └── page/
│   │   ├── provider/
│   │   └── repository/
│   │
│   └── splash/
│
└── main.dart
```

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/shovan746826/task_pridesys.git
```

### 2️⃣ Go to Project Directory


### 3️⃣ Install Dependencies

```bash
flutter pub run build_runner build
flutter pub get
```

### 4️⃣ Run the App

```bash
flutter run
```

## 🌐 Networking (Dio)

- Centralized API handling
- Interceptors for:
    - Logging
    - Token injection
    - Error handling


## 🧠 State Management (Riverpod)

- Reactive & scalable
- Separation of UI and logic


## 💾 Local Database (Hive)

- Lightweight and fast NoSQL database
- Used for caching & offline storage


## 📦 Features

- Clean Architecture
- Modular Feature-Based Structure
- Scalable Codebase
- API Integration
- Local Storage Support
- Reusable UI Components

---

## 🛠️ Build

```bash
flutter build apk --release
```

## 👨‍💻 Author

**Ashiqur Rahman**  
Flutter Developer

---
