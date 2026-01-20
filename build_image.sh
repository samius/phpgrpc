#!/bin/bash

TAG_NAME=8.3

if ! docker buildx inspect multiplatform &> /dev/null; then
  echo "Creating multiplatform builder..."
  docker buildx create --use --name multiplatform --driver docker-container
else
  docker buildx use multiplatform
fi


PLATFORM=${1:-"linux/amd64,linux/arm64"}

echo "Building and pushing image for PHP $TAG_NAME on platform(s): $PLATFORM..."
docker buildx build --platform $PLATFORM \
  --build-arg PHP_TAG=$TAG_NAME \
  --provenance=false \
  --sbom=false \
  -t ghcr.io/samius/php_grpc:$TAG_NAME \
  --push .

echo "Done! Image available at: ghcr.io/samius/php_grpc:$TAG_NAME"