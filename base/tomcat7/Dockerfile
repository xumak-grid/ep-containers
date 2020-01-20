# This is pulled from the official tomcat:7-jre8 dockerfile found here
# https://github.com/docker-library/tomcat/blob/master/7-jre8/Dockerfile
# because we wanted to build on top of our CentOS7-OracleJRE8 image
#

# The Docker Registry to pull the base image from 
# If left blank, it wil default to a local build 
# For pulls from AWS ECR, use something like "<awsAccountId>.dkr.ecr.<region>.amazonaws.com"
FROM xk/centos

ARG tomcatmajorversion=7
ARG tomcatversion=7.0.81

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 
	

ENV TOMCAT_MAJOR $tomcatmajorversion
ENV TOMCAT_VERSION $tomcatversion
ENV TOMCAT_TGZ_URL https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN set -x \
	&& curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& curl -fSL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
	&& gpg --verify tomcat.tar.gz.asc \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz*

EXPOSE 8080

CMD ["/bin/sh","-c","/usr/local/tomcat/bin/catalina.sh run >> /usr/local/tomcat/logs/catalina.out 2>&1"]

