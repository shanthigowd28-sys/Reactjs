#!/bin/bash

IMAGE_NAME=$1
TAG=$2
ssh ubuntu@3.109.124.255
docker compose pull
docker compose down
docker compose up -d
