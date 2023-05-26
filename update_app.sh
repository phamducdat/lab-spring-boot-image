#!/bin/bash


# Get a list of all containers with the 'springboot-docker-demo' image
containers=$(docker ps -a -q --filter ancestor=springboot-docker-demo)

# For each container
for container in $containers
do
  # Stop the container
  echo "Stopping container $container..."
  docker stop $container

  # Remove the container
  echo "Removing container $container..."
  docker rm $container
done

echo "All 'springboot-docker-demo' containers have been stopped and removed."

docker image prune --force

# build your Spring Boot application
mvn clean install

# build your Docker image
docker build -t springboot-docker-demo:latest .

docker run -d -p 8081:8080 springboot-docker-demo
