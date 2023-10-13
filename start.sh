#!/bin/bash

NAME="DarthDataDitch"                                  # Name of the application
DIR=.                                                  # Application project directory
USER=$(whoami)                                         # the user to run as
GROUP=$(id -gn)                                        # the group to run as
NUM_WORKERS=1                                          # how many worker processes should Gunicorn spawn
UVICORN_WORKER_CLASS="uvicorn.workers.UvicornWorker"   # Uvicorn worker class
APP_MODULE="app.main:app"                              # the application module and app instance
                                                       # AWS profile name
# Start your FastAPI app with Gunicorn
#exec gunicorn --workers $NUM_WORKERS --bind 0.0.0.0:8000 -k $UVICORN_WORKER_CLASS $APP_MODULE
exec uvicorn ${APP_MODULE} --reload --host 0.0.0.0 --port 8000 
