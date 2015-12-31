Scala to Cassandra Connection
=============================

## Create Keyspace and Table
```
--- create a namespace ---
CREATE KEYSPACE engine35 WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
DESCRIBE KEYSPACES;
USE engine35;

--- create a table ---
CREATE TABLE table35 (
  url text PRIMARY KEY
);
```
## Loading from cqlsh
COPY engine35.bigtable FROM '/home/temp/sort3DCAVs';

## Packaging
```
$ sbt package
$ sbt "run 127.0.0.1"

```
