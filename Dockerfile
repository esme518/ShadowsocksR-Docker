#
# Dockerfile for ShadowsocksR
#

FROM alpine:3.6

ENV SSR_URL https://github.com/shadowsocksr-backup/shadowsocksr/archive/manyuser.zip

RUN set -ex \
    && apk --update add --no-cache libsodium py-pip \
    && pip --no-cache-dir install $SSR_URL \
    && rm -rf /var/cache/apk

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD    p@ssw0rd
ENV METHOD      aes-256-cfb
ENV PROTOCOL    auth_sha1_compatible
ENV OBFS        http_simple_compatible
ENV TIMEOUT     300

EXPOSE $SERVER_PORT/tcp
EXPOSE $SERVER_PORT/udp

WORKDIR /usr/bin/

CMD ssserver -s $SERVER_ADDR \
             -p $SERVER_PORT \
             -k $PASSWORD    \
             -m $METHOD      \
             -O $PROTOCOL    \
             -o $OBFS        \
             -t $TIMEOUT
