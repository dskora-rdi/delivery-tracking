#!/bin/sh

curl -s \
     -X "POST" "http://localhost:18083/connectors/" \
     -H "Content-Type: application/json" \
     -d '{
  "name": "sink_elastic_delivery_tracking",
  "config": {
    "topics": "delivery_tracking",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": false,
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "key.ignore": "true",
    "schema.ignore": "true",
    "type.name": "kafka-connect",
    "connection.url": "http://elasticsearch:9200"
  }
}'
