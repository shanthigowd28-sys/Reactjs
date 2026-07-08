#!/bin/bash

DOCKER_USER=$1
DOCKER_PASS=$2
ENVIRONMENT=$3

if [ "$ENVIRONMENT" = "dev" ]; then
    FILE=docker-compose-dev.yml
else
    FILE=docker-compose-prod.yml
fi

scp $FILE ubuntu@10.0.1.20:/home/ubuntu/app/docker-compose.yml

ssh ubuntu@10.0.1.20 << EOF
cd /home/ubuntu/app

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

docker compose pull
docker compose down
docker compose up -d
EOF
