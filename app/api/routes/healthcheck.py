from fastapi import APIRouter, HTTPException
from app.utils import s3
from app.utils.config import S3_BUCKET_NAME


router = APIRouter()

@router.get("/healthcheck")
def healthcheck():
    if s3.check_s3_access(S3_BUCKET_NAME):
        return {"status": "OK"}
    raise HTTPException(status_code=503, detail="S3 target's location is hidden by the Force.")

