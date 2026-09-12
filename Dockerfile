FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/jenkins-devops-practice-1.0-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]