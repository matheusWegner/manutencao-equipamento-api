FROM openjdk:21-jdk-slim AS build

RUN apt-get update && \
    apt-get install -y wget unzip tzdata && \
    wget https://archive.apache.org/dist/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.zip && \
    unzip apache-maven-3.9.5-bin.zip -d /opt && \
    ln -s /opt/apache-maven-3.9.5/bin/mvn /usr/bin/mvn && \
    rm apache-maven-3.9.5-bin.zip

ENV TZ=America/Sao_Paulo

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean install -DskipTests

FROM openjdk:21-jdk-slim
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-Duser.timezone=America/Sao_Paulo", "-jar", "app.jar"]