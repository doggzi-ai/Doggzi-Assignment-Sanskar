from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from fastapi.middleware.cors import CORSMiddleware
from motor.motor_asyncio import AsyncIOMotorClient
from pydantic import BaseModel
from pydantic.networks import EmailStr
from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta
from typing import Optional, List
import os
from dotenv import load_dotenv
from bson import ObjectId

load_dotenv()

app = FastAPI(title="Pet Management API", version="1.0.0")

# CORS middleware for Flutter app
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Security
security = HTTPBearer()
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Configuration
SECRET_KEY = os.getenv("SECRET_KEY", "fallback-secret-key")
ALGORITHM = os.getenv("ALGORITHM", "HS256")
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", "30"))

# MongoDB (Cosmos DB Mongo API) connection
MONGODB_URL = os.getenv("MONGODB_URL")  # store full cosmos connection string here
DATABASE_NAME = os.getenv("DATABASE_NAME", "pet_management")

try:
    client = AsyncIOMotorClient(MONGODB_URL, tls=True, tlsAllowInvalidCertificates=False)
    db = client[DATABASE_NAME]
    users_collection = db.users
    pets_collection = db.pets
    print("✅ Connected to Cosmos DB successfully")
except Exception as e:
    print(f"❌ Error connecting to Cosmos DB: {e}")


# Pydantic models
class UserRegister(BaseModel):
    email: EmailStr
    password: str


class UserLogin(BaseModel):
    email: EmailStr
    password: str


class Token(BaseModel):
    access_token: str
    token_type: str


class Pet(BaseModel):
    name: str
    type: str
    age: int
    notes: Optional[str] = ""


class PetResponse(BaseModel):
    id: str
    name: str
    type: str
    age: int
    notes: str
    owner_id: str


# Utility functions
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    return pwd_context.hash(password)


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        token = credentials.credentials
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: Optional[str] = payload.get("sub")
        if email is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception

    user = await users_collection.find_one({"email": email})
    if user is None:
        raise credentials_exception
    return user


# API Routes
@app.get("/")
async def root():
    return {"ok": True}


@app.post("/auth/register", response_model=Token)
async def register(user: UserRegister):
    if await users_collection.find_one({"email": user.email}):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, detail="Email already registered"
        )

    hashed_password = get_password_hash(user.password)
    user_doc = {
        "email": user.email,
        "hashed_password": hashed_password,
        "created_at": datetime.utcnow(),
    }

    await users_collection.insert_one(user_doc)

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.email}, expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "bearer"}


@app.post("/auth/login", response_model=Token)
async def login(user: UserLogin):
    db_user = await users_collection.find_one({"email": user.email})
    if not db_user or not verify_password(user.password, db_user["hashed_password"]):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.email}, expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "bearer"}


@app.get("/pets", response_model=List[PetResponse])
async def get_pets(current_user: dict = Depends(get_current_user)):
    pets_cursor = pets_collection.find({"owner_id": str(current_user["_id"])})
    pets = await pets_cursor.to_list(100)

    return [
        PetResponse(
            id=str(pet["_id"]),
            name=pet["name"],
            type=pet["type"],
            age=pet["age"],
            notes=pet.get("notes", ""),
            owner_id=pet["owner_id"],
        )
        for pet in pets
    ]


@app.post("/pets", response_model=PetResponse)
async def add_pet(pet: Pet, current_user: dict = Depends(get_current_user)):
    pet_doc = {
        "name": pet.name,
        "type": pet.type,
        "age": pet.age,
        "notes": pet.notes or "",
        "owner_id": str(current_user["_id"]),
        "created_at": datetime.utcnow(),
    }

    result = await pets_collection.insert_one(pet_doc)

    return PetResponse(
        id=str(result.inserted_id),
        name=pet.name,
        type=pet.type,
        age=pet.age,
        notes=pet.notes or "",
        owner_id=str(current_user["_id"]),
    )


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
