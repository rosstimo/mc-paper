
# currently the latest LTS version
From ubuntu:22.04

# set timezone
ARG TZ=America/Denver #time zone
RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone

RUN apt -y update && \
    apt -y upgrade && \
    apt -y autoremove --purge && \
    apt -y clean

# install minecraft server dependencies
# as of mc version 1.17.xx java 17 or above will be required here
# cron & rsync setup nightly bakups
# accept eula

COPY bkp-crontab /etc/cron.d/
COPY *.sh /minecraft/

RUN apt install -y openjdk-18-jdk-headless && \
    apt install cron -y && \
    apt install rsync -y && \
    crontab /etc/cron.d/bkp-crontab && \
    mkdir /minecraft/backups && \
    echo eula=true > /minecraft/eula.txt



# Official vanilla Java edition server
#change url here for different version
#see https://www.minecraft.net/en-us/download/server
#ADD https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar /minecraft/ #official 1.18.2

#get the mc paper server
#change url here for different version
#see https://papermc.io/downloads 
ADD https://api.papermc.io/v2/projects/paper/versions/1.18.2/builds/386/downloads/paper-1.18.2-386.jar /minecraft/

# Expose server port 25565 mc server, rcon port 25575, 8123 for dynmap plugin
EXPOSE 25575 25565 8123

VOLUME /minecraft

HEALTHCHECK NONE

STOPSIGNAL SIGKILL

WORKDIR /minecraft

# start minecraft server
ENTRYPOINT ["/minecraft/start.sh"]
