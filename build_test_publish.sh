#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-devops-challenge-app}"
IMAGE_TAG="${IMAGE_TAG:-local}"
TARBALL="${TARBALL:-package.tar.gz}"

echo "==> Building image..."
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .

echo "==> Testing image..."
container_id="$(docker run -d -p 8080:8080 "${IMAGE_NAME}:${IMAGE_TAG}")"
cleanup() { docker rm -f "$container_id" >/dev/null 2>&1 || true; }
trap cleanup EXIT

healthy=0
for _ in {1..30}; do
  status="$(docker inspect -f '{{.State.Health.Status}}' "$container_id" 2>/dev/null || true)"
  if [ "$status" = "healthy" ]; then
    healthy=1
    break
  fi
  sleep 1
done
if [ "$healthy" -ne 1 ]; then
  docker logs "$container_id"
  echo "healthcheck failed" >&2
  exit 1
fi

echo "Container is healthy."

echo "==> Publishing image (local artifact)..."
docker save "${IMAGE_NAME}:${IMAGE_TAG}" | gzip > "${TARBALL}"
echo "Saved ${TARBALL}"
