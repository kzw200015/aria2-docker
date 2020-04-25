FROM alpine:latest

WORKDIR /root

RUN apk update \
    && apk add --virtual .build-tools --no-cache git g++ make libtool autoconf automake pkgconfig file \
    && apk add --no-cache gnutls-dev nettle-dev gmp-dev libssh2-dev c-ares-dev libxml2-dev zlib-dev sqlite-dev gettext-dev cppunit-dev \
    && git clone https://github.com/aria2/aria2.git \
    && cd aria2 && autoreconf -i && ./configure && make && make install \
    && rm -rf /root/aria2 && apk del .build-tools

CMD [ "aria2c" ]