import os
import logging
import boto3
from botocore.exceptions import BotoCoreError, ClientError, PartialCredentialsError
from .config import S3_BUCKET_NAME, AWS_PROFILE_NAME

InProgress = {"count": 0}

logging.basicConfig(level=logging.ERROR)
logger = logging.getLogger(__name__)

credentials_path = os.path.expanduser("~/.aws/credentials")

if os.path.exists(credentials_path):
    session = boto3.Session(profile_name=AWS_PROFILE_NAME)
else:
    session = boto3.Session()

_s3_client = None

InProgress = {"count": 0}

def get_s3_client():
    global _s3_client
    if _s3_client is None:
        #_s3_client = session.client("s3", region_name="eu-central-1")
        _s3_client = session.client("s3")
    return _s3_client

async def upload_file_to_s3(file_contents: bytes, filename: str):
#    global InProgress
    try:
        # No need to read from file here, as we're already passing file_contents
        get_s3_client().put_object(
            Bucket=S3_BUCKET_NAME,
            Key=filename,
            Body=file_contents,
        )
        return {"status": "The Force is strong with this one!", "message": f"{filename} Hyperdrived to {S3_BUCKET_NAME}"}
    except Exception as e:
        return {"status": "It's a trap!", "message": str(e)}
    finally:
        InProgress["count"] -= 1

def check_s3_access(bucket_name: str) -> bool:
    try:
        get_s3_client().head_bucket(Bucket=bucket_name)
        return True
    except ClientError as e:
        error_code = int(e.response['Error']['Code'])
        if error_code == 404:
            logger.error(f"In a galaxy far, far away... the S3 bucket {bucket_name} was nowhere to be found.")
        elif error_code == 403:
            logger.error(f"Rebel forces have blocked access to the S3 bucket {bucket_name}.")
        else:
            logger.error(f"The Force was disrupted while accessing S3 bucket {bucket_name}. Dark Side says: {e.response['Error']['Message']}.")
        return False
    except PartialCredentialsError:
        logger.error(f"These aren't the AWS credentials you're looking for. Check your configuration, young Padawan.")
        return False
    except BotoCoreError as e:
        logger.error(f"Chewie, we have a problem! A BotoCore disturbance in the Force while accessing S3 bucket {bucket_name}. Wookiee error says: {str(e)}.")
        return False
