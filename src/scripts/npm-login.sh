if [ -z "${NPM_TOKEN_READ}" ]
then
  echo "Require \$NPM_TOKEN_READ to be set" >&2
  exit 1
fi

npm config set '@rafaelostertag:registry' 'https://rafaelostertag.jfrog.io/artifactory/api/npm/npm/'
npm config set '//rafaelostertag.jfrog.io/artifactory/api/npm/npm/:_authToken' "${NPM_TOKEN_READ}"

