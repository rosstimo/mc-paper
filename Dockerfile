#TODO:

# install script for plugins

# Label stuff
# security check

# currently the latest LTS version
From ubuntu:20.04

# set timezone
ARG TZ=America/Denver #time zone
RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone

RUN apt -y update && \
    apt -y upgrade && \
    apt -y autoremove --purge && \
    apt -y clean

# install minecraft server dependencies
# as of mc version 1.17.xx java 17 will be required here
# cron & rsync setup nightly bakups
# accept eula

#COPY start.sh /minecraft/
#COPY backup.sh /minecraft/
COPY bkp-crontab /etc/cron.d/
COPY *.sh /minecraft/

RUN apt install -y openjdk-17-jdk-headless && \
    apt install cron -y && \
    apt install rsync -y && \
    crontab /etc/cron.d/bkp-crontab && \
    mkdir /minecraft/backups && \
    echo eula=true > /minecraft/eula.txt

#get the mc paper server
#change url here for different version
#see https://papermc.io/downloads 
ADD https://papermc.io/api/v2/projects/paper/versions/1.18.2/builds/290/downloads/paper-1.18.2-290.jar /minecraft/

# Expose server port 25565 mc server, rcon port 25575, 8123 for dynmap plugin
EXPOSE 25575 25565 8123

VOLUME /minecraft

HEALTHCHECK NONE

STOPSIGNAL SIGKILL

WORKDIR /minecraft

# start minecraft server
ENTRYPOINT ["./start.sh"]
