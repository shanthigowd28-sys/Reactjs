#!/bin/bash

IMAGE_NAME=$1
TAG=$2
ssh ubuntu@13.126.153.77
docker compose pull
docker compose down
docker compose up -d