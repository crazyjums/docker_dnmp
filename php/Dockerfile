FROM alpine

RUN apk update && apk add -U php php-fpm tzdata php-json php-curl

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN sed -i '/listen = 127.0.0.1:9000/c\\listen = 0.0.0.0:9000' /etc/php7/php-fpm.d/www.conf

# RUN adduser nginx
# USER nginx

WORKDIR /opt
# to run php-fpm foreground by force and allow-to-run-as-root
CMD ["/usr/sbin/php-fpm7","-F", "-R"]
