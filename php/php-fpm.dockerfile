FROM php:7.3.4-fpm as base-fpm

#COPY sources.list/stretch.list /etc/apt/sources.list
#COPY sources.list/buster.list /etc/apt/sources.list.d/buster.list

ENV TZ=Asia/Shanghai
RUN echo $TZ > /etc/timezone \
    && apt-get update \
	# 相关依赖必须手动安装
	&& apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libtidy-dev \
        libssl-dev \
        libzip-dev \
        libmagickwand-dev \
        libmagickcore-dev \
    # 安装扩展
    && docker-php-ext-install -j$(nproc) bcmath exif pcntl pdo_mysql shmop soap tidy zip \
    # 如果安装的扩展需要自定义配置时
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install opcache \
    && pecl install redis && docker-php-ext-enable redis \
    && pecl install apcu && docker-php-ext-enable apcu \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pecl install yaf && docker-php-ext-enable yaf \
    && pecl install imagick && docker-php-ext-enable imagick  \
    && rm -r /var/lib/apt/lists/*

COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./php-fpm.d/* /usr/local/etc/php-fpm.d/
# COPY ./php-fpm.reload /bin/php-fpm.reload
#COPY ./php_common/cachetool.phar /usr/local/bin/cachetool.phar
CMD ["-R"]