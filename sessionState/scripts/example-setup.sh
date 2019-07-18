#!/bin/bash
cp $1/lib/* $CATALINA_HOME/lib/

export CLASSPATH=$1/lib/*

./$1/bin/gfsh "start locator --name=l1"

./$1/bin/gfsh "start server --name=server1 --locators=localhost[10334] --server-port=0 \
    --classpath=$CLASSPATH"

cp ../build/libs/SessionStateGradle-1.0-SNAPSHOT.war $CATALINA_HOME/webapps/SessionStateExample.war
