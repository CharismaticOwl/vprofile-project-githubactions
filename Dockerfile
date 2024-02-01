FROM openjdk:11 AS BUILD_IMAGE

RUN sudo apt update && sudo apt install maven -y

COPY ./ vprofile-project

RUN cd vprofile-project && mvn install

FROM tomcat:9-jre17

LABEL "Project"='vprofile'

LABEL "Author"="Satya"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]