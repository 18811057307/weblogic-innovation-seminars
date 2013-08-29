#!/bin/sh
# chkconfig: 345 98 10
# description: Oracle auto start-stop script.
#
# Set ORA_OWNER to the user id of the owner of the
# Oracle database software.

export TMP=/tmp
export TMPDIR=$TMP
export ORACLE_HOSTNAME=wins-vbox
export ORACLE_UNQNAME=orcl
export ORACLE_SID=orcl
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1/database
export PATH=/usr/sbin:$ORACLE_HOME/bin:$PATH
export ORACLE_OWNER=oracle

. /etc/rc.d/init.d/functions

echo

service_name="Oracle Database 12.1.0.1 ORCL CDB"
logger="/usr/bin/logger -t rc.local "

case "$1" in
    'start')
				echo -n "Starting ${service_name}: "
        su $ORACLE_OWNER -c "${ORACLE_HOME}/bin/dbstart ${ORACLE_HOME}"

        RETVAL=$?
				if [ ${RETVAL} == "0" ]; then
					success
			    $logger "Start ${service_name} succeeded"
				else failure
			    $logger "error: Start ${service_name} failed with exit code ${RETVAL}"
				fi
				echo
        ;;

    'stop')
				echo -n "Stopping ${service_name}: "
        su $ORACLE_OWNER -c "${ORACLE_HOME}/bin/dbshut ${ORACLE_HOME}"

        RETVAL=$?
				if [ ${RETVAL} == "0" ]; then
					success
			    $logger "Stop ${service_name} succeeded"
				else failure
			    $logger "error: Stop ${service_name} failed with exit code ${RETVAL}"
				fi
				echo
        ;;
esac
