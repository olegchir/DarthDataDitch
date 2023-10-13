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
   logger.info("Initiating hyperdrive shutdown... May the Force be with you during this transition!")
   while s3.InProgress["count"] > 0:
       logger.info(f"Waiting for Hyperdrive deactivation {s3.InProgress['count']} tasks in queue...")
       await asyncio.sleep(1)
   logger.info("Hyperdrive deactivation complete. The Force remains strong with this one! Till the next galactic journey")
   