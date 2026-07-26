# 📱 Social Media App

![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.10.0-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-%5E3.10.0-0175C2?logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-success)
![State Management](https://img.shields.io/badge/State%20Management-BLoC-blue)

A feature-rich, scalable, and responsive Social Media application built with Flutter. This project demonstrates industry-standard practices including **Clean Architecture**, **BLoC Pattern** for state management, **Dependency Injection**, and **Offline-First** data handling.

## ✨ Features

- **Authentication:** Secure Login and Sign-up flows with token persistence.
- **Posts Feed:** Infinite scrolling feed of posts with caching for offline access.
- **Create & Manage Posts:** Add, edit, and delete posts seamlessly.
- **Comments System:** Real-time adding, editing, and swiping to delete comments on posts.
- **User Profiles:** View your own profile and other users' profiles, including their posts.
- **Search & Filter:** Search for posts and users with built-in history and suggestions.
- **Responsive Design:** Optimized for Mobile, Tablet, and Desktop layouts.
- **Dark/Light Mode:** Seamless theme switching persisted to disk.

## 🏗 Architecture & Design Patterns

This app is built with scalability and maintainability in mind, making it highly suitable for enterprise-level development.

- **Clean Architecture:** Strict separation of concerns divided into `Data`, `Domain`, and `Presentation` layers for each feature.
- **BLoC State Management:** Utilizing `flutter_bloc` for predictable state management, and `hydrated_bloc` for automatic state persistence to disk (perfect for caching auth states and themes).
- **Dependency Injection:** Centralized dependency management using `get_it` ensuring loosely coupled components.
- **Declarative Routing:** Advanced routing with `go_router`, utilizing ShellRoutes for bottom navigation and Auth Guards to protect routes.
- **Functional Error Handling:** Utilizing `dartz` to return `Either<Failure, T>` from repositories, ensuring UI layers handle domain errors gracefully rather than relying on exceptions.
- **Offline-First Strategy:** Strategic caching using `SharedPreferences` for posts and user data, falling back to local storage when the device loses connection (`internet_connection_checker_plus`).

## 🛠 Tech Stack

| Category | Package/Tech |
|----------|--------------|
| **Framework** | Flutter (`>=3.10.0`) |
| **State Management**| `flutter_bloc`, `hydrated_bloc`, `equatable` |
| **Networking** | `http`, `internet_connection_checker_plus` |
| **Routing** | `go_router`, `go_provider` |
| **Dependency Injection**| `get_it` |
| **Functional Prog.** | `dartz` |
| **Local Storage** | `shared_preferences`, `hydrated_bloc` |
| **UI Components** | `cached_network_image`, `animated_toggle_switch`, `readmore`, `flutter_svg` |

## 📂 Folder Structure

```
lib/
├── main.dart             # Application entry point & initialization
├── app.dart              # Root widget & Theme providers
├── core/                 # Shared infrastructure
│   ├── constants/        # Constants, enums, dimensions
│   ├── di/               # Dependency injection container
│   ├── Error/            # Custom Failures & Exceptions
│   ├── network/          # Network connectivity checks
│   ├── routing/          # GoRouter setup & Auth Guards
│   ├── theming/          # Dark/Light theme & extensions
│   └── widgets/          # Reusable UI components
└── features/             # Feature-driven modules (Clean Architecture)
    ├── auth/             # Login, Signup, Auth validation
    ├── Comments/         # Post comments management
    ├── Posts/            # Feed, Create/Edit/Delete post
    ├── Reacts/           # Post interactions
    ├── Search/           # Search posts and users
    └── user/             # User profiles & settings
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.10.0`
- Dart SDK `^3.10.0`

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### Code Quality & Testing

- **Analyze code:** `flutter analyze`
- **Format code:** `dart format .`
- **Run tests:** `flutter test`

## 👨‍💻 Note to Recruiters

This repository serves as a showcase of my ability to write production-ready Flutter applications. 
Key highlights include:
- Implementing **Clean Architecture** to ensure the codebase is testable, decoupled, and maintainable.
- Handling complex state predictably with the **BLoC pattern**.
- Implementing an **Offline-First** approach to improve UX during poor network conditions.
- Applying strict typing and functional error handling using `dartz` without relying on generic try-catch blocks in the UI layer.
