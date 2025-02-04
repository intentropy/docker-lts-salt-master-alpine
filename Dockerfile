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
        cryptography            && \
    mkdir -p /etc/salt          && \
    echo "master: 127.0.0.1" >  \
        /etc/salt/minion        && \
    apk del         \
        python3-dev \
        gcc         \
        musl-dev    \
        linux-headers           && \
    chmod +x /usr/bin/entrypoint

VOLUME /etc/salt/pki

ENTRYPOINT [ "/usr/bin/entrypoint" ]