FROM alpine:3.19

RUN apk update && apk upgrade && \
    apk add --no-cache mariadb mariadb-client && \
    rm -rf /var/cache/apk/*

# copy les fichiers de configuration
COPY conf/50-server.cnf /etc/my.cnf.d/50-server.cnf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld", "--user=mysql"]

