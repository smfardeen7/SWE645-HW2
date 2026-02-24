# SWE645 HW2 - Dockerfile for static web app using Tomcat
FROM tomcat:9.0

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your website files into Tomcat root
COPY WebContent/ /usr/local/tomcat/webapps/ROOT/