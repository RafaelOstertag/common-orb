if [ -z "$IMAGE_TAG" ]; then
  echo "*** No image tag supplied, detect IMAGE_TAG"
  POM_VERSION=$(mvn -q help:evaluate -DforceStdout -Dexpression='project.version')

  IMAGE_TAG=""
  if echo "$POM_VERSION" | grep -E -- '-SNAPSHOT$' >/dev/null; then
    IMAGE_TAG="latest"
  else
    IMAGE_TAG="${POM_VERSION}"
  fi

  echo "****"
  echo "POM_VERSION: ${POM_VERSION}"
  echo "****"
fi

echo "****"
echo "IMAGE_TAG: ${IMAGE_TAG}"
echo "****"


docker manifest push --purge "${IMAGE_NAME}:${IMAGE_TAG}"
