# Pet Management System

A full-stack application for managing pets, built with Flutter (mobile) and FastAPI (backend). This project demonstrates modern development practices with clean architecture, proper authentication, and intuitive user interface.

## 🚀 Features

### Mobile App (Flutter + GetX)

- **Authentication**: User registration and login with JWT tokens
- **Pet Management**: Add and view pets with details (name, type, age, notes)
- **State Management**: Reactive state with GetX
- **Navigation**: Route-based navigation with GetX
- **Validation**: Input validation and error handling
- **Persistence**: Token storage with SharedPreferences
- **UI/UX**: Material Design 3 with intuitive interface

### Backend (FastAPI)

- **REST API**: RESTful endpoints for authentication and pet management
- **Authentication**: JWT token-based authentication
- **Database**: MongoDB integration for data persistence
- **Validation**: Pydantic models for request/response validation
- **CORS**: Configured for mobile app communication
- **Documentation**: Auto-generated API documentation

## 🏗️ Architecture

```
InternProj/
├── backend/                 # FastAPI backend
│   ├── main.py             # FastAPI application
│   ├── requirements.txt    # Python dependencies
│   ├── .env               # Environment variables
│   └── README.md          # Backend documentation
├── mobile/                 # Flutter mobile app
│   ├── lib/               # Dart source code
│   │   ├── controllers/   # GetX controllers
│   │   ├── models/        # Data models
│   │   ├── services/      # API and storage services
│   │   ├── utils/         # Utility functions
│   │   ├── views/         # UI screens
│   │   └── main.dart      # App entry point
│   ├── pubspec.yaml       # Flutter dependencies
│   └── README.md          # Mobile app documentation
└── README.md              # This file
```

## 🛠️ Tech Stack

### Backend

- **FastAPI** - Modern Python web framework
- **MongoDB** - NoSQL database
- **PyMongo** - MongoDB driver for Python
- **Pydantic** - Data validation and serialization
- **Python-JOSE** - JWT token handling
- **Passlib** - Password hashing
- **Uvicorn** - ASGI server

### Mobile

- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **GetX** - State management and navigation
- **HTTP** - API communication
- **SharedPreferences** - Local data persistence

## 📋 Prerequisites

### Backend

- Python 3.8 or higher
- MongoDB (local installation or MongoDB Atlas)

### Mobile

- Flutter SDK 3.8.1 or higher
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd InternProj
```

### 2. Backend Setup

1. Navigate to backend directory:

```bash
cd backend
```

2. Install Python dependencies:

```bash
pip install -r requirements.txt
```

3. Set up environment variables:

   - Copy `.env.example` to `.env` (if available)
   - Update MongoDB connection string in `.env`
   - For local MongoDB: `MONGODB_URL=mongodb://localhost:27017`

4. Start MongoDB service (if running locally)

5. Run the FastAPI server:

```bash
python main.py
```

The API will be available at `http://localhost:8000`

### 3. Mobile Setup

1. Navigate to mobile directory:

```bash
cd mobile
```

2. Install Flutter dependencies:

```bash
flutter pub get
```

3. Update API endpoint (if needed):

   - Edit `lib/services/api_service.dart`
   - Update `baseUrl` if backend is not on localhost:8000

4. Run the mobile app:

```bash
flutter run
```

## 📱 App Demo Flow

1. **Launch App** → Splash screen with loading
2. **Authentication** → Login or Register
3. **Pet List** → View all user's pets (empty initially)
4. **Add Pet** → Fill form with pet details
5. **View Pets** → See added pets in the list
6. **Logout** → Return to login screen

## 🔗 API Endpoints

### Authentication

- `POST /auth/register` - Register new user

  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```

- `POST /auth/login` - Login user
  ```json
  {
    "email": "user@example.com",
    "password": "password123"
  }
  ```

### Pets (Requires Authentication)

- `GET /pets` - Get user's pets
- `POST /pets` - Add new pet
  ```json
  {
    "name": "Buddy",
    "type": "Dog",
    "age": 3,
    "notes": "Very friendly"
  }
  ```

## 🔒 Authentication Flow

1. User registers/logs in via mobile app
2. Backend validates credentials and returns JWT token
3. Mobile app stores token in SharedPreferences
4. Token is included in Authorization header for protected endpoints
5. Backend validates token for each protected request

## 📊 Database Schema

### Users Collection

```json
{
  "_id": "ObjectId",
  "email": "string",
  "hashed_password": "string",
  "created_at": "datetime"
}
```

### Pets Collection

```json
{
  "_id": "ObjectId",
  "name": "string",
  "type": "string",
  "age": "number",
  "notes": "string",
  "owner_id": "string",
  "created_at": "datetime"
}
```

## 🧪 Testing the Application

### Manual Testing Steps

1. Start the backend server
2. Open API documentation at `http://localhost:8000/docs`
3. Test API endpoints using the interactive docs
4. Run the mobile app and test user flows
5. Verify data persistence in MongoDB

### Test Scenarios

- Register new user
- Login with valid/invalid credentials
- Add pets with various data
- View pets list
- Logout and login again
- Test input validation
- Test network error handling

## 🎯 Key Features Implemented

✅ **Authentication System**

- User registration and login
- JWT token generation and validation
- Secure password hashing
- Token persistence in mobile app

✅ **Pet Management**

- Add pets with complete details
- View pets in a clean list interface
- Input validation for all fields
- Real-time UI updates

✅ **State Management**

- Reactive state with GetX observables
- Centralized state management
- Automatic UI updates on state changes

✅ **Error Handling**

- API error handling and user feedback
- Network error management
- Input validation with clear messages

✅ **Clean Architecture**

- Separation of concerns
- Modular code structure
- Reusable components

## 🔄 Development Workflow

1. Backend development with FastAPI
2. API testing with built-in documentation
3. Mobile app development with Flutter
4. Integration testing
5. UI/UX refinements
6. Error handling implementation
7. Documentation and README creation

## 📈 Future Enhancements

- [ ] Pet photo upload and storage
- [ ] Edit and delete pet functionality
- [ ] Pet care reminders and notifications
- [ ] Data export functionality
- [ ] Dark theme support
- [ ] Offline mode with local database
- [ ] Unit and integration tests
- [ ] CI/CD pipeline setup
- [ ] Docker containerization
- [ ] Cloud deployment (AWS/Azure)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is created for educational purposes as part of an internship assignment.

## 📞 Support

For questions or issues, please refer to the individual README files in the `backend/` and `mobile/` directories for detailed setup instructions.
