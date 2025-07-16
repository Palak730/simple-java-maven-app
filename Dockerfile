# Stage 1: Build the app with Maven
FROM maven:sapmachine AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -B package -DskipTests

# Stage 2: Runtime with Java 24
FROM eclipse-temurin:24-jdk

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

