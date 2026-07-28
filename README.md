# Social Media App

![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.10.0-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-%5E3.10.0-0175C2?logo=dart)
![Backend](https://img.shields.io/badge/Backend-Supabase-3ECF8E?logo=supabase)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-success)
![State Management](https://img.shields.io/badge/State%20Management-BLoC-blue)

A Flutter social media app I built to practice shipping a full feature end-to-end — mobile client, Postgres backend, and realtime sync — not just the UI layer. Built with Clean Architecture and BLoC, backed by Supabase (Auth, Postgres, Storage, Realtime).

##  Screenshots

### Dark Mode

| Feed | Profile | Login |
|:---:|:---:|:---:|
| <img src="project_showcase/screenshots/home-dark.png" width="250"/> | <img src="project_showcase/screenshots/profile-dark.png" width="250"/> | <img src="project_showcase/screenshots/Login-dark.png" width="250"/> |

| Discover | Comments | Followers |
|:---:|:---:|:---:|
| <img src="project_showcase/screenshots/discover-dark.png" width="250"/> | <img src="project_showcase/screenshots/comments.png" width="250"/> | <img src="project_showcase/screenshots/followers-dark.png" width="250"/> |

### Light Mode

| Feed | Profile | Login |
|:---:|:---:|:---:|
| <img src="project_showcase/screenshots/home-light.png" width="250"/> | <img src="project_showcase/screenshots/profile-light.png" width="250"/> | <img src="project_showcase/screenshots/Login-light.png" width="250"/> |

| Followers | Drawer |
|:---:|:---:|
| <img src="project_showcase/screenshots/followers-light.png" width="250"/> | <img src="project_showcase/screenshots/drawer.png" width="250"/> |

## Features

- **Auth:** Email/password + Google OAuth via Supabase, with session persistence across app restarts.
- **Posts Feed:** Infinite-scroll feed with local caching for offline access.
- **Post Management:** Create, edit, and delete posts with image attachments.
- **Reacts:** Like/unlike with an atomic, race-condition-safe counter and live count sync across devices.
- **Comments:** Add, edit, and swipe-to-delete comments.
- **Profile & Media:** Edit profile info and upload avatar/background images with cropping.
- **Search:** Search posts and users with history and suggestions.
- **Responsive UI:** Mobile, tablet, and desktop layouts.
- **Dark/Light Mode:** Persisted across sessions via HydratedBloc.

## Things I ran into while building this

A few bugs/decisions that taught me more than the average CRUD screen:

- **Like counters kept desyncing under fast taps.** Fixed it with a Postgres trigger that updates the like count atomically on insert/delete, instead of counting client-side. Counts also sync live across devices with Supabase Realtime. On the Flutter side I scoped `BlocSelector` per `postId` so liking one post doesn't rebuild the whole feed.
- **Likes/comments were "working" but not actually saving.** Turns out I hadn't set up Row Level Security policies for those tables — inserts looked fine in the app's local state but never actually landed in Postgres. Took a while to realize the bug wasn't in my Bloc logic at all, it was a missing policy on the backend.
- **Second login crashed the app.** Traced it to `_streamSubscription?.cancel()` on logout killing the Google OAuth deep-link listener for good, plus a leftover `emit(AuthInitial())` in the logout handler leaving stale state around. Fixed by making cancel-and-resubscribe happen together in one `_initAuthListener()` method instead of two separate places.
- **Avatar/background upload.** Built a shared `_uploadImage` helper (folder-based separation in Supabase Storage) and made sure the Cubit uploads the image *before* calling `updateUser`, using null-based partial updates so I'm not overwriting fields the user didn't touch.
- **Migrated the whole app off a dummy JSON API onto Supabase** (auth, posts, comments, users, media) including writing the RLS policies myself, while keeping the domain layer contracts the same so the presentation layer didn't need to change.

## Architecture

- **Clean Architecture:** `Data` / `Domain` / `Presentation` layers per feature, with `UserModel` (data) kept separate from the `User` entity (domain/presentation) to avoid leaking serialization concerns upward.
- **BLoC:** `flutter_bloc` for state management, `hydrated_bloc` for disk-persisted state (auth session, theme).
- **Dependency Injection:** `get_it`, feature-scoped registration.
- **Routing:** `go_router` with `ShellRoute` for bottom navigation and auth guards on protected routes.
- **Functional error handling:** `dartz`'s `Either<Failure, T>` from repositories outward — no bare try/catch leaking into the UI layer.
- **Offline-first:** Local caching via `shared_preferences` / `hydrated_bloc`, connectivity checks via `internet_connection_checker_plus`, with Realtime as the live-update layer on top once connected.

## Tech Stack

| Category | Package/Tech |
|----------|--------------|
| **Framework** | Flutter (`>=3.10.0`) |
| **Backend** | `supabase_flutter` (Auth, Postgres, Storage, Realtime) |
| **State Management** | `flutter_bloc`, `hydrated_bloc`, `equatable` |
| **Routing** | `go_router`, `go_provider` |
| **Dependency Injection** | `get_it` |
| **Functional Prog.** | `dartz` |
| **Local Storage** | `shared_preferences`, `hydrated_bloc` |
| **Media** | `image_picker`, `image_cropper`, `cached_network_image` |
| **UI Components** | `animated_toggle_switch`, `flutter_side_menu`, `dotted_border`, `readmore`, `flutter_svg` |

## Folder Structure

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
    ├── auth/             # Login, Signup, OAuth
    ├── Comments/         # Post comments management
    ├── Posts/            # Feed, Create/Edit/Delete post
    ├── Reacts/           # Post interactions, Realtime sync
    ├── Search/           # Search posts and users
    └── user/             # User profiles, settings, media upload
```

## Getting Started

### Prerequisites
- Flutter SDK `>=3.10.0`
- Dart SDK `^3.10.0`
- A Supabase project (Auth, Postgres, Storage enabled)

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Add your Supabase URL and anon key (e.g. via `--dart-define` or a config file — adjust to however you're loading them).
4. Run the app:
   ```bash
   flutter run
   ```

### Code Quality & Testing

- **Analyze code:** `flutter analyze`
- **Format code:** `dart format .`
- **Run tests:** `flutter test`
