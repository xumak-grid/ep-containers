FROM /xumak/oracle-8-jre:8u172

LABEL maintainer="Eddy Hernández ehernandez@xumak.com"
LABEL com.grid.vendor="EP"

ENV ACTIVEMQ_VERSION 5.14.3
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION
ENV ACTIVEMQ_HOME /opt/activemq
ENV ACTIVEMQ_MEMORY 2048

EXPOSE 61612 61613 61616 8161

RUN apk --no-cache add curl tar; \
    mkdir /opt; \
    curl https://archive.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz | tar -xz -C /opt; \
    ln -s /opt/$ACTIVEMQ $ACTIVEMQ_HOME; \
    addgroup -S activemq; \
    adduser -S -H -G activemq -h $ACTIVEMQ_HOME activemq; \
    chown -R activemq:activemq /opt/$ACTIVEMQ; \
    chown -h activemq:activemq $ACTIVEMQ_HOME; \
    mkdir -p /ep; \
    apk del tar curl

USER activemq
COPY start-activemq.sh /ep/start-activemq.sh
CMD /ep/start-activemq.sh
