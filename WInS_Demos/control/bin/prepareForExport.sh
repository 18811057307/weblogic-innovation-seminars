#!/bin/bash
#rm -Rf ~/.mozilla

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

. /u01/content/weblogic-innovation-seminars/WInS_Demos/control/bin/winsEnv.sh

for param in $*
do
	if [ "${param}" == "nozero" ]; then
		NOZERO="TRUE"
	elif [ "${param}" == "nohalt" ]; then
		NOHALT="TRUE"
	fi
done

zerofill()
{

  FILE=$1/zerofree_deleteme
  echo "zero-ing out with FILE=${FILE}"
  echo Creating temporary file: $FILE
  dd if=/dev/zero of=$FILE
  rm -Rf $FILE
  echo $FILE created and deleted...
}

SUCCESS="TRUE"

su oracle -c "sqlplus 'sys/welcome1 as sysdba' @/u01/content/weblogic-innovation-seminars/WInS_Demos/environment/sql/truncate.sql"

killWebLogic.sh

rm -Rf $DOMAINS
rm -Rf /tmp/wls*
rm -Rf /var/cache/yum/*
rm -Rf /u01/content/oracle-parcel-service/ops-weblogic/Oracle
rm -Rf /home/oracle/Downloads/*
rm -Rf /home/oracle/.m2/repository/com/oracle/weblogic/demo
rm -Rf /home/oracle/.m2/repository/com/oracle/demo

cd /u01/content/weblogic-innovation-seminars/WInS_Demos
su oracle -c "mvn clean"

cd /u01/content/oracle-parcel-service
su oracle -c "mvn clean"

if [ "${NOZERO}" != "TRUE" ]; then
  zerofill /tmp
  zerofill /u01
fi

su oracle -c "/u01/content/weblogic-innovation-seminars/WInS_Demos/control/bin/updateDemos.sh"
if [ "$?" != "0" ]; then
  SUCCESS="FALSE"
fi

su oracle -c "/u01/content/weblogic-innovation-seminars/WInS_Demos/control/bin/updateOPS.sh"
if [ "$?" != "0" ]; then
  SUCCESS="FALSE"
fi

if [ "${SUCCESS}" == "TRUE" ]; then
  if [ "${NOHALT}" != "TRUE" ]; then
    halt
  fi

else
  echo "Errors were encountered preparing for export!"
fi