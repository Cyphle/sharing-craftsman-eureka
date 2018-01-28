#!/usr/bin/env bash

echo "Copying deployable files in app folder"
rm -rf $1
mkdir $1
cp scripts/docker-compose.yml $1/docker-compose.yml
cp scripts/Dockerfile $1/Dockerfile
cp target/eureka-1.0.jar $1/eureka.jar
cd target
ls
echo "End copying deployable files in app folder"

#echo "Removing old files"
#rm -f $1/docker-compose.yml
#rm -f $1/Dockerfile
#rm -f $1/eureka.jar
#rm -f $1/../README.md
#echo "End removing old files"