# Pet Management Mobile App

This is a Flutter mobile application for managing pets, built with GetX for state management and navigation.

## Features

- User registration and authentication
- Secure token-based login
- Add new pets with details (name, type, age, notes)
- View list of user's pets
- Input validation and error handling
- Clean and intuitive UI design
- Persistent login sessions

## Tech Stack

- **Flutter** - Cross-platform mobile development framework
- **GetX** - State management, navigation, and dependency injection
- **HTTP** - API communication
- **SharedPreferences** - Local data persistence
- **Material Design 3** - Modern UI components

## Project Structure

```
lib/
├── controllers/
│   ├── auth_controller.dart      # Authentication state management
│   └── pet_controller.dart       # Pet management state
├── models/
│   ├── user.dart                 # User data model
│   └── pet.dart                  # Pet data model
├── services/
│   ├── api_service.dart          # HTTP API communication
│   └── storage_service.dart      # Local storage operations
├── utils/
│   └── validation_utils.dart     # Input validation helpers
├── views/
│   ├── login_screen.dart         # Login UI
│   ├── register_screen.dart      # Registration UI
│   ├── pets_screen.dart          # Pet list UI
│   └── add_pet_screen.dart       # Add pet form UI
└── main.dart                     # App entry point and routing
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. Navigate to the mobile directory:

```bash
cd mobile
```

2. Install dependencies:

```bash
flutter pub get
```

3. Configure API endpoint:

   - Update the `baseUrl` in `lib/services/api_service.dart` if your backend is running on a different host/port
   - Default: `http://localhost:8000`

4. Run the application:

```bash
flutter run
```

## App Flow

1. **Splash Screen** - App loads and checks authentication status
2. **Login/Register** - User authentication
3. **Pet List** - View all user's pets
4. **Add Pet** - Form to add new pets
5. **Logout** - Clear session and return to login

## API Integration

The app communicates with the FastAPI backend using HTTP requests:

- **POST /auth/register** - User registration
- **POST /auth/login** - User login
- **GET /pets** - Fetch user's pets (requires auth)
- **POST /pets** - Add new pet (requires auth)

## State Management with GetX

The app uses GetX for:

- **Reactive State Management** - Observable variables with `.obs`
- **Navigation** - Route management with `Get.toNamed()`
- **Dependency Injection** - Controller initialization with `Get.put()`
- **Snackbars** - User feedback with `Get.snackbar()`

## Validation

Input validation includes:

- Email format validation
- Password minimum length (6 characters)
- Pet name minimum length (2 characters)
- Age range validation (0-50 years)
- Required field validation

## Error Handling

- Network error handling with try-catch blocks
- API error message display
- User-friendly error messages
- Loading states during API calls

## Build for Production

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## Future Enhancements

- Pet photo upload
- Edit/delete pet functionality
- Pet care reminders
- Pet health tracking
- Offline mode support
- Push notifications
