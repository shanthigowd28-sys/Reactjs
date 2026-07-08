#!/bin/bash

IMAGE_NAME=$1
TAG=$2
ssh ubuntu@10.0.1.20
docker compose pull
docker compose down
docker compose up -d
