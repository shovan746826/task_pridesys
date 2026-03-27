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

```bash
cd your-project or task_pridesys
```

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
## APK File
[Download APK](https://github.com/shovan746826/task_pridesys/blob/main/android/apk/app-release.apk)

## Demo Video
[Watch Demo](https://youtube.com/shorts/NZTnm_ob6h4?feature=share)


## 🧠 State Management Choice

### ✅ Riverpod

**Why Riverpod?**

- Provides **compile-time safety**
- Eliminates common issues found in Provider (like context misuse)
- Supports **scalable and modular architecture**
- Easy to test and maintain
- Works well with clean architecture (separation of concerns)

Riverpod helps keep business logic separate from UI, making the codebase cleaner and more maintainable as the project grows.

---

## 💾 Storage Approach

### ✅ Hive (Local Database)

**Why Hive?**

- Lightweight and extremely fast (NoSQL)
- Works offline without any dependency on native DB
- Easy to integrate with Flutter
- Suitable for:
  - Caching API responses
  - Storing user session data (tokens, preferences)


## 👨‍💻 Author

**Ashiqur Rahman**  
Flutter Developer

---
