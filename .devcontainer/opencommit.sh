#!/bin/bash
#
REPODIR=`pwd`

echo "Enter the Host IP address:"
read HOSTIPADDRESS
sed -i "s/HOSTIPADDRESS/${HOSTIPADDRESS}/g" ${REPODIR}/.devcontainer/opencommit-ollama.patch 

if [ $? -eq 0 ]; then
  if [ -d /tmp/opencommit ]; then
    rm -rf /tmp/opencommit
  fi
  git clone https://github.com/di-sukharev/opencommit.git /tmp/opencommit
  cd /tmp/opencommit
  git apply ${REPODIR}/.devcontainer/opencommit-ollama.patch
  sudo -H env PATH=$PATH npm uninstall -g
  sudo -H env PATH=$PATH npm install -g
  echo "OCO_AI_PROVIDER=ollama" > ~/.opencommit
  cd $REPODIR
  oco hook set
fi
