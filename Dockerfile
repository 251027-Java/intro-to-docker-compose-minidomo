FROM eclipse-temurin:25-jdk-jammy as base

WORKDIR /build

COPY ./ ./

RUN ./mvnw -B dependency:go-offline
RUN ./mvnw -B package -DskipTests

FROM eclipse-temurin:25-jre-jammy as final

COPY --from=base build/target/intro-docker-compose-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]
