# Use Maven 3.9.9 with JDK 17 to build the app
FROM maven:3.9.9-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy all project files to container
COPY . .

# Build the project and create JAR file
RUN mvn clean package -DskipTests

# Use a lightweight JDK runtime to run the app
FROM eclipse-temurin:17-jdk-alpine

# Set working directory in runtime container
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
