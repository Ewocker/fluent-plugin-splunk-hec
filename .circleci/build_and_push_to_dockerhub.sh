#!/usr/bin/env bash
set -e
echo "Building docker image..."
cp /tmp/pkg/fluent-plugin-splunk-hec-*.gem docker
VERSION=`cat VERSION`
docker build --build-arg VERSION=$VERSION --no-cache -t ewocker/fluent-plugin-splunk-hec:ci ./docker
docker tag ewocker/fluent-plugin-splunk-hec:ci ewocker/${DOCKERHUB_REPO_NAME}:${VERSION}
echo "Push docker image to splunk dockerhub..."
docker login --username=$DOCKERHUB_ACCOUNT_ID --password=$DOCKERHUB_ACCOUNT_PASS
docker push ewocker/${DOCKERHUB_REPO_NAME}:${VERSION} | awk 'END{print}'
echo "Docker image pushed successfully to docker-hub."