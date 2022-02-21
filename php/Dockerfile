FROM alpine:latest

LABEL MAINTAINER="<crazyjums@gmail.com>"
	
## install php(enable-fpm) by sourece code
ADD php-7.4.27.tar.gz /tmp
COPY php-fpm.conf /tmp/php-fpm.conf
COPY php-fpm.d/www.conf /tmp/www.conf
COPY start.sh /tmp/start.sh

WORKDIR /tmp/php-7.4.27

ENV TZ=Asia/Shanghai
RUN  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apk update && apk upgrade \
    && apk add --no-cache --virtual .build-deps \
    mlocate \
    g++ \
    pcre-dev \
    zlib-dev \
    make \
    gcc \
    libc-dev \
    autoconf \
    && apk add pcre \
    libxml2-dev \
    sqlite-dev \
    && ./configure --prefix=/usr/local/php --enable-fpm \
	&& make \
	&& make install \
	&& mv /tmp/start.sh /start.sh \
	&& mv /tmp/php-fpm.conf /usr/local/php/etc/php-fpm.conf \
	&& mv /tmp/www.conf /usr/local/php/etc/php-fpm.d/www.conf \
	&& mkdir -p /app \
	&& ln -s /usr/local/php/sbin/php-fpm /usr/local/bin/ \
	&& rm -rf /tmp/* \
	&& apk del .build-deps \
	&& echo "build php-fpm success-------------ok | expose 9000"

EXPOSE 9000

ENTRYPOINT ["/bin/sh","/start.sh"]