if [ -z "$IMAGE_TAG" ]; then
  echo "*** No image tag supplied, detect IMAGE_TAG"
  POM_VERSION=$(mvn -q help:evaluate -DforceStdout -Dexpression='project.version')

  IMAGE_TAG=""
  if echo "$POM_VERSION" | grep -E -- '-SNAPSHOT$' >/dev/null; then
    IMAGE_TAG="latest"
  else
    IMAGE_TAG="${POM_VERSION}"
  fi

  MACHINE=$(uname -m)
  case "${MACHINE}" in
  x86_64)
    VERSION_SUFFIX="amd64"
    ;;
  aarch64)
    VERSION_SUFFIX="arm64"
    ;;
  *)
    echo "${MACHINE} is not supported" >&2
    exit 2
  esac

  IMAGE_TAG="${IMAGE_TAG}-${VERSION_SUFFIX}"

  echo "****"
  echo "Machine: ${MACHINE} -> ${VERSION_SUFFIX}"
  echo "POM_VERSION: ${POM_VERSION}"
  echo "****"
fi

echo "****"
echo "IMAGE_TAG: ${IMAGE_TAG}"
echo "****"

mvn -s "$HOME/project/.circleci/settings.xml" \
  clean \
  package \
  -DskipTests \
  -Dquarkus.container-image.build=true \
  -Dquarkus.container-image.tag="${IMAGE_TAG}" \
  -Dquarkus.container-image.group="${IMAGE_GROUP}" \
  -Dquarkus.container-image.push="${PUSH_IMAGE}" \
  -Dquarkus.container-image.username="${DOCKER_USERNAME}" \
  -Dquarkus.container-image.password="${DOCKER_TOKEN}"
