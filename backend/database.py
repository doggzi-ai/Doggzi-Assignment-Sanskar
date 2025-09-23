# database.py
from motor.motor_asyncio import AsyncIOMotorClient

MONGO_URI = "mongodb+srv://azuredev:<password>@cluster9424437103.global.mongocluster.cosmos.azure.com/?tls=true&authMechanism=SCRAM-SHA-256&retrywrites=false&maxIdleTimeMS=120000"

client = AsyncIOMotorClient(MONGO_URI)
db = client["mydatabase"]   # choose your db name
