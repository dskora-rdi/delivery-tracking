#!/bin/sh

curl -i -X POST -H "Accept:application/json" \
    -H  "Content-Type:application/json" http://connect-debezium:8083/connectors/ \
    -d '{
  "name": "mysql-source-demo-tracks",
  "config": {
    "connector.class": "io.debezium.connector.mysql.MySqlConnector",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "database.hostname": "mysql",
    "database.port": "3306",
    "database.user": "debezium",
    "database.password": "dbz",
    "database.server.id": "42",
    "database.server.name": "asgard",
    "table.whitelist": "demo.tracks",
    "database.history.kafka.bootstrap.servers": "kafka:29092",
    "database.history.kafka.topic": "dbhistory.tracks",
    "include.schema.changes": "true",
    "transforms": "unwrap,InsertTopic,InsertSourceDetails",
    "transforms.unwrap.type": "io.debezium.transforms.UnwrapFromEnvelope",
    "transforms.InsertTopic.type": "org.apache.kafka.connect.transforms.InsertField$Value",
    "transforms.InsertTopic.topic.field": "messagetopic",
    "transforms.InsertSourceDetails.type": "org.apache.kafka.connect.transforms.InsertField$Value",
    "transforms.InsertSourceDetails.static.field": "messagesource",
    "transforms.InsertSourceDetails.static.value": "Debezium CDC from MySQL on asgard"
  }
}'

curl -i -X POST -H "Accept:application/json" \
    -H  "Content-Type:application/json" http://connect-debezium:8083/connectors/ \
    -d '{
  "name": "mysql-source-demo-orders",
  "config": {
    "connector.class": "io.debezium.connector.mysql.MySqlConnector",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "database.hostname": "mysql",
    "database.port": "3306",
    "database.user": "debezium",
    "database.password": "dbz",
    "database.server.id": "42",
    "database.server.name": "asgard",
    "table.whitelist": "demo.delivery_orders",
    "database.history.kafka.bootstrap.servers": "kafka:29092",
    "database.history.kafka.topic": "dbhistory.delivery_orders",
    "include.schema.changes": "true",
    "transforms": "unwrap,InsertTopic,InsertSourceDetails",
    "transforms.unwrap.type": "io.debezium.transforms.UnwrapFromEnvelope",
    "transforms.InsertTopic.type": "org.apache.kafka.connect.transforms.InsertField$Value",
    "transforms.InsertTopic.topic.field": "messagetopic",
    "transforms.InsertSourceDetails.type": "org.apache.kafka.connect.transforms.InsertField$Value",
    "transforms.InsertSourceDetails.static.field": "messagesource",
    "transforms.InsertSourceDetails.static.value": "Debezium CDC from MySQL on asgard"
  }
}'
