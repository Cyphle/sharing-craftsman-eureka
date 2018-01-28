#!/usr/bin/env bash

echo "Removing old files"
rm -f $1/docker-compose.yml
rm -f $1/Dockerfile
rm -f $1/eureka.jar
rm -f $1/../README.md
echo "End removing old files"

echo "Copying deployable files in app folder"
mkdir $1
cp docker-compose.yml $1/docker-compose.yml
cp Dockerfile $1/Dockerfile
cp ../target/eureka-1.0.jar $1/user.jar
echo "End copying deployable files in app folder"