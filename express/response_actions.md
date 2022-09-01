# Response action to HTTP requests
Table of contents
- [Response action to HTTP requests](#response-action-to-http-requests)
	- [Get request responses](#get-request-responses)
		- [Render a page](#render-a-page)
		- [Respond with JSON](#respond-with-json)
		- [Redirect](#redirect)
		- [Download](#download)
	- [Post request responses](#post-request-responses)
	- [Put and delete request responses](#put-and-delete-request-responses)
		- [Update](#update)
		- [Delete](#delete)
	- [Set http headers](#set-http-headers)
	
## Get request responses
### Render a page
To render a page use a simple request handler function:
```javascript	
app.get(route, middleware, (req, res) => {
	res.render('/page')
})
```
### Respond with JSON
You can responds with a single string or JSON string. When using `res.json` you define an object with key-value pairs that is converted into JSON. An object inside the `res.send('{}')` will also be converted to JSON but better make it explicit by directly using the `res.json()` method.
```javascript
res.send('accepts any string');
res.json({ username: 'I am the user' });
```
For more complex GET requests that include data lookup in db, see MongoDB or MySQL docs.

### Redirect
With `res.redirect('/')` you create a 302 redirect. To get a 301 code you write `res.redirect(301, '/');`
The destination can be:
- an absolute url: 'https://anothersite.com'
- an absolute path ('/go-there') on the same server
- a relative path ('go-there'), ('..') or ('../page') to up one level
- to go back with `res.redirect('back')` means go to the page listed in the HTTP header: Referrer. If none is set, the default is the ('/') index route. 

### Download
When using the `res.download` method you send a file attached to the http respons and instead of rendering the file on the page the browser will prompt the user to download the file. The implementation is simple:
```javascript
//res.download('file', '<custom file name>', cb)
app.get('/', (req, res) => {
	res.download('./file.pdf', 'user-facing-filename.pdf', 				(err) => {
			if (err) {return next()};
			res.render('page');
```
## Post request responses
The responses above are possible as well, but usually a post request means data is being submitted to the app or database. 

Setup a `app.post()` route. You can test it with POSTMAN. If the route starts at a `/form` on a page you should add a subroute for submitting the form:
```	
form located on /form post route: /form/submit	
-> <form name="" action="" method"POST">
```
The "name" tag in the form is processed in the BODY of the http request. To get access to this data you need to PARSE that object (see Body Parser).
	
When connected to a database you will want to store that data but in its most basic form you can add it to an (existing) array:
```javascript	
let items = []
let addedItem = req.body.formNameTag
items.push(addItem)
```
When sending back JSON in an API you can add a status code to make the console info more useful. Standard the code will be OK 200, but you can use 201 CREATED: `res.status(201).json(newData)`

## Put and delete request responses
When working with forms in HTML take into account that PUT and DELETE have not been part of HTML specs and therefore those type of requests will be, by default, processed as POST requests. 

To amend this, use the package METHOD OVERRIDE. 
```javascript
app.use(methodOverride('_method')); 
```
In the html you write:
```js
method="POST"
action="/<route>?_method=PUT"
action="/<route>?_method=DELETE"
```
### Update
For the updating you sometimes want to display the original message or post on a separate page. This requires finding the post id through a SHOW route. Plus, passing the content through an object that is displayed by adding a VALUE to the form INPUT element or TEXTAREA.
```
action="/<route>/<%= postData._id %>?_method=PUT"
value="<%= postData.title %>">

// When working with a textarea elements inside forms, the value attribute is undefined or absent. Just pass as plain text/ejs:
<textarea><%= postData.body %></textarea> 
```
The update route has two components: EDIT and UPDATE. 

The EDIT route redirects to an edit form and passes through the object data. The UPDATE route makes the changes in the DB and redirects back.

The methods to process update and delete requests in ExpressJs are the methods `findByIdAndUpdate()` or `findByIdAndRemove()`. See mongoDB / mongoose docs for details.
```javascript
//render the edit form
router.get('/:id/edit', (req,res) => {
	dataModel.findById(req.params.id, (err, foundData) => {
		if(err){//handle err}
		else {res.render('editForm', {dataObject: foundData})}
	) 
	})
//make the update and redirect
router.put('/:id', (req,res) => {
	dataModel.findByIDandUpdate(req.params.id, 							req.body.<objectInHTML>, 
			(err, updatedData)=>{
				if(err){}
					else{res.redirect('')}
			})
})
```
### Delete
Deleting is done through a FORM that only has a button:
```
action="/<route>/<%= postData._id %>?_method=DELETE"
```
The delete route:
```javascript	
router.delete('/:id', (req, res) => {
	dataModel.findByIdAndRemove(req.params.id, (err) =>	{if(err){} else{res.redirect('')}})
})	
```

## Set http headers
You can change any HTTP header value using: `res.set('Content-Type', '<type>');` or short hand:
```js
res.type('html')	//	-> text/html 
res.type('json')	//	-> application/json
res.type('png')		//	-> image/png
```