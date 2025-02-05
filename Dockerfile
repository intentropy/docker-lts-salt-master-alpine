FROM    alpine:3.17

LABEL   maintainer="Shane Hutter <shane.hutter@serversaustralia.com.au>"

ARG SALT_VERSION=3006.9

COPY    src/etc/apk/repositories    /etc/apk/repositories
COPY    src/usr/bin/entrypoint.sh   /usr/bin/entrypoint

RUN \
    apk update                  && \
    apk upgrade                 && \
    apk add py3-pip \
        gcc         \
        python3-dev \
        musl-dev    \
        linux-headers           && \
    pip3 install    --no-cache-dir              \
                    --no-warn-script-location   \
        salt==$SALT_VERSION                     \
        backports.ssl_match_hostname    \
        backports.weakref               \
        tornado                         \
        cherrypy                        \
        gitpython                       \
        Mako                            \
        pycryptodome                    \
        pygit2                          \
        python-gnupg                    \
        ZMQ                             \
        pyyaml                          \
        distro                          \
        looseversion                    \
        msgpack                         \
        jinja2                          \
        cryptography            && \
    mkdir -p /etc/salt          && \
    echo "master: 127.0.0.1" >  \
        /etc/salt/minion        && \
    apk del         \
        python3-dev \
        gcc         \
        musl-dev    \
        linux-headers           && \
    chmod +x /usr/bin/entrypoint && \
    mkdir -p src/etc/salt/master.d

COPY src/etc/salt/master.d/api.conf /etc/salt/master.d/api.conf

VOLUME /etc/salt/pki

ENTRYPOINT [ "/usr/bin/entrypoint" ]