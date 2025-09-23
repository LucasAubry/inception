FROM alpine:3.18.6

RUN apk update && apk upgrade
RUN apk add php-fpm php-mysqli php-phar php81-iconv
RUN apk add wget

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN wget https://wordpress.org/wordpress-6.4.3.tar.gz
RUN tar -xzf wordpress-6.4.3.tar.gz --strip-components 1
RUN rm wordpress-6.4.3.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod u+x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/php.conf /etc/php81/php-fpm.d/www.conf
COPY conf/run_wordpress.sh /run_wordpress.sh

RUN chmod u+x /run_wordpress.sh

ENTRYPOINT /run_wordpress.sh
