FROM alpine:3.19

RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl && \
    rm -rf /var/cache/apk/*

#cree les repertoir utile
RUN mkdir -p /etc/nginx/ssl /var/www/html /run/nginx

#copy le configuration
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
