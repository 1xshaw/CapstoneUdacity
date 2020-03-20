#!/bin/bash
docker_name="udacityclouddevopsnanodegree"
echo "Docker image name changed to : $docker_name"
docker build --tag=$docker_name .
docker image ls
docker run -it -d -p 5000:80 $docker_name
