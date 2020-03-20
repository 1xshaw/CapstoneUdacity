#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

dockerpath="udacityclouddevopsnanodegree"

echo "Docker ID and Image: $dockerpath"
docker tag $dockerpath devinyang1992/$dockerpath
docker login

docker push devinyang1992/$dockerpath:$1