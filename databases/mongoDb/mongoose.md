# Mongoose
Table of contents
- [Mongoose](#mongoose)
	- [About ODM](#about-odm)
	- [ExpressJs setup](#expressjs-setup)
	- [Schema and models](#schema-and-models)
	- [Save data to the database](#save-data-to-the-database)
		- [Save](#save)
		- [Create](#create)
	- [Read or retrieve data from the database](#read-or-retrieve-data-from-the-database)
		- [Route parameter based on id retrieval](#route-parameter-based-on-id-retrieval)
	- [Service classes](#service-classes)

## About ODM
Mongoose is an Object Document Modeling (ODM) package which facilitates the database operations between the server framework ExpressJs and the MongoDb database. It is a JS layer on top of MongoDB.

You setup the connection in the ExpressJs app.js file and from then on the running app.js can perform CRUD operation on the database. You could do all this manually without an ODM package but that takes more code to write yourself.

## ExpressJs setup
In the app.js add following code. Note that if the db is not found, it will be created. 
```javascript
process.env.DB_CONN='mongodb://localhost/<db-name>',

mongoose.connect(process.env.DB_CONN, {useNewUrlParser: true});

db.on('error', console.error.bind(console, '\nConnection error:\n'));

db.once('open', () => {
	console.log('\nDatabase connection established');
});	
```
Use an if statement to check for the presence of an environment variable with the URI. If none is set, use the local db or the database that is used in development. By using this approach the code is set up for deployment, no matter what the location of the production server may be. Use: `process.env.Mongo.DB.URI`. 

To activate the DEBUG MODE: `mongoose.set({'debug': true})`

To use the PROMISES syntax: `mongoose.Promise = Promise;`

## Schema and models
The SCHEMA is the structure of your DOCUMENT OBJECTS and the MODEL is a class with which we construct documents.
```javascript
//const ModelName = mongoose.model('ModelName', SchemaName);
//the 'ModelName' will be used as the name of the collection, pluralized. Thus 'Dog' becomes a collection DOGS 
const nameSchema = new mongoose.Schema({
	//set data type for each property
	name: String>,
	location: String,
	age: Number
})

//the ModelName can now be used with it's methods, just as in the database itself:
ModelName.find()
ModelName.create()
ModelName.delete()
```

## Save data to the database
### Save
Each document can be saved to the database by calling its save method. Though in practice you will probably be using the CREATE route.
```javascript
const testDocument = new ModelName({
	name: 'adas', age: '24', location: 'eaeaf'
});
testDocument.save((err, savedData) => {
	if (err) { return console.error(err); }
	else { return console.log('Saved successfully: ', savedData); }
})
// The callback function is necessary to confirm 
```
### Create
```javascript
ModelName.create({newObject}, cbFn)
```	
The `newObject` data will probably be retrieved from an input element in a form with a NAME attribute. Those name attributes form part of the POST request and can be found in the body:
```javascript
const newDataA = req.body.<nameAttributeA>
const newDataB = req.body.<nameAttributeB>
	
//Store the new-to-create-object:
const newObject = {<name>: newDataA, <name>: newDataB}
```
The callback function has two parameters: the error and the `dataObject` that is being stored in the database. You can name it as you please.

If the data is created successfully you can specify actions, for example: 
- send the user back to the original page
- console.log
- show feedback to user on the same page, etc.
```javascript
(err, savedData) => {
	if(err){ console.log(err) }
	else {
		console.log('Successfully added to DB:\n', newDataEntry);
		res.redirect('/');
	}
}
```
## Read or retrieve data from the database
You can display all or partial database data on the pages of your site. usually within an `app.get()` request:
```javascript
ModelName.find({dataToShow}, cb)

//The dataToShow can be: find({}), that is all entries or documents in the collection. Or only those with a specific name:
	
ModelName.find({name: 'example'}, cb)

//IMPORTANT! The callback function has the same double function as above: error reporting and ACTIONS to be take upon successfully retrieval of data from the db. The retrieved data will be an object that we call 'foundData'

(err, foundData) => {
	if(err){console.log(err)}
	else {
		res.render('page', {key: foundData})
		//pass the retrieve info to rendered page
	}
}
```
In the views/page.ejs you can now access the data object and use it's properties:
```HTML	
<h1><%= key.name %></h1> 
<p><%= key.description %></p>
``` 
### Route parameter based on id retrieval
Each document in the collection has a unique ID. You can send the user to a route with this ID by accessing it in the HTML when creating a link:
```HTML
<a href="/page/<%= dataObject.id %>">Link</a>
```
For this to work you need to setup an ID GET ROUTE in the ExpressJs app with a ROUTE PARAMETER:
```javascript
app.get('/page/:id', (req, res){})
```
To use the ID to find a SPECIFIC document in the DB and display it on the page MONGOOSE has a METHOD called findById(). To know which ID to look for in the DB you look inside the GET REQUEST PARAMETERS and pass is to the findById() method:
```javascript	
app.get('/page/:id', (req, res)=>{
	ModelName.findById(req.params.id, (err, foundData) => {
		res.render('id-page', {dataObject: foundData})
	})		
})
```
Final step on the ID-PAGE is access the `dataObject` and display the properties you want:
```HTML
<h1><%= dataObject.name %></h1>
<p><%= dataObject.description %></p>
```
## Service classes
The functionality related to each model can be grouped into a Model class. Create a folder for services and instantiate each Model class in the index file.

This may seem redundant for smaller projects but it keeps the database queries out of the route/controller functions. That we you have a better code structure that better resembles the single responsibility principle.

For examples see:
- [The boring but common server architecture](https://github.com/fChristenson/The-boring-server-architecture)
- [Catacamp repo](https://github.com/jorishr/yelp-camp)