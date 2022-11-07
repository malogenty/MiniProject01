#!/bin/bash

# login DockerHub
docker login --username $DOCKER_HUB_USER --password $DOCKER_HUB_PASS

# Push Dockerfile to DockerHub
sudo curl -L https://raw.githubusercontent.com/docker/compose-cli/main/scripts/install/install_linux.sh | sh
sudo docker-compose -f docker-compose.build.yml build
sudo docker-compose -f docker-compose.build.yml push

# # Installing AWS CLI
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip > /dev/null
# sudo ./aws/install

sudo docker context create ecs deploy --from-env
sudo docker context create ecs --from-env deploy
sudo docker context use deploy
sudo docker-compose -f docker-compose.prod.yml up

# # Login AWS
# aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
# aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
# aws configure set region $AWS_DEFAULT_REGION

# Update service
# aws ecs update-service --cluster $ECS_CLUSTER_NAME --service $ECS_SERVICE_WEB --force-new-deployment
# aws ecs update-service --cluster $ECS_CLUSTER_NAME --service $ECS_SERVICE_CLIENT --force-new-deployment