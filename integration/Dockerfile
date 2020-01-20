FROM /grid/tomcat:7.0.85-jre8 as builder

RUN apk add --update unzip; \
    mkdir -p /usr/local/tomcat/conf/Catalina/localhost /ep/conf /ep/assets
COPY config/ep/ /ep/conf
RUN [ ! -f /ep/conf/ep.properties ] && echo "# started an empty ep.properties file" >> /ep/conf/ep.properties

ADD webapps /webapps
RUN unzip -q /webapps/*assets*.zip -d /ep/assets; \
    unzip -q /webapps/*-integration-* -d /usr/local/tomcat/webapps/integration
ADD tools/activemq/lib/*.jar /usr/local/tomcat/lib/
ADD database/jdbc/*.jar /usr/local/tomcat/lib/

COPY integration.xml /usr/local/tomcat/conf/Catalina/localhost/
COPY setenv.sh /usr/local/tomcat/bin/
COPY settings.xml tomcat-users.xml server.xml /usr/local/tomcat/conf/

ADD tools /tools
RUN unzip -q /tools/ext-sync-cli-* -d /usr/local/tomcat/webapps/integration; \
    mkdir mkdir -p /ep/dstData && mkdir -p /ep/ext-sync-cli
RUN mv /tools/ext-sync-cli-* /ep/ext-sync-cli

FROM /grid/tomcat:7.0.85-jre8
LABEL maintainer="Eddy Hernández ehernandez@xumak.com"
LABEL com.grid.vendor="EP"
ENV INTEGRATION_MEMORY="2048"
RUN apk add --no-cache bind-tools
COPY --from=builder /ep /ep
COPY --from=builder /usr/local/tomcat /usr/local/tomcat
