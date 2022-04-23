mvn -s "$HOME/project/.circleci/settings.xml" \
 -Dsonar.projectKey="${SONAR_PROJECT_KEY}" \
 -Dsonar.qualitygate.wait=true \
 sonar:sonar
