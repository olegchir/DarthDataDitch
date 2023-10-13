from fastapi import APIRouter, UploadFile, File, Depends, BackgroundTasks
from app.utils import s3, auth

router = APIRouter()

@router.post("/upload")
async def upload(file: UploadFile = File(...), user: str = Depends(auth.get_current_user)):
    s3.InProgress["count"] += 1
    file_contents = await file.read()
    result = await s3.upload_file_to_s3(file_contents, file.filename)
    #return await s3.upload_file_to_s3(file_contents, file.filename)
    return result