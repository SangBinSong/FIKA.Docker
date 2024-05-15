FROM node:20.11.1 AS builder
ARG SPT=3.8.1
ARG SPT_COMMIT=HEAD
ARG FIKA=v2.0
ARG FIKA_COMMIT=HEAD

WORKDIR /opt

RUN <<EOF
apt-get update -yq
apt-get upgrade -yq
apt-get install -yq git git-lfs curl
git clone -b $SPT https://dev.sp-tarkov.com/SPT-AKI/Server.git srv
cd srv
git lfs pull
git checkout $SPT_COMMIT
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
RUN <<EOF
git clone --branch $FIKA https://github.com/project-fika/Fika-Server.git ./fika-server
cd ./fika-server
git checkout $FIKA_COMMIT
yarn
yarn build
unzip ./dist/fika-server.zip -d /opt/server/
cd .
EOF

FROM node:20.11.1-slim

COPY --from=builder /opt/server /opt/backup

WORKDIR /opt

# Set permissions
RUN <<EOF
chmod o+rwx /opt -R
EOF

# Exposing ports
EXPOSE 6969
EXPOSE 6970
EXPOSE 6971
EXPOSE 25565/udp

# Specify the default command to run when the container starts
# ENTRYPOINT 

CMD /opt/server/Aki.Server.exe