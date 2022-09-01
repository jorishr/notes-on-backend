# Database scaling options
## Replication
The master-slave relationship is a classic. The data is replicated on various slaves as backup or for different tasks. For example, writing to the database is only done on the master db. Reading can be send to slave db's. Possible downside is a replication lag that may occur between master and slave.

## Sharding
When too much data is accumulated in one single database. A hash table can be created for storing records in different databases. Thus you get a series of cylinders: 1-100; 101-200; 201-300; etc.
Downside is that many queries become very complex and to retrieve data a query may have call on all machines. Also joins are difficult.