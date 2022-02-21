FROM alpine:latest

LABEL MAINTAINER="<crazyjums@gmail.com>"

ADD nginx-1.18.0.tar.gz /tmp
COPY nginx.conf /tmp/nginx.conf
COPY start.sh /tmp/start.sh
COPY include/localhost.conf /tmp/phptest.conf
COPY include/default.conf /tmp/default.conf
COPY html/php_nginx/ /tmp/php_nginx/

## isntall nginx by source code
WORKDIR /tmp/nginx-1.18.0

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
	&& addgroup -S nginx \
	&& adduser -S -G nginx -s /sbin/nologin -h /usr/local/nginx nginx \
	&& ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx \
	&& make \
	&& make install \
	&& mkdir -p /data/nginx/logs /data/nginx/logs /usr/local/nginx/conf/include \
	&& mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back \
	&& mv /tmp/nginx.conf /usr/local/nginx/conf/nginx.conf \
	&& mv /tmp/start.sh /start.sh \
	&& mv /tmp/phptest.conf /usr/local/nginx/conf/include/phptest.conf \
	&& mv /tmp/default.conf /usr/local/nginx/conf/include/default.conf \
	&& mv /tmp/php_nginx /usr/local/nginx/html/php_nginx \
	&& ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/ \
	&& /usr/local/nginx/sbin/nginx -t \
	&& rm -rf /tmp/* \
    && apk del .build-deps \
	&& echo "build nginx success-------------ok | expose 80 and 443"

EXPOSE 80 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]