# Data Ingestion Pipeline

## Project Overview

This project is part of the Samsung Innovation Campus training and involves setting up a data ingestion pipeline capable of handling both historical data and real-time data streams on a local machine. It leverages Apache Sqoop, Apache Flume, Apache Kafka, and Hadoop's HDFS to ensure efficient and reliable data migration and real-time data handling.

## Features

- **Data Migration**: Uses Apache Sqoop to migrate historical data from a local relational database (MySQL) to Hadoop's HDFS, with support for incremental imports.
- **Real-Time Data Ingestion**: Configures Apache Flume to collect log data from a local directory and sends it to Apache Kafka for buffering and management.

## Setup Instructions

1. **Environment Setup**:
   - Install Hadoop, Sqoop, Flume, and Kafka on virtual machine..

2. **Data Migration**:
   - Create a local MySQL database and populate it with sample data.
   - Use Apache Sqoop to import the data into HDFS.
   - Configure incremental imports to handle new data entries.

3. **Real-Time Data Handling**:
   - Configure Apache Flume to capture log data from a local directory.
   - Send the collected data to a Kafka topic for storage and management.

## How to Run

1. Start all necessary services (Hadoop, Kafka, Flume).
2. Run the Sqoop commands to import data from  local database to HDFS.
3. Configure and run Flume to begin collecting and sending log data to Kafka.
4. Monitor the data flow in Kafka to ensure everything is working correctly.

