# Minecraft Server


# Setup
The following uses docker for nearly easy setup and deployment. \
see [Docker Reference documentation](https://docs.docker.com/reference/)

If needed check status and/or start docker service: \
`systemctl status docker` \
`systemctl start docker` \
`systemctl stop docker` \
`docker` \
`docker info` 

## Build Image

`docker build -t rosstimo/mcpaper:1-18-2 .`

* -t 

`docker images -a`

## Build Conainer
`docker run -d -p 25565:25565 -p 25575:25575 -p 8123:8123 --name mcpaper_1_18_2 -v $(pwd)/mcp_1_18_2:/minecraft --restart=unless-stopped rosstimo/mcpaper:1-18-2`




`docker inspect mcpaper_1_16_5`
volume: /var/lib/docker/volumes/mcp_1_16_5/_data
`ls -lah /var/lib/docker/volumes/mcp_1_16_5/_data`