#TODO:
# non root user
# restart on fail
# systemd/daemon
# cron/backup scripts on schedule

# persistant Volume and/or
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
RUN apt install -y openjdk-16-jdk-headless

WORKDIR /minecraft

VOLUME /minecraft

#accept eula
RUN echo eula=true > eula.txt

#get the latest mc paper server
ADD https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/750/downloads/paper-1.16.5-750.jar ./

#add plugins
# ADD https://github.com/EssentialsX/Essentials/releases/download/2.18.2/EssentialsX-2.18.2.0.jar ./plugins/
# ADD https://dev.bukkit.org/projects/worldedit/files/3283695/download ./plugins/
# ADD https://dev.bukkit.org/projects/craftbook/files/3144903/download ./plugins/
# ADD https://dev.bukkit.org/projects/worldguard/files/3066271/download ./plugins/
# ADD https://dev.bukkit.org/projects/multiverse-core/files/3074594/download ./plugins/
# ADD https://dev.bukkit.org/projects/multiverse-portals/files/3113114/download ./plugins/
# ADD https://dev.bukkit.org/projects/minepacks/files/3285694/download ./plugins/
# ADD https://dev.bukkit.org/projects/timber-plugin/files/3023799/download ./plugins/
# ADD https://dev.bukkit.org/projects/fastleafdecay/files/2861213/download ./plugins/
# ADD https://dev.bukkit.org/projects/dynmap/files/3242277/download ./plugins/

# Expose server port 25565 mc server, 8123 for Dynamap plugin
EXPOSE 25565 8123

# start minecraft server
CMD java -Xms2G -Xmx2G -jar paper-1.16.5-750.jar --nogui
