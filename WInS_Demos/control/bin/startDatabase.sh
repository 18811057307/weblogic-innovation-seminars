#!/bin/sh

. /u01/content/weblogic-innovation-seminars/WInS_Demos/control/bin/newWinsEnv.sh

$ORACLE_HOME/bin/dbstart $ORACLE_HOME

if [ "$1" == "wait" ]; then
  echo "This window will close automatically in 5s..."
  sleep 5
 fi
