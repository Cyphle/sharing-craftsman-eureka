#!/usr/bin/env bash

echo "Copying deployable files in app folder"
rm -rf $1
mkdir $1
cp scripts/docker-compose.yml $1/docker-compose.yml
cp scripts/Dockerfile $1/Dockerfile
cp scripts/eureka-infos.yml $1/eureka-infos.yml
cp scripts/update-dockerfile.sh $1/update-dockerfile.sh
cp target/eureka-1.0.jar $1/eureka.jar
echo "End copying deployable files in app folder"