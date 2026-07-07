#!/bin/bash

IMAGE_NAME=$1
TAG=$2

echo "Building Docker Image..."

docker build -t $IMAGE_NAME:$TAG .

echo "Docker Image Built Successfully"