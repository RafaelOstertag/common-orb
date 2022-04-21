VERSION=$(mvn -B -q help:evaluate -Dexpression='project.version' -DforceStdout=true)

if echo "${VERSION}" | grep -E -- '-SNAPSHOT$' >/dev/null
then
  IS_SNAPSHOT=0
else
  IS_SNAPSHOT=1
fi

if [ "${IS_SNAPSHOT}" -eq 0 ] && [ "${ALLOW_SNAPSHOT}" == "false" ]
then
  echo "Snapshot version found, not allowed. If you want snapshot versions to not fail, set ALLOW_SNAPSHOT to 'true'" >&2
  exit 1
fi

curl \
  -f \
  --header "Content-Type: application/json" \
  --header "Circle-Token: ${CIRCLE_CI_TOKEN}" \
  --request POST \
  --data "{\"branch\":\"master\", \"parameters\":{\"version\": \"${VERSION}\"}}" \
  https://circleci.com/api/v2/project/github/RafaelOstertag/${PROJECT_NAME}/pipeline
