#!/bin/bash 

set -ex

MYSQL_HOST=mysql_test
MYSQL_PORT=33033
MYSQL_USER=mysql-r
MYSQL_PASSWORD=1qaz
MYSQL_DATABASE=db
MYSQL_SCHEMA=test
KAFKA_HOST=kfaka
KAFKA_PORT=123



cat register-mysql.json |\
        sed 's@"database.hostname": "mysql",@"database.hostname": '${MYSQL_HOST}',@g' |\
        sed 's@"database.port": "3306",@"database.port": '${MYSQL_PORT}',@g' |\
        sed 's@"database.user": "debezium",@"database.user": '${MYSQL_USER}',@g' |\
        sed 's@"database.password": "password",@"database.password": '${MYSQL_PASSWORD}',@g' |\
        sed 's@"database.include": "inventory",@"database.include": '${MYSQL_DATABASE}',@g' |\
        sed 's@"table.include.list": "inventory.customers",@"table.include.list": '${MYSQL_DATABASE}'.'${MYSQL_SCHEMA}',@g' |\
        sed 's@"database.history.kafka.topic": "schema-changes.inventory"@"database.history.kafka.topic": "schema-changes.'${MYSQL_DATABASE}'.'${MYSQL_SCHEMA}'",@g' |\
        sed 's@"database.history.kafka.bootstrap.servers": "kafka:9092",@"database.history.kafka.bootstrap.servers": '${KAFKA_HOST}'.'${KAFKA_PORT}',@g' > register-mysql1.json


