#!/bin/bash
ECR_URL="433663489437.dkr.ecr.eu-central-1.amazonaws.com/darthdataditch-ecr"
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${ECR_URL}

if [ -f .env ]; then
    docker build -f docker/Dockerfile.dev --build-arg USE_ENV=.env -t darthdataditch:dev .
    docker tag darthdataditch:dev ${ECR_URL}:dev
    docker push ${ECR_URL}:dev
else
    docker build --no-cache --build-arg GIT_COMMIT=$(git rev-parse --short HEAD) -f docker/Dockerfile -t darthdataditch:prod .
    docker tag darthdataditch:prod ${ECR_URL}:0.0.4
    docker push ${ECR_URL}:prod
fi