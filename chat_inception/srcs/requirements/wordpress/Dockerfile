FROM debian:12-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    php-fpm php-mysql php-xml php-gd php-mbstring php-curl unzip wget curl \
    mariadb-client ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# WP-CLI (pratique pour l'install automatisée depuis le conteneur)
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x /usr/local/bin/wp

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm", "-F"]

