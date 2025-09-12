FROM alpine:3.21.4

RUN apk update --no-cache                                           \
    && apk add --no-cache mariadb mariadb-client gettext-envsubst   \
    && mkdir -p /var/lib/mysql /run/mysqld                          \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/init.sql /tools/init.sql
COPY tools/init-sql.sh /tools/init-sql.sh

RUN chmod +x /tools/init-sql.sh

USER mysql

CMD ["/tools/init-sql.sh"]
