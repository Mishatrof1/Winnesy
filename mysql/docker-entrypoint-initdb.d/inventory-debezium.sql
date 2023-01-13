# In production you would almost certainly limit the replication user must be on the follower (slave) machine,
# to prevent other clients accessing the log from other machines. For example, 'replicator'@'follower.acme.com'.
#
# However, this grant is equivalent to specifying *any* hosts, which makes this easier since the docker host
# is not easily known to the Docker container. But don't do this in production.
#

CREATE USER 'MYSQL_REPLIC_USER'@'%' IDENTIFIED BY 'MYSQL_REPLIC_PASSWORD';
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'MYSQL_REPLIC_USER';

CREATE USER 'MYSQL_DEBEZIUM_USER'@'%' IDENTIFIED BY 'MYSQL_DEBEZIUM_PASSWORD';
GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT  ON *.* TO 'MYSQL_DEBEZIUM_USER';

FLUSH PRIVILEGES;