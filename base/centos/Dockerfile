# Builds our base CentOS 7 (latest) image from the offical centos image
# which includes Oracle Java 8 update 144. Script contents borrowed from:
# https://github.com/nimmis/docker-java-centos/blob/master/oracle-8-jre/Dockerfile
#
FROM centos:centos7

ARG javadownloadurl=https://javadl.sun.com/webapps/download/AutoDL?BundleId=225344_090f390dda5b47b9b721c7dfaa008135

# Install JRE 8 Update 144
RUN rpm -i $javadownloadurl

# Install other tools
RUN yum install -y bind-utils && yum -y clean all

# Set environment variables.
ENV HOME /root
ENV JAVA_HOME /usr/java/latest

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
