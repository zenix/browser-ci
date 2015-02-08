#!/bin/bash
 
DESC="Selenium standalone server"
USER=jenkins
JAVA=/usr/bin/java
JAR_FILE=/usr/share/selenium/selenium-server-standalone-2.44.0.jar
LOG_FILE=/var/jenkins_home/selenium.log
 
DAEMON_OPTS="-Xmx500m -Xss1024k -jar $JAR_FILE -log $LOG_FILE"
DAEMON_OPTS="-Djava.security.egd=file:/dev/./urandom $DAEMON_OPTS"
 
export DISPLAY=:21
 export PATH=$PATH:/usr/local/bin:
 
$JAVA $DAEMON_OPTS &
