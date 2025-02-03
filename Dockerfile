FROM    alpine:latest

LABEL   maintainer="Shane Hutter <shane.hutter@serversaustralia.com.au>"

COPY    src/etc/apk/repositories    /etc/apk/repositories

RUN \
    apk update                  && \
    apk upgrade                 && \
    apk add py3-pip \
        gcc         \
        python3-dev \
        musl-dev    \
        linux-headers           && \
    pip3 install    --no-cache-dir              \
                    --break-system-packages     \
                    --no-warn-script-location   \
        salt==3006.9                    \
        backports.ssl_match_hostname    \
        backports.weakref               \
        tornado                         \
        cryptography

VOLUME /etc/salt

ENTRYPOINT [ "salt-master -l debug" ]