#!/bin/bash

case $TS_VERSION in
  LATEST)
    export TS_VERSION=`wget -O - https://www.server-residenz.com/tools/ts3versions.json | jsawk -n 'out(this.latest)'`
    ;;
esac

cd /data

TARFILE=teamspeak3-server_linux-amd64-${TS_VERSION}.tar.gz

if [ ! -e ${TARFILE} ]; then
  echo "Downloading ${TARFILE} ..."
  wget -q http://dl.4players.de/ts/releases/${TS_VERSION}/${TARFILE} \
  && tar -x -f ${TARFILE} --strip-components=1
fi

export LD_LIBRARY_PATH=/data

exec ./tsdns/ts3server_linux_amd64
exec ./ts3server_linux_amd64

