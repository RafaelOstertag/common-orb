if [ -z "$IMAGE_TAG" ]; then
  echo "*** No image tag supplied, detect IMAGE_TAG"
  POM_VERSION=$(mvn -q help:evaluate -DforceStdout -Dexpression='project.version')

  IMAGE_TAG=""
  if echo "$POM_VERSION" | grep -E '-SNAPSHOT$' >/dev/null; then
    IMAGE_TAG="latest"
  else
    IMAGE_TAG="POM_VERSION"
  fi

  echo "****"
  echo "POM_VERSION: ${POM_VERSION}"
  echo "****"
fi

echo "****"
echo "IMAGE_TAG: ${IMAGE_TAG}"
echo "****"

mvn -B \
  -s "$HOME/project/.circleci/settings.xml" \
  clean \
  package \
  -DskipTests \
  -Dnative \
  -Dquarkus.docker.dockerfile-native-path="${DOCKER_FILE}" \
  -Dquarkus.container-image.build=true \
  -Dquarkus.container-image.tag="${IMAGE_TAG}" \
  -Dquarkus.container-image.group="${IMAGE_GROUP}" \
  -Dquarkus.container-image.push="${PUSH_IMAGE}" \
  -Dquarkus.container-image.username="${DOCKER_USERNAME}" \
  -Dquarkus.container-image.password="${DOCKER_TOKEN}"
