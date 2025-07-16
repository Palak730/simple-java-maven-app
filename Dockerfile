# Build stage: Use Maven 3.9.9 with Eclipse Temurin JDK 24
FROM maven:3.9.9-eclipse-temurin-24 AS build

WORKDIR /app

# Copy all project files
COPY . .

# Build the project, skip tests to speed up
RUN mvn clean package -DskipTests

# Runtime stage: Use lightweight JDK Alpine image
FROM eclipse-temurin:24-jdk-alpine

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy JAR from build stage (assuming only one JAR in target)
COPY --from=build /app/target/*.jar app.jar

# Change ownership of app directory
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Expose port if your app listens on one (optional)
# EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
