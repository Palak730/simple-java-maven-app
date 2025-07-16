# Stage 1: Build the app with Maven
FROM maven:3.9.4-eclipse-temurin-24 AS build

WORKDIR /app

# Copy Maven config files first to cache dependencies
COPY pom.xml .
COPY src ./src

# Build the jar, skipping tests
RUN mvn -B package -DskipTests

# Stage 2: Create the runtime image
FROM eclipse-temurin:24-jdk

WORKDIR /app

# Copy the jar from the build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

