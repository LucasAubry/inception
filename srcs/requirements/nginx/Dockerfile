FROM alpine:3.18.6

RUN apk update && apk upgrade
RUN apk add nginx
RUN apk add openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=HAVRE/O=42/OU=42/CN=laubry.42.fr/UID=laubry"

RUN rm -rf /etc/nginx/http.d/default.conf
COPY conf/nginx.conf /etc/nginx/http.d/inception.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
