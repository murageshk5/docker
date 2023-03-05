FROM alpine AS git
RUN apk update && apk add git
WORKDIR /home/app
RUN git clone https://github.com/murageshk5/java_repo1.git

FROM maven:amazoncorretto AS maven
COPY --from=git /home/app/java_repo1/src /home/java/src
COPY --from=git /home/app/java_repo1/pom.xml /home/java/
WORKDIR /home/java/
RUN mvn clean install

FROM tomcat AS tomcat-config
COPY --from=maven home/java/target/*.war /usr/local/tomcat/webapps