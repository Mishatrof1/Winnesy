ARG MYSQL_VERSION
FROM mysql:${MYSQL_VERSION}

LABEL maintainer="ra.stetsenko"

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

ARG DEBEZIUM
ARG MYSQL_REPLIC_USER
ARG MYSQL_REPLIC_PASSWORD
ARG MYSQL_DEBEZIUM_USER
ARG MYSQL_DEBEZIUM_PASSWORD

COPY docker-entrypoint-initdb.d/*.sql /tmp/

RUN set -eux; \
    if [ "$DEBEZIUM" = "true" ]; then \
         cat /tmp/inventory-debezium.sql |\
              sed "s/MYSQL_REPLIC_USER/${MYSQL_REPLIC_USER}/g" |\
              sed "s/MYSQL_REPLIC_PASSWORD/${MYSQL_REPLIC_PASSWORD}/g" |\
              sed "s/MYSQL_DEBEZIUM_USER/${MYSQL_DEBEZIUM_USER}/g" |\
              sed "s/MYSQL_DEBEZIUM_PASSWORD/${MYSQL_DEBEZIUM_PASSWORD}/g" > docker-entrypoint-initdb.d/inventory-debezium.sql; \
    else \
         mv /tmp/inventory.sql docker-entrypoint-initdb.d/inventory;\
    fi

COPY mysql.cnf /etc/mysql/conf.d/mysql.cnf

RUN chmod 0444 /etc/mysql/conf.d/mysql.cnf

CMD ["mysqld"]

EXPOSE 3306