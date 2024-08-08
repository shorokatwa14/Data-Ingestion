#!/bin/bash

# Stop HBase
sudo stop-hbase.sh

# start Kafka and Zookeeper
sudo systemctl stop kafka
sudo systemctl stop zookeeper
sudo systemctl start zookeeper
sudo systemctl status zookeeper
sudo systemctl start kafka
sudo systemctl status kafka

cd /home/student/Documents

#make agent configration
nano spooldir.conf


#conf file
agent1.sources = streaming-txt-source
agent1.sinks = kafka-sink logger-sink
agent1.channels = memory-channel

agent1.sources.streaming-txt-source.type = spooldir
agent1.sources.streaming-txt-source.spoolDir = /home/student/Documents/spool

agent1.sinks.kafka-sink.type = org.apache.flume.sink.kafka.KafkaSink
agent1.sinks.kafka-sink.topic = stream_text
agent1.sinks.kafka-sink.brokerList = localhost:9092
agent1.sinks.kafka-sink.batchSize = 5

agent1.channels.memory-channel.type = memory
agent1.channels.memory-channel.capacity = 10000
agent1.channels.memory-channel.transactionCapacity = 100

agent1.sinks.logger-sink.type = logger

agent1.sources.streaming-txt-source.channels = memory-channel
agent1.sinks.kafka-sink.channel = memory-channel
agent1.sinks.logger-sink.channel = memory-channel


#create kafka topic 
kafka-topics --create \
--bootstrap-server localhost:9092 \
--replication-factor 1 \
--partitions 1 \
--topic stream_text

mkdir spool

## In a new terminal called producer ###
# Start Flume agent
flume-ng agent \
--conf $FLUME_HOME/conf \
--conf-file /home/student/Documents/spooldir.conf \
--name agent1 -Dflume.root.logger=INFO,console

## In a new terminal run python file with data file to make it streaming  ###
python ./spool_stream.py ./spool 500 /home/student/Documents/Adventures.txt

############ In a new terminal called consumer to see the pipline ################
kafka-console-consumer \
--bootstrap-server localhost:9092 \
--topic stream_text \
--from-beginning

