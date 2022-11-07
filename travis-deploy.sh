#!/bin/bash

# login DockerHub
docker login --username $DOCKER_HUB_USER --password $DOCKER_HUB_PASS

# Push Dockerfile to DockerHub
sudo curl -L https://raw.githubusercontent.com/docker/compose-cli/main/scripts/install/install_linux.sh | sh
sudo docker-compose -f docker-compose.build.yml build
sudo docker-compose -f docker-compose.build.yml push

# Create ECS environment and deploy services on AWS
sudo docker context create ecs deploy --from-env
sudo docker context create ecs --from-env deploy
sudo docker context use deploy
sudo docker compose -f docker-compose.prod.yml up