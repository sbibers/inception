FROM debian:bookworm

RUN apt-get update -y && \
    apt-get install -y mariadb-server curl gettext

COPY ./tools/database-script.sh /
COPY ./tools/database-config.cnf /
COPY ./tools/init.sql.template /docker-entrypoint-initdb.d/

RUN chmod +x /database-script.sh

EXPOSE 3306

CMD ["/database-script.sh"]