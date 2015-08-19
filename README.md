Scala to Cassandra Connection
=============================

## Create Keyspace and Table
```
--- create a namespace ---
CREATE KEYSPACE engine35 WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
DESCRIBE KEYSPACES;
USE engine35;

--- create a table ---
CREATE TABLE bigtable (
  url text PRIMARY KEY,
  root text
);
```

## Packaging
```
$ sbt package
$ sbt "run 127.0.0.1 1000000"

```
