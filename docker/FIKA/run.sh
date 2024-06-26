#!/bin/bash
set -e

LINK_ROOT_DIR="/opt/server_data"

LINK_DIR_AKI="/opt/server/Aki_Data"
DIR_AKI="$LINK_ROOT_DIR/Aki_Data"

LINK_DIR_USER="/opt/server/user"
DIR_USER="$LINK_ROOT_DIR/user"

BACKENDIP="${BACKENDIP:=$(bbgurl -Q https://ipv4.icanhazip.com)}"

if [ ! -d "$DIR_AKI" ]; then echo "Make dir Aki_data"
    mkdir $DIR_AKI;
fi

if [ ! -L "$LINK_DIR_AKI" ]; then echo "Make link Aki_data"
    ln -s $DIR_AKI ;
fi

if [ $(find $DIR_AKI -maxdepth 1 -type d | wc -l) -eq 1 -a -e "$LINK_DIR_AKI.tar.gz" ]; then echo "Unzip Aki_Data"
    tar xf $LINK_DIR_AKI.tar.gz -C $LINK_ROOT_DIR

    echo "Set Default Server"
    sed -i 's/\"ip\": \"127.0.0.1\"/\"ip\": \"0.0.0.0\"/g' $LINK_DIR_AKI/Server/configs/http.json
    sed -i "s/\"backendIp\": \"127.0.0.1\"/\"backendIp\": \"$BACKENDIP\"/g" $LINK_DIR_AKI/Server/configs/http.json
    chown $(id -u):$(id -g) $LINK_ROOT_DIR/* -Rf ;
fi

if [ ! -d "$DIR_USER" ]; then echo "Make dir user"
    mkdir $DIR_USER ;
fi

if [ ! -L "$LINK_DIR_USER" ]; then echo "Make link user"
    ln -s $DIR_USER ;
fi

if [ -e "$LINK_DIR_USER.tar.gz" ]; then echo "Unzip fika_mods"
    tar xf $LINK_DIR_USER.tar.gz -C $LINK_ROOT_DIR ; 
    chown $(id -u):$(id -g) $LINK_ROOT_DIR/* -Rf ;
fi 

echo "NODE_CHANNEL_FD env set"
NODE_CHANNEL_FD=" timeout --preserve-status 40s /opt/server/Aki.Server.exe </dev/null >/dev/null 2>&1"

exec "$@"