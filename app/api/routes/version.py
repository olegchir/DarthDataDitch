from fastapi import APIRouter
from app.utils.config import APP_VERSION

router = APIRouter()

@router.get("/version")
def version():
    return {"version": APP_VERSION}