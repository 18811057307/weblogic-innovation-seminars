#!/bin/bash

DOMAIN_DIR=/u01/wins/wls1221/user_projects/domains/dev_domain
CONFIGURE_RG_SCRIPT=/u01/content/weblogic-innovation-seminars/WInS_Demos/MT-Workshop/Lab4/MedrecInMedrec-Dev.py

SERVERHome=/u01/wins/wls1221/wlserver
${SERVERHome}/common/bin/wlst.sh $CONFIGURE_RG_SCRIPT

#. $DOMAIN_DIR/bin/setDomainEnv.sh
#java weblogic.WLST -skipWLSModuleScanning $CONFIGURE_RG_SCRIPT 
