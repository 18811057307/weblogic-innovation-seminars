#!/bin/sh

export CONTENT_DIR="/u01/content/weblogic-innovation-seminars"
export TAG_NAME_FILE="~/.wins/wins_git_tag"
export TAG_NAME=`cat ${TAG_NAME_FILE}`
export GIT_URL="http://github.com/oracle-weblogic/weblogic-innovation-seminars.git"

sudo mkdir -p /u01/content
sudo chown oracle:oinstall /u01/content

cd /u01/content

if [ ! -d /u01/content/weblogic-innovation-seminars ]; then
  git clone https://github.com/oracle-weblogic/weblogic-innovation-seminars.git
else
  echo "Updating existing GIT repo: /u01/content/weblogic-innovation-seminars"
  cd /u01/content/weblogic-innovation-seminars
  git pull
fi

if [ ! -d /u01/content/oracle-parcel-service ]; then
  git clone https://github.com/jeffreyawest/oracle-parcel-service.git
else
  echo "Updating existing GIT repo: /u01/content/oracle-parcel-service"
  cd /u01/content/oracle-parcel-service
  git pull
fi