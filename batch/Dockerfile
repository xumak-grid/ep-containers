FROM /grid/tomcat:7.0.85-jre8 as builder

RUN apk add --update unzip; \
    mkdir -p /usr/local/tomcat/conf/Catalina/localhost /ep/conf /ep/assets
COPY config/ep/ /ep/conf
RUN [ ! -f /ep/conf/ep.properties ] && echo "# started an empty ep.properties file" >> /ep/conf/ep.properties

ADD webapps /webapps
RUN unzip -q /webapps/*assets*.zip -d /ep/assets; \
    unzip -q /webapps/*-batch-* -d /usr/local/tomcat/webapps/batch
ADD tools/activemq/lib/*.jar /usr/local/tomcat/lib/
ADD database/jdbc/*.jar /usr/local/tomcat/lib/

COPY batch.xml /usr/local/tomcat/conf/Catalina/localhost/
COPY setenv.sh /usr/local/tomcat/bin/
COPY settings.xml tomcat-users.xml server.xml /usr/local/tomcat/conf/

FROM registry.xumak.gt:5000/grid/tomcat:7.0.85-jre8
LABEL maintainer="Eddy Hernández ehernandez@xumak.com"
LABEL com.grid.vendor="EP"
ENV BATCH_MEMORY="2048"
RUN apk add --no-cache bind-tools
COPY --from=builder /ep /ep
COPY --from=builder /usr/local/tomcat /usr/local/tomcat
