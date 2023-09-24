#!/bin/bash

NAME="DarthDataDitch"                                  # Name of the application
DIR=.                                                  # Application project directory
USER=$(whoami)                                         # the user to run as
GROUP=$(id -gn)                                        # the group to run as
NUM_WORKERS=3                                          # how many worker processes should Gunicorn spawn
UVICORN_WORKER_CLASS="uvicorn.workers.UvicornWorker"   # Uvicorn worker class
APP_MODULE="app.main:app"                              # the application module and app instance
                                                       # AWS profile name
# Start your FastAPI app with Gunicorn
source .env
exec gunicorn --workers $NUM_WORKERS --worker-class $UVICORN_WORKER_CLASS --bind 0.0.0.0:8000 $APP_MODULE
