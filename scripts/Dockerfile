FROM openjdk:8-jdk-alpine

RUN apk add --no-cache bash
RUN apk add --no-cache vim

VOLUME /tmp
ADD eureka.jar eureka.jar

EXPOSE 8080

ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /eureka.jar
