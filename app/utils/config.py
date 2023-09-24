from decouple import AutoConfig

config = AutoConfig()

APP_VERSION = config("APP_VERSION", default="0.0.0")
S3_BUCKET_NAME = config("S3_BUCKET_NAME", default="")
AWS_PROFILE_NAME = config("AWS_PROFILE_NAME", default="default")

if not S3_BUCKET_NAME:
    raise ValueError(f"The Force forgot to set the S3 Bucket Name: {S3_BUCKET_NAME}")
