FROM node:16.13.0-buster-slim

ENV DEBIAN_FRONTEND noninteractive
ARG MC_VERSION="0.9.1-a"

# RUN apt-get -qy update \
#     && apt-get -qy dist-upgrade \
#     && apt-get -qy install unzip \
#     && apt-get -y clean \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# https://www.npmjs.com/package/meshcommander
RUN mkdir /meshcommander \
    && cd /meshcommander \
    && npm install meshcommander@${MC_VERSION} \
    && echo -n "Meshcommander version: " \
    && npm info meshcommander version

EXPOSE 3000

WORKDIR /meshcommander/node_modules/meshcommander
CMD ["node", "meshcommander", "--any"]
# "--any" binds on all interfaces, not only 127.0.0.1
