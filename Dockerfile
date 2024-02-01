FROM openjdk:11 AS BUILD_IMAGE

WORKDIR /app

RUN apt update && apt install maven -y

RUN git clone -b main https://github.com/CharismaticOwl/vprofile-project-githubactions.git

RUN cd app/vprofile-project && mvn install


FROM tomcat:9-jre11

LABEL "Project"="Vprofile-app"
LABEL "Author"="Satya"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE **/vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]