# SWE645 HW2 - Dockerfile to containerize the Student Survey web app
FROM tomcat:9.0
RUN rm -rf /usr/local/tomcat/webapps/*
COPY StudentSurvey.war /usr/local/tomcat/webapps/StudentSurvey.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
