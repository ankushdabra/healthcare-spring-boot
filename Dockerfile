# ---------- BUILD STAGE ----------
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
# dependency:go-offline is often problematic with some plugins/configurations
# We'll rely on the package step to download dependencies.
# To optimize caching, we could use 'mvn dependency:resolve' but it's not strictly necessary if we accept re-downloading on pom changes.
RUN mvn dependency:resolve

COPY src ./src
RUN mvn clean package -DskipTests

# ---------- RUNTIME STAGE ----------
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
