import logging
from fastapi import FastAPI
from app.api import router_list
from app.utils.config import S3_BUCKET_NAME
from app.utils import s3
import asyncio

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

for router in router_list:
    app.include_router(router)

@app.on_event("startup")
async def startup_event():
    if not s3.check_s3_access(S3_BUCKET_NAME):
        logger.error(f"S3 bucket {S3_BUCKET_NAME} has gone to the Dark Side.")
        raise Exception(f"S3 bucket {S3_BUCKET_NAME} has gone to the Dark Side.")

@app.on_event("shutdown")
async def shutdown_event():
    while s3.InProgress["count"] > 0:
        await asyncio.sleep(1)