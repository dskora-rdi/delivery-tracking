#!/bin/sh
curl -XPUT "http://elasticsearch:9200/delivery_tracking" -H 'Content-Type: application/json' -d'
{
    "mappings" : {
        "kafka-connect" : {
            "properties" : {
            	"track_id": {"type": "keyword"},
            	"location": {"type": "geo_point"},
            	"destination": {"type": "geo_point"},
            	"timestamp": {"type": "date", "format": "YYYY-MM-dd HH:mm:ss"}
            }
        }
    }
}
'
