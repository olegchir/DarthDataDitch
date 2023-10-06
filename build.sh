#!/bin/bash
pwd
if [ -f .env ]; then
    docker build -f docker/Dockerfile.dev --build-arg USE_ENV=.env -t darthdataditch:dev .
else
    docker build --no-cache --build-arg GIT_COMMIT=$(git rev-parse --short HEAD) -f docker/Dockerfile -t darthdataditche:prod .
fi
