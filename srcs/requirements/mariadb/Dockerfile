FROM alpine:3.18.6

RUN apk update && apk upgrade
RUN apk add mariadb mariadb-client

COPY conf/mariadb.conf /etc/my.cnf.d/mariadb-server.cnf
COPY conf/run_mariadb.sh /run_mariadb.sh

RUN chmod u+x /run_mariadb.sh
RUN mariadb-install-db

ENTRYPOINT /run_mariadb.sh
