#!/bin/bash

if [ ! -f "${ARCHIEVE_PATH}" ]; then
    echo "${ARCHIEVE_NAME} not found!"
    wget -q -O "${ARCHIEVE_PATH}" https://edge.forgecdn.net/files/3570/46/SevTech_Ages_Server_3.2.3.zip
    unzip -u -o "${ARCHIEVE_PATH}" -d ${SERVER_DIR}
    
    chmod -R ${DATA_PERM} ${DATA_DIR}
    echo "---Installing Server---"
    cd ${SERVER_DIR}
    ./Install.sh
fi

if ! grep -i true ${SERVER_DIR}/eula.txt; then
  echo "eula=true" > "${SERVER_DIR}/eula.txt"
fi

chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Starting Server---"
cd ${SERVER_DIR}
. ./settings.sh
JVM_OPTS=$JVM_OPTS $JAVA_PARAMETERS
curl -Lo log4j2_112-116.xml https://launcher.mojang.com/v1/objects/02937d122c86ce73319ef9975b58896fc1b491d1/log4j2_112-116.xml
java -server $JVM_OPTS -Dfml.queryResult=confirm -Dlog4j.configurationFile=log4j2_112-116.xml -jar $SERVER_JAR nogui