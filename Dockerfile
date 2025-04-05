FROM openjdk:8u312-jre-buster

LABEL version="3.2.3"
LABEL homepage.group=Minecraft
LABEL homepage.name="SevTech: Ages - 3.2.3"
LABEL homepage.icon="https://media.forgecdn.net/avatars/147/67/636574428512291945.png"
LABEL homepage.widget.type=minecraft
LABEL homepage.widget.url=udp://SevTechAges:25565

RUN apt-get update && apt-get install -y curl unzip

ENV DATA_DIR="/serverdata"
ENV DOWNLOADS_DIR="${DATA_DIR}/downloads"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV ARCHIEVE_NAME="SevTech_Ages_Server_3.2.3.zip"
ENV ARCHIEVE_PATH="${DOWNLOADS_DIR}/${ARCHIEVE_NAME}"
ENV GAME_PORT=25565
ENV UMASK=000
ENV UID=568
ENV GID=568
ENV USER="minecraft"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $DOWNLOADS_DIR && \
	mkdir $SERVER_DIR && \
    useradd -d $DATA_DIR -s "/bin/bash" $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /scripts/
RUN chmod -R 770 /scripts/

#Server Start
ENTRYPOINT ["/scripts/start.sh"]