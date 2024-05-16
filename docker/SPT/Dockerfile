FROM node:20.11.1 AS builder
ARG SPT=3.8.1
ARG SPT_COMMIT=HEAD
ARG FIKA=v2.0
ARG FIKA_COMMIT=HEAD

WORKDIR /opt

RUN <<EOF
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
apt-get install -yq git-lfs
EOF

RUN <<EOF
git clone -b $SPT https://dev.sp-tarkov.com/SPT-AKI/Server.git srv
cd srv
git lfs pull
git checkout $SPT_COMMIT
EOF

WORKDIR /opt/srv/project

RUN <<EOF
yarn
yarn build:release -- --arch=$([ "$(uname -m)" = "aarch64" ] && echo arm64 || echo x64) --platform=linux
mv build/ /opt/server/
EOF

WORKDIR /opt/server

COPY ./run.sh /opt/server

RUN <<EOF
GZIP=-9
sed -i 's/\r$//g' ./run.sh
if [ -e "Aki_Data" ]; then tar czf Aki_Data.tar.gz Aki_Data/ && rm -rf ./Aki_Data ; fi
if [ -e "user" ]; then tar czf user.tar.gz user/ && rm -rf ./user ; fi
EOF

FROM node:20.11.1-slim

COPY --from=builder /opt/server /opt/server

WORKDIR /opt/server

# Set permissions
RUN <<EOF
chmod o+rwx /opt -R
mkdir /opt/server_data
chown $(id -u):$(id -g) ./* -Rf
EOF

# Exposing ports
EXPOSE 6969
EXPOSE 6970
EXPOSE 6971
# EXPOSE 25565/udp

ENTRYPOINT /opt/server/run.sh

# Specify the default command to run when the container starts
CMD /opt/server/Aki.Server.exe