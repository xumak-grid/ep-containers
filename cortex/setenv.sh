#!/bin/sh
export CATALINA_HOME="/usr/local/tomcat"

export CATALINA_PID="/usr/local/tomcat/bin/catalina.pid"

export CATALINA_OPTS=" -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties -Dcatalina.home=/usr/local/tomcat -Xms${CORTEX_MEMORY}m -Xmx${CORTEX_MEMORY}m -Xdebug -Xrunjdwp:transport=dt_socket,address=1081,server=y,suspend=n -XX:+HeapDumpOnOutOfMemoryError -verbose:gc -XX:+PrintGCTimeStamps -XX:+PrintGCDetails -XX:+PrintTenuringDistribution -XX:+PrintHeapAtGC -Xloggc:/usr/local/tomcat/logs/gc-%t.log -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=8888 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=$(hostname -i) -DepDbUser=$EP_DB_USER -DepDbPassword=$EP_DB_PASSWORD -DepDbJdbcDriverClass=$EP_DB_JDBC_DRIVER_CLASS -DepDbConnectionUrl=$EP_DB_CONNECTION_URL -DepDbValidationQuery=$EP_DB_VALIDATION_QUERY -DjmsType=$JMS_TYPE -DjmsFactory=$JMS_FACTORY -DjmsBrokerUrl=$JMS_BROKER_URL -Dcortex -Dfile.encoding=UTF-8 -Dorg.eclipse.rap.rwt.enableUITests=$ENABLE_UI_TESTS $TOMCAT_ADDITIONAL_PARAMETERS"
