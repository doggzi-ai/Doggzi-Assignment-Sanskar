# Pet Management Backend

This is the FastAPI backend for the Pet Management application.

## Features

- User registration and authentication
- JWT token-based authorization
- Pet management (add, list pets)
- MongoDB integration
- CORS enabled for mobile app

## API Endpoints

### Authentication

- `POST /auth/register` - Register new user
- `POST /auth/login` - Login user

### Pets (Requires Authentication)

- `GET /pets` - Get user's pets
- `POST /pets` - Add new pet

## Setup Instructions

### Prerequisites

- Python 3.8+
- MongoDB (local or Atlas)

### Installation

1. Install dependencies:

```bash
pip install -r requirements.txt
```

2. Set up environment variables:
   Copy `.env.example` to `.env` and update MongoDB connection string if needed.

3. Start MongoDB:

- For local MongoDB: Make sure MongoDB service is running
- For MongoDB Atlas: Update MONGODB_URL in .env file

4. Run the application:

```bash
python main.py
```

The API will be available at `http://localhost:8000`

### API Documentation

Visit `http://localhost:8000/docs` for interactive API documentation.

## Project Structure

```
backend/
├── main.py              # Main FastAPI application
├── requirements.txt     # Python dependencies
├── .env                # Environment variables
└── README.md           # This file
```

## Environment Variables

- `MONGODB_URL`: MongoDB connection string
- `DATABASE_NAME`: Database name
- `SECRET_KEY`: JWT secret key
- `ALGORITHM`: JWT algorithm
- `ACCESS_TOKEN_EXPIRE_MINUTES`: Token expiration time
