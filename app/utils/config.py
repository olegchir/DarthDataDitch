from decouple import AutoConfig,Csv

config = AutoConfig()

APP_VERSION = config("APP_VERSION", default="0.0.0")
S3_BUCKET_NAME = config("S3_BUCKET_NAME", default="")
AWS_PROFILE_NAME = config("AWS_PROFILE_NAME", default="default")
#Expecting the tokens in galactic format "jedi1:holocronKey1,sithLord2:darkArtifactKey2". Ensure your credentials align with the Force, young Padawan!
USER_TOKENS = dict(item.split(":") for item in config("USER_TOKENS", default="", cast=Csv()))
USER_TOKEN_STRINGS = config("USER_TOKENS", default="", cast=Csv())
if not S3_BUCKET_NAME:
    raise ValueError(f"The Force forgot to set the S3 Bucket Name: {S3_BUCKET_NAME}")
