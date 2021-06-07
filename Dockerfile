#TODO:

# COPY config files, plugins and/or
# install script for plugins  and/or
# git configfiles and/or

# Label stuff
# healthchek
# stop signal
# securiyt check

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

# above to here coud be a starter image

#install minecraft server dependencies
#as of mc version 1.17.xx java 17 will be required here
RUN apt install -y openjdk-16-jdk-headless && \
    apt install cron -y && \
    apt install rsync -y

COPY ./minecraft ./minecraft

# cron & rsync setup nightly bakups
RUN cp /minecraft/bkp-crontab /etc/cron.d/bkp-crontab && \
    chmod 0644 /etc/cron.d/bkp-crontab && \
    crontab /etc/cron.d/bkp-crontab && \
    chmod 0755 /minecraft/backup.sh

WORKDIR /minecraft

# Expose server port 25565 mc server, rcon port 25575, 8123 for dynmap plugin
EXPOSE 25575 25565 8123

VOLUME /minecraft

#HEALTHCHECK to echo instructions?

# start minecraft server
#CMD java -Xms2G -Xmx2G -jar paper-1.16.5-750.jar --nogui
CMD ["/bin/bash", "./start.sh"]
