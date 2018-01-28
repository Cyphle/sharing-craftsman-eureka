#!/usr/bin/env bash

parse_yaml() {
    local prefix=$2
    local s
    local w
    local fs
    s='[[:space:]]*'
    w='[a-zA-Z0-9_]*'
    fs="$(echo @|tr @ '\034')"
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s[:-]$s\(.*\)$s\$|\1$fs\2$fs\3|p" "$1" |
    awk -F"$fs" '{
    indent = length($1)/2;
    vname[indent] = $2;
    for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
            vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
            printf("%s%s%s=(\"%s\")\n", "'"$prefix"'",vn, $2, $3);
        }
    }' | sed 's/_=/+=/g'
}

# Example ./update-dockerfile.sh eureka-infos.yml docker-compose.yaml
source=$1
composeTarget=$2

ymldata="$(parse_yaml $source)"

infos=(${ymldata// / })

# DOCKER
dockerPortEntry='user_docker_port'
dockerNetworkEntry='user_docker_network'

dockerPortLength=$((${#infos[0]} - ${#dockerPortEntry} - 5))
dockerNetworkLength=$((${#infos[0]} - ${#dockerNetworkEntry} - 5))

dockerPort=${infos[0]:${#dockerPortEntry} + 3:dockerPortLength}
dockerNetwork=${infos[0]:${#dockerNetworkEntry} + 3:dockerNetworkLength}

sed -i -e "s/<APP_PORT>/\"${dockerPort}\"/g" $composeTarget
sed -i -e "s/<DOCKER_NETWORK>/${dockerNetwork}/g" $composeTarget

# LAUNCH DOCKER
docker-compose up -d

# DELETE
rm $composeTarget-e
rm Dockerfile
rm docker-compose.yml
rm user-infos.yml