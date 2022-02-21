FROM nginx:alpine

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache logrotate \
    && rm -rf /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx_common/* /etc/nginx/
COPY ssl_files/* /etc/nginx/ssl_files/
COPY logrotate.conf /etc/logrotate.d/nginx_custom

CMD crond; nginx -g "daemon off;"