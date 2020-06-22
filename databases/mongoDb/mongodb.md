# Mongo DB
Table of contents
- [Mongo DB](#mongo-db)
	- [About](#about)
	- [Setup](#setup)
	- [Basic commands](#basic-commands)

## About
A database is a collection of data with an interface that allows us to interact with the data and perform CRUD operations (create, read, update, delete).

MONGODB is a non-relational database. It has no tables and you can nest data. Plus not all objects need to have the same properties. It uses document collections.

## Setup
On Windows it basically it runs from `c:\momgodb\bin` with the DEAMON `mongod.exe` and the TERMINAL `mongo.exe`.

## Basic commands
```
//show all databases
show dbs 

//switch to the db and creates one if not existed already

use <db-name>	
		
//lookup existing collections
show collections

//shows all entries inside a collection in a readable format
db.<collection>.find().pretty()	

//search with a key-value pair
db.<collection>.find({name:'max'})

//search by id
db.<collection>.findById('id')

//insert a new data object into a collection

db.<collection>.insert({dataObject})

//update an object entry
db.<collection>.update({selectorObject}, {changeToObject})
	
selectorObject: {name:'max'}
changeToObject: {$set: {breed: 'pastor aleman'}}

//IMPORTANT: if you don't use the $set: {} notation, the entire entry will be overwritten with the proposed change	

//delete entry
db.<collection>.remove({selector})

// delete ALL entries
db.<collection>.drop()	
```

An ODM (Object Document Modelling), framework like Mongoose will combine and streamline the most commonly used commands. 