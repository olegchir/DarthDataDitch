#!/bin/bash
ECR_URL="433663489437.dkr.ecr.eu-central-1.amazonaws.com/darthdataditch-ecr"
APP_VERSION=$(grep '^version:' helm/darthdataditch/Chart.yaml | awk '{print $2}')
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${ECR_URL}
docker build --no-cache --build-arg GIT_COMMIT=$(git rev-parse --short HEAD) -f docker/Dockerfile -t darthdataditch:prod .
docker tag darthdataditch:prod ${ECR_URL}:${APP_VERSION} -t ${ECR_URL}:prod
docker push ${ECR_URL}:${APP_VERSION}
