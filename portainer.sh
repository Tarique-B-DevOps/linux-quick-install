#!/bin/bash

VOLUME_NAME="portainer_data"
CONTAINER_NAME="portainer"
IMAGE_NAME="portainer/portainer-ce:lts"

check_docker() {
  if command -v docker &> /dev/null; then
    echo "Docker is installed. Version: $(docker --version)"
    return 0
  else
    echo "❌ Docker is not installed."
    return 1
  fi
}

check_portainer_volume() {
  if docker volume inspect "$VOLUME_NAME" &> /dev/null; then
    echo "Docker volume '$VOLUME_NAME' already exists."
    return 0
  else
    return 1
  fi
}

create_portainer_volume() {
  echo "Creating Docker volume '$VOLUME_NAME'..."
  docker volume create "$VOLUME_NAME"
  echo "Volume created."
}

check_portainer_container() {
  if docker ps -a --format '{{.Names}}' | grep -w "$CONTAINER_NAME" &> /dev/null; then
    echo "Container '$CONTAINER_NAME' already exists."
    return 0
  else
    return 1
  fi
}

run_portainer_container() {
  echo "Running Portainer container..."
  docker run -d \
    -p 8000:8000 \
    -p 9443:9443 \
    --name "$CONTAINER_NAME" \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$VOLUME_NAME":/data \
    "$IMAGE_NAME"
  echo "Portainer container started."
}

if ! check_docker; then
  echo "Please install Docker and re-run this script."
  exit 1
fi

if ! check_portainer_volume; then
  create_portainer_volume
fi

if ! check_portainer_container; then
  run_portainer_container
else
  echo "No action needed. Portainer is already running or exists."
fi

echo "🔗 Open Portainer at: https://localhost:9443"

