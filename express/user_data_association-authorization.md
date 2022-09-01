# User data association
Table of contents
- [User data association](#user-data-association)
	- [Submitting new data](#submitting-new-data)
	- [Update and destroy data](#update-and-destroy-data)
		- [View: hiding update and delete buttons](#view-hiding-update-and-delete-buttons)
	- [Update and delete nested data](#update-and-delete-nested-data)
		- [Middleware protection](#middleware-protection)
		- [View: Hide buttons and links](#view-hide-buttons-and-links)
	- [Administrator role](#administrator-role)
	- [Cascade delete](#cascade-delete)
## Submitting new data
When a new post post/page or comment is created by a user that content should get an ID that links it to that particular user.

The creation of new content should already be conditioned by middleware so that only logged-in users get to this route. To associate a user to the content we need to update the DATA MODELS that create that content to include an author/user.
```javascript
const commentSchema = new mongoose.Schema({
   	text: String,
 	author: {
		_id: {
           	type: mongoose.Schema.Types.ObjectId,
            ref: 'User'
        },
        username: String
    }
})
```
Consider the PassportJs Authentication: Each http request now has a user object: `req.user` with the following properties: `req.user.username` and `req.user._id`, as set up in the model. 

When creating a new comment in the COMMENT POST ROUTE we add and save those properties into the new object under `.author.id` and `.author.username`: 
```javascript
// see MongoDb for how to create new data
Model.create(req.body.name, (err, newObject) => {
	if(err){}
	else {
		newObject.author.id = req.user._id
		newObject.author.username = req.user.username
		newObject.save()
	}
})

// or directly into the object:
	
let formDataName = req.body.name; 
let author = {id: req.user._id, username: req.user.username}
let newModel = {author: author, name: name}
<Model>.create({newModel}, (err, newData) => {})
```
Thus we store part of the users data INSIDE the comment data instead of looking it up every time a comment is called from the db. This can only be done in a db like MongoDb.

Since the `author.id` and `author.username` are now part of the new object you can easily call it to show up in the HTML page as any other property such as title or description:
`<%= comment.author.username %>`.

## Update and destroy data
Update and delete routes need to be restricted based on certain logic: Users have to be logged in to see delete/update buttons and you have to check wether the logged-in user is the owner of the data that may be updated or deleted. Therefore we add custom middleware on ALL the edit, update and delete routes.

Middleware logic:		
1.	check if user is logged in
2.	find the dataObject subject to update/delete through the route parameter id
3. 	check if dataObject author ID equals the userID of the current session. 

Note that when the dataObject was created, the userID was stored as a property inside the dataObject as `.author.id`
```javascript
if(req.isAuthenticated()){
	dataModel.findById(req.params.id, (err, foundData) => { 
		if(err){res.redirect('back')}
		else (if(foundData.author.id.equals(req.user._id))){
			next()
		}
}
```
### View: hiding update and delete buttons
Wrap the links or buttons into a similar middleware if statement. 
```
	<% if(currentUser && campground.author.id.equals(currentUser._id)){ %>
```
Only if the ID's match the buttons will be shown. In the HTML there is no access to `req.user._id` but in the PassportJS configuration a *currentUser object* is present and that is made available on all routes in the app.js. Thus it can be used in the comparison.
  
If user is not logged-in the `currentUser` value will be `undefined` and an error will thrown. Therefore you add the `currentUser &&`.

## Update and delete nested data
The most notable difference with a regular update or delete is the route structure and the eventual parameter ID's that are being used. To render an update form there will be more data that has to be looked up in the DB and passed on to the form. The ID's wil depend on the earlier defined routes. Note that they cannot coincide, thus use different names. For example:
`/campgrounds/:id/comments/:id/edit`.

The `.findById` method would not work because the second `:id` would overwrite the first. But we can use `/campgrounds/:id/comments/:id_comment/edit` and `.findById(req.params.id_comment)`.

### Middleware protection
To protect the routes so that only authorized user can update or deleted nested data, follow a similar pattern as above. Important is to use the correct `dataModel` and id's to compare. Look it up inside the Model file.

### View: Hide buttons and links
Similar procedure in the HTML with and if statement. 


## Administrator role
An administrator can delete and update all data. To implement this update the user Data Model with a property `isAdmin`: 
```javascript
isAdmin: {type: Boolean, default: false}
```
When creating a new User in the post route, add this property to the new user object to avoid external postman request setting this to true.
```javascript
User.register(new User({username: req.body.username, isAdmin: false})
```
Now there are two more steps: make the buttons visible in HTML and update the middleware to extend functionality to `isAdmin` user.

Middleware: the conditional in the if statement checks for matching ID's between user and reference in the `dataObject`. Add an `||` statement to check for `req.user.isAdmin`:
```javascript
if(foundCommentData.author.id.equals(req.user._id) || req.user.isAdmin)
```
In HTML swap the `req.user` for `currentUser && currentUser.isAdmin`

## Cascade delete
When a `dataObject` is deleted probably it is a good idea to also remove related data that is referenced inside that dataObject. A good example are the Campgrounds and the comments that are related to each Campground. Those comments are stored in a separate data collection in the db but are referenced inside each Campground dataObject as an array of comment references.                   