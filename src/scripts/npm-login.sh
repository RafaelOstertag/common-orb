if [ -z "${NPM_TOKEN}" ]
then
  echo "Require \$NPM_TOKEN to be set" >&2
  exit 1
fi

npm config set '@rafaelostertag:registry' 'https://rafaelostertag.jfrog.io/artifactory/api/npm/npm/'
npm config set '//rafaelostertag.jfrog.io/artifactory/api/npm/npm/:_authToken' "${NPM_TOKEN}"

