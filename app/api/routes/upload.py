from fastapi import APIRouter, UploadFile, File
from app.utils import s3

router = APIRouter()

@router.post("/upload")
async def upload(file: UploadFile = File(...)):
    return await s3.upload_file(file)