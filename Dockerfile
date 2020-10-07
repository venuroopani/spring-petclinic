FROM tomcat:8.0
MAINTAINER MS
# COPY path-to-your-application-war path-to-webapps-in-docker-tomcat
COPY target/petclinic.war /usr/local/tomcat/webapps/
