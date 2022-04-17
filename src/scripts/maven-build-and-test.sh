mvn -s "$HOME/project/.circleci/settings.xml" \
 -Psecurity-scan \
 -B \
 -Dsonar.projectKey="${SONAR_PROJECT_KEY}" \
 -Dsonar.qualitygate.wait=true \
 clean \
 install \
 sonar:sonar
