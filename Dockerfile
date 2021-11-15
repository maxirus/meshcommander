FROM node:16.13.0-buster-slim

ENV DEBIAN_FRONTEND="noninteractive" \
    NODE_ENV="production"

ARG MC_VERSION="0.9.1-a"

# https://www.npmjs.com/package/meshcommander
RUN apt-get update && apt-get install dumb-init && \
    mkdir /meshcommander && \
    cd /meshcommander && \
    npm install meshcommander@${MC_VERSION} && \
    echo -n "Meshcommander version: " && \
    npm info meshcommander version && \
    chown -R node:node /meshcommander

EXPOSE 3000

WORKDIR /meshcommander/node_modules/meshcommander

USER node

CMD ["dumb-init", "node", "meshcommander", "--any"]
# "--any" binds on all interfaces, not only 127.0.0.1
