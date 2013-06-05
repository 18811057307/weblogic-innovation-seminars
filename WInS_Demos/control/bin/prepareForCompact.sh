#!/bin/bash
#rm -Rf ~/.mozilla

zerofree()
{
  FILE=$1/zerofree_deleteme
  echo Creating temporary file: $FILE
  dd if=/dev/zero of=$FILE
  rm -Rf $FILE
  echo $FILE created and deleted...
}


sqlplus '/ as sysdba' @/u01/content/weblogic-innovation-seminars/WInS_Demos/environment/sql/truncate.sql

killWebLogic.sh

sudo rm -Rf $DOMAINS
sudo rm -Rf /tmp/*
sudo rm -Rf /var/cache/yum/*
sudo rm -Rf /u01/content/oracle-parcel-service/ops-weblogic/Oracle
sudo rm -Rf /home/oracle/Downloads/*

cd /u01/content/weblogic-innovation-seminars/WInS_Demos
mvn clean

cd /u01/content/soracle-parcel-service
mvn clean

find /u01/content/weblogic-innovation-seminars -name "*.sh" -exec chmod +rx {} \;

zerofree /tmp
zerofree /u01

halt