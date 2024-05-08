FROM node:20.11.1-alpine AS builder
ARG SPT=3.8.1
ARG FIKA=v2.0

WORKDIR /opt

RUN <<EOF
apk update -q
apk upgrade -q
apk add -q git curl python3
git clone -b $SPT https://dev.sp-tarkov.com/SPT-AKI/Server.git srv
EOF

WORKDIR /opt/srv/project

## remove the encoding from aki
## todo: find a better workaround
# RUN sed -i '/setEncoding/d' /opt/srv/project/src/Program.ts || true

## Install npm dependencies and run build
RUN <<EOF
yarn
yarn build:release -- --arch=$([ "$(uname -m)" = "aarch64" ] && echo arm64 || echo x64) --platform=linux
mv build/ /opt/server/
EOF

## Grab SIT Coop Server Mod or continue if it exist
# RUN <<EOF
# it clone --branch $SIT_BRANCH https://github.com/stayintarkov/SIT.Aki-Server-Mod.git ./server/user/mods/SITCoop 
# cd ./server/user/mods/SITCoop 
# git checkout $SIT
# npm install
# rm -rf ./server/user/mods/SITCoop/.git
# EOF

FROM node:20.11.1-alpine

WORKDIR /opt

COPY --from=builder /opt/server /opt/server
# Set permissions
RUN <<EOF
chmod o+rwx /opt -R
cd /opt/server
chown $(id -u):$(id -g) ./* -Rf
sed -i 's/127.0.0.1/0.0.0.0/g' /opt/server/Aki_Data/Server/configs/http.json
NODE_CHANNEL_FD= timeout --preserve-status 40s ./Aki.Server.exe </dev/null >/dev/null 2>&1 
EOF

# Exposing ports
EXPOSE 6969
# EXPOSE 6970
# EXPOSE 6971
EXPOSE 25565/udp

# Specify the default command to run when the container starts
CMD cd /opt/server && ./Aki.Server.exe
