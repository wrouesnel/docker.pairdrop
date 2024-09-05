ARG DOCKER_PREFIX=

FROM ${DOCKER_PREFIX}ubuntu:22.04

ARG URL_P2CLI=https://github.com/wrouesnel/p2cli/releases/download/r16/p2cli_r16_linux-amd64.tar.gz
ARG URL_PAIRDROP=https://github.com/schlagmichdoch/PairDrop/archive/refs/tags/v1.10.10.tar.gz
ARG URL_NVM=https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh

ARG http_proxy=
ARG https_proxy=

COPY tree-preinstall/ /

RUN \
       apt update \
    && apt install --no-install-recommends -y gnupg ca-certificates apt-transport-https wget curl

ENV \
    SSL_CERT_DIR=/etc/ssl/certs \
    REQUESTS_CA_BUNDLE=/etc/ssl/certs \
    NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

ENV \
  SVDIR=/run/services

ENV \
  DATA_DIR=/data

ENV NVM_DIR=/usr/local/nvm

RUN apt update && apt install --no-install-recommends -y \
        nginx \
        nginx-extras \
        binutils \
        ca-certificates \
        runit \
        syslog-ng-core \
        openssl \
        pwgen \
        openssl \
        pwgen \
        sudo \
        curl dnsutils apache2-utils less net-tools lsof \
    # Templating engine
    && curl -L "$URL_P2CLI" | tar -xvzf - --strip-components=1 -C /usr/local/bin \
    && chmod +x /usr/local/bin/p2 \
    && mkdir "$NVM_DIR" \
    # NVM
    && curl -L "${URL_NVM}" | bash \
    && . ${NVM_DIR}/nvm.sh \
    && nvm install --lts --latest-npm \
    && nvm use default \
    # Pairdrop
    && mkdir /srv/pairdrop \
    && curl -L "$URL_PAIRDROP" | tar -xvzf - -C /srv/pairdrop --strip-components=1 \
    && ( cd /srv/pairdrop && npm ci ) \
    # Cleanup    
    && apt-get autoremove -y \
    # Delete nginx default configuration.
    && rm -rf /etc/nginx/sites-enabled /etc/nginx/sites-available /etc/nginx/snippets /etc/nginx/conf.d

COPY tree-postinstall/ /

# Hack: this container is always ephemeral!
ENV \
    DEV_ALLOW_EPHEMERAL_DATA=yes

EXPOSE 80/tcp 443/tcp

COPY healthcheck.sh /healthcheck.sh
HEALTHCHECK --interval=10s --timeout=10s --retries=3 CMD /healthcheck.sh

ENTRYPOINT [ "/entrypoint.bsh" ]
