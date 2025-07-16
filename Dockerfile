# Stage 1: Build the app using Maven + SapMachine JDK
FROM maven:sapmachine AS build

WORKDIR /app

# Copy pom.xml and src to container
COPY pom.xml .
COPY src ./src

# Build the JAR file, skipping tests for speed
RUN mvn -B package -DskipTests

# Stage 2: Create a smaller runtime image with JDK 24
FROM eclipse-temurin:24-jdk

WORKDIR /app

# Copy only the built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose app port (optional, e.g., for Spring Boot or other HTTP apps)
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
