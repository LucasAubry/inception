FROM debian:12-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*
COPY conf/default.conf /etc/nginx/conf.d/default.conf
# certificates will be mounted into /etc/nginx/certs (from host)
EXPOSE 10443
CMD ["nginx", "-g", "daemon off;"]

