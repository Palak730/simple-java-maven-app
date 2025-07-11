# Use a base image with Java runtime
FROM eclipse-temurin:24-jre

# Set the working directory inside the container
WORKDIR /app

# Copy the built jar file into the image
COPY target/*.jar app.jar

# Set the default command to run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
