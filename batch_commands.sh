log in to MariaDB 
 mysql --user=student --password=student labs 
-- SQL commands to set up MySQL database and table

CREATE DATABASE mydatabase;
USE mydatabase;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    city VARCHAR(100)
);

INSERT INTO students (name, age, city) VALUES
    ('John Doe', 25, 'New York'),
    ('Jane Smith', 22, 'Los Angeles'),
    ('Ahmed Ali', 28, 'Cairo');

-- View Data in the Table

SELECT * FROM students;

-- Describe the Table

DESC students;

-- Sqoop command to import data from MySQL to HDFS

sqoop import \
--connect jdbc:mysql://localhost/mydatabase \
--username student \
--password student \
--table students;

-- Making target directory in Hadoop HDFS  

hdfs dfs -mkdir /dwh_;

-- Import Data to HDFS Target Directory

sqoop import \
--connect jdbc:mysql://localhost/mydatabase \
--username student \
--password student \
--table students \
--fields-terminated-by ',' \
--target-dir /dwh_/students;

-- Check if Data Was Imported

hdfs dfs -ls /dwh_/students;

-- Show Data in HDFS

hdfs dfs -cat /dwh_/students/part-m-00001;

