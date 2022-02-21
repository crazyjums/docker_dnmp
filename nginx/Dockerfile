FROM alpine:latest

LABEL AUTHOR="ZHG"

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    apk update && apk upgrade && \ 
    apk add --no-cache --virtual .build-deps \ 
    wget \
    gcc \
    make \
    libc-dev \
    openssl \
    openssl-dev \
    gzip curl \
    pcre-dev \
    zlib-dev && \
    apk add pcre && \
    wget https://nginx.org/download/nginx-1.20.1.tar.gz && \
    tar -zxvf nginx-1.20.1.tar.gz

WORKDIR /nginx-1.20.1

RUN addgroup -S nginx &&\ 
    adduser -S -G nginx -s /sbin/nologin -h /usr/local/nginx nginx && \
    ./configure --prefix=/usr/local/nginx --user=nginx --group=nginx && \
    make && make install && \
    apk del .build-deps && \
    ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/ && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /usr/local/nginx/conf/incloud && \
    mkdir -p /data/nginx/logs && \
    mkdir -p /data/nginx/www && \
    touch /data/nginx/logs/access.log && \
    touch /data/nginx/logs/error.log

# COPY nginx.conf /usr/local/nginx/conf/nginx.conf
# COPY ./conf.d/* /usr/local/nginx/conf/incloud

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]