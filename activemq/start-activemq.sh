#!/bin/sh

java -Xms${ACTIVEMQ_MEMORY}M -Xmx${ACTIVEMQ_MEMORY}M -Djava.util.logging.config.file=logging.properties -Djava.security.auth.login.config=/opt/activemq/conf/login.config -Dcom.sun.management.jmxremote -Djava.awt.headless=true -Djava.io.tmpdir=/opt/activemq/tmp -Dactivemq.classpath=/opt/activemq/conf:/opt/activemq/../lib/: -Dactivemq.home=/opt/activemq -Dactivemq.base=/opt/activemq -Dactivemq.conf=/opt/activemq/conf -Dactivemq.data=/opt/activemq/data -jar ${ACTIVEMQ_HOME}/bin/activemq.jar start
