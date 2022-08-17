#!/bin/sh
#
# Author: @santanamobile
# Script for portainer upgrade
#

docker stop portainer
sleep 6

docker rm portainer
sleep 3

docker pull portainer/portainer-ce:latest
sleep 6

docker run -d -p 8000:8000 -p 9000:9000 \
    --name=portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
