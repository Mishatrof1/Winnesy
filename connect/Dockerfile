ARG DEBEZIUM_VERSION

FROM debezium/connect:${DEBEZIUM_VERSION}

ARG MYSQL_HOST=mysql
ENV MYSQL_HOST ${MYSQL_HOST}

ARG MYSQL_PORT=3306
ENV MYSQL_PORT ${MYSQL_PORT}

ARG MYSQL_PASSWORD=set_password
ENV MYSQL_PASSWORD ${MYSQL_PASSWORD}

ARG MYSQL_DATABASE=default
ENV MYSQL_DATABASE ${MYSQL_DATABASE}

ARG MYSQL_SCHEMA=default
ENV MYSQL_SCHEMA ${MYSQL_SCHEMA}

ARG KAFKA_HOST=kafka
ENV KAFKA_HOST ${KAFKA_HOST}

ARG KAFKA_PORT=9092
ENV KAFKA_PORT ${KAFKA_PORT}

COPY register-mysql.json /tmp/register-mysql.json

RUN cat /tmp/register-mysql.json |\
        sed 's@"database.hostname": "mysql",@"database.hostname": '${MYSQL_HOST}',@g' |\
        sed 's@"database.port": "3306",@"database.port": '${MYSQL_PORT}',@g' |\
        sed 's@"database.user": "debezium",@"database.user": '${MYSQL_USER}',@g' |\
        sed 's@"database.password": "password",@"database.password": '${MYSQL_PASSWORD}',@g' |\
        sed 's@"database.include": "inventory",@"database.include": '${MYSQL_DATABASE}',@g' |\
        sed 's@"table.include.list": "inventory.customers",@"table.include.list": '${MYSQL_DATABASE}'.'${MYSQL_SCHEMA}',@g' |\
        sed 's@"database.history.kafka.topic": "schema-changes.inventory"@"database.history.kafka.topic": "schema-changes.'${MYSQL_DATABASE}'.'${MYSQL_SCHEMA}'",@g' |\
        sed 's@"database.history.kafka.bootstrap.servers": "kafka:9092",@"database.history.kafka.bootstrap.servers": '${KAFKA_HOST}'.'${KAFKA_PORT}',@g' > /tmp/curl-register-mysql.json

RUN curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @/tmp/curl-register-mysql.json

