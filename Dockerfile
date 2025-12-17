FROM eclipse-temurin:25-jdk-jammy AS base

WORKDIR /build

COPY ./ ./

RUN ./mvnw -B dependency:go-offline
RUN ./mvnw -B package -DskipTests

FROM eclipse-temurin:25-jre-jammy AS final

COPY --from=base build/target/intro-docker-compose-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "app.jar" ]
