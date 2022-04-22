mvn -s "$HOME/project/.circleci/settings.xml" -DskipTests deploy -Dquarkus.package.type=uber-jar
