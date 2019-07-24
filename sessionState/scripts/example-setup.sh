#!/bin/bash
cp $1/lib/* $CATALINA_HOME/lib/

GEODE_LOCATION=${1%/}
CATALINA_LOCATION=${CATALINA_HOME%/}

export CLASSPATH=$CATALINA_HOME/lib/*

sh $GEODE_LOCATION/bin/gfsh "start locator --name=l1"

sh $GEODE_LOCATION/bin/gfsh "start server --name=server1 --locators=localhost[10334] --server-port=0 \
    --classpath=$CLASSPATH"

./../gradlew build

rm -rf $CATALINA_HOME/webapps/SessionStateGradle-1.0-SNAPSHOT*
cp ../build/libs/SessionStateGradle-1.0-SNAPSHOT.war $CATALINA_LOCATION/webapps/

