#!/bin/bash

echo "---Ensuring UID: ${UID} matches user---"
usermod -u ${UID} ${USER}
echo "---Ensuring GID: ${GID} matches user---"
groupmod -g ${GID} ${USER} > /dev/null 2>&1 ||:
usermod -g ${GID} ${USER}
echo "---Setting umask to ${UMASK}---"
umask ${UMASK}

echo "---Taking ownership of data...---"
chown -R root:${GID} /scripts
chmod -R 750 /scripts
chown -R ${UID}:${GID} ${DATA_DIR}

echo "---Starting...---"
su ${USER} -c "/scripts/start-server.sh"
#term_handler() {
#	kill -SIGTERM "$killpid"
#	wait "$killpid" -f 2>/dev/null
#	exit 143;
#}
#
#trap 'kill ${!}; term_handler' SIGTERM
#su ${USER} -c "/scripts/start-server.sh" &
#killpid="$!"
#while true
#do
#	wait $killpid
#	exit 0;
#done