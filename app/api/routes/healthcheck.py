from fastapi import APIRouter, HTTPException
from app.utils import s3

router = APIRouter()

@router.get("/healthcheck")
def healthcheck():
    if s3.check_health():
        return {"status": "OK"}
    raise HTTPException(status_code=503, detail="S3 target's location is hidden by the Force.")