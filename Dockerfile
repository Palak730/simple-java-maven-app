# Use an official OpenJDK runtime as the base image
FROM eclipse-temurin:24-jdk

# Set working directory inside the container
WORKDIR /app

# Copy the built jar file from the target folder into the container
# Adjust the jar file name if yours is different
COPY target/my-app.jar app.jar

# Expose the port your app listens on (adjust if needed)
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
