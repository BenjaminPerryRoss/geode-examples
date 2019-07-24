#!/bin/bash
cp $1/lib/antlr-2.7.7.jar $CATALINA_HOME/lib/
cp $1/lib/commons-io-2.6.jar $CATALINA_HOME/lib/
cp $1/lib/commons-lang-2.6.jar $CATALINA_HOME/lib/
cp $1/lib/commons-validator-1.6.jar $CATALINA_HOME/lib/
cp $1/lib/fastutil-8.2.1.jar $CATALINA_HOME/lib/
cp $1/lib/geode-core-9.7.3.jar $CATALINA_HOME/lib/
cp $1/lib/javax.transaction-api-1.2.jar $CATALINA_HOME/lib/
cp $1/lib/jgroups-3.6.14.Final.jar $CATALINA_HOME/lib/
cp $1/lib/log4j-api-2.11.0.jar $CATALINA_HOME/lib/
cp $1/lib/log4j-core-2.11.0.jar $CATALINA_HOME/lib/
cp $1/lib/log4j-jul-2.11.0.jar $CATALINA_HOME/lib/
cp $1/lib/shiro-core-1.4.0.jar $CATALINA_HOME/lib/

unzip -o $1/tools/Modules/Apache_Geode_Modules-9.7.3-Tomcat.zip -d $CATALINA_HOME/

GEODE_LOCATION=${1%/}
CATALINA_LOCATION=${CATALINA_HOME%/}

export CLASSPATH=$CATALINA_HOME/lib/*

sh $GEODE_LOCATION/bin/gfsh "start locator --name=l1"

sh $GEODE_LOCATION/bin/gfsh "start server --name=server1 --locators=localhost[10334] --server-port=0 \
    --classpath=$CLASSPATH"

./gradlew build

rm -rf $CATALINA_HOME/webapps/SessionStateDemo*
cp build/libs/SessionStateDemo-1.0-SNAPSHOT.war $CATALINA_LOCATION/webapps/SessionStateDemo.war

