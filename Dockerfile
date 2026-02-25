# SWE645 HW2 - Dockerfile for StudentSurvey WAR on Tomcat (slim, amd64)
FROM tomcat:9.0-jre11-temurin

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the StudentSurvey WAR into Tomcat webapps
COPY StudentSurvey.war /usr/local/tomcat/webapps/StudentSurvey.war
