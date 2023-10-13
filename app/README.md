# DarthDataDitch
Simple upload api

## Description
DarthDataDitch is a Python application that provides possibility to upload files to redundant storage.
## Installation
1. Clone the repository: `git clone https://github.com/zloykaban/DarthDataDitch.git`
1. Setup venv
2. Install the required dependencies: `pip install -r requirements.txt`

## Configuration
CONFIGURATIO IS DONE BY USING OS ENV variables and you need following
1. `USER_TOKENS` - please provide here a list of user:hash for accessing to endpoints, e.g. USER_TOKENS="jedi1:bcrypt_salted_hash,jedi2:bcrypt_salted_hash2"
2. `S3_BUCKET_NAME` - please make sure that you execute app from the place where passwod not needed or you place proper credentials for AWS
3. It is acceptable to create .env and put there all needed variables for example:
```
S3_BUCKET_NAME=eu-darthdataditch
AWS_PROFILE_NAME=s3-darthdataditch
APP_VERSION=${GIT_TAG:-${GIT_COMMIT_HASH}}
AWS_ACCESS_KEY_ID=aws_key_id
AWS_SECRET_ACCESS_KEY=aws_secret_key
USER_TOKENS="jedi:$2b$12$/H4m9GGeXlVwRvTvHgu7R.pm2fD7PjMhzRIA8dr3H/sujBPAGZbfC"
```
## Usage
1. Run the application: `uvicorn app.main:app`
2. Use curl Luke! `http://localhost:8000`.
3. Use the application to put data to Holocon archives

## Endpoints
- `/`: Returns a help.
- `/upload`: Use POST to sent file to archive.
- `/version`: Returns app version.
- `/healthcheck`: needed for executing DarthDataDitch in EKS/K8S.
