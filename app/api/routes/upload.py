from fastapi import APIRouter, UploadFile, File
from app.utils import s3

router = APIRouter()

@router.post("/upload")
async def upload(file: UploadFile = File(...)):
    file_contents = await file.read()
    return await s3.upload_file_to_s3(file_contents, file.filename)