FROM openjdk:11 AS BUILD_IMAGE

WORKDIR /vprofile-project

RUN apt update && apt install maven -y

COPY ./ vprofile-project/

RUN cd vprofile-project && git checkout docker && mvn install


FROM tomcat:9-jre11

LABEL "Project"="Vprofile-app"
LABEL "Author"="Satya"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]