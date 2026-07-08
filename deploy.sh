#!/bin/bash

ssh ubuntu@10.0.1.20 << EOF
cd /home/ubuntu/app

docker compose pull
docker compose down
docker compose up -d
EOF
