FROM debian:12-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

EXPOSE 3306
VOLUME ["/var/lib/mysql"]
CMD ["mysqld", "--user=mysql", "--console"]

