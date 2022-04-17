mvn -B \
  -s "$(eval echo ${MVN_SETTINGS_FILE})" \
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
