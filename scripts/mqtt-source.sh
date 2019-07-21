#!/bin/sh

curl -i -X POST -H "Accept:application/json" \
    -H  "Content-Type:application/json" http://kafka-connect:18083/connectors/ \
    -d '{
  "name": "mqtt-souDAAn1",
  "config": {
    "connector.class": "io.confluent.connect.mqtt.MqttSourceConnector",
    "tasks.max": 1,
    "mqtt.server.uri": "tcp://mosquitto:1883",
    "mqtt.topics": "delivery_tracking",
    "kafka.topic": "delivery_tracking",
    "confluent.topic.bootstrap.servers": "kafka:9092",
    "confluent.topic.replication.factor": 1
  }
}'
