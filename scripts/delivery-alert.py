#!/bin/python

from confluent_kafka import Producer, Consumer, KafkaError, TopicPartition
import json
import requests

import smtplib

from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase

settings = {
    'bootstrap.servers': 'localhost:9092',
    'group.id': 'delivery_alerts',
    'default.topic.config': {'auto.offset.reset': 'largest'}
}
c = Consumer(settings)
p = Producer({'bootstrap.servers': 'localhost'})

c.subscribe(['DELIVERY_TRACKING_DEST_DISTANCE_ALERT'])

gmail_user = 'delivery-alert@gmail.com'
gmail_password = 'fuxdnuafqhhwlcnj'

# Poll for messages; and extract JSON and call pushbullet for any messages
while True:
    msg = c.poll()
    if msg.error():
        if msg.error().code() == KafkaError._PARTITION_EOF:
            continue
        else:
            print(msg.error())
            break

    app_json_msg = json.loads(msg.value().decode('utf-8'))
    print('Received message: {}', app_json_msg)

    title='Delivery alert from KSQL!'
    body='Delivery notification to %s for an order %s\n' % (app_json_msg['CUSTOMER_EMAIL'], app_json_msg['ORDER_ID'])

    msg = MIMEMultipart()
    msg['From'] = 'delivery-alert@gmail.com'
    msg['To'] = 'app_json_msg['CUSTOMER_EMAIL']'
    msg['Subject'] = 'Delivery Update'
    body = 'Dear Customer,\nWe would like you let you know that your parcel (Order ID: ' + str(app_json_msg['ORDER_ID']) + ') is not far away and should be with you shortly!\nRegards, Delivery Doughnuts'

    msg.attach(MIMEText(body, 'plain'))
    try:
        server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
        server.ehlo()
        server.login(gmail_user, gmail_password)
        text = msg.as_string()
        server.sendmail("delivery-alert@gmail.com", app_json_msg['CUSTOMER_EMAIL'], text)
    except Exception as inst:
        print(inst)

    # Send a push notification to phone via push-bullet
    print('%s\n--\n' % (title))
    data = json.dumps({'order_id': app_json_msg['ORDER_ID']})
    p.produce('delivery_tracking_dest_distance_alerted', data.encode('utf-8'))