#!/bin/bash
pwd
if [ -f .env ]; then
    docker build -f docker/Dockerfile --build-arg USE_ENV=.env -t darthdataditch:dev .
else
    docker build -f docker/Dockerfile -t darthdataditche:prod .
fi
