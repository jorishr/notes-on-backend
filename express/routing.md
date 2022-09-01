# Routing in ExpressJs
Table of contents
- [Routing in ExpressJs](#routing-in-expressjs)
  - [About routing](#about-routing)
  - [Code organization](#code-organization)
    - [Base routes](#base-routes)
    - [Helper functions](#helper-functions)
  - [Route parameters / path variables](#route-parameters--path-variables)
## About routing
Routing refers to determining how an application responds to a client request to a particular endpoint. An endpoint is a URI (or path) and a specific HTTP request method (GET, POST, and so on).

Each route can have one or more middleware and handler functions, which are executed when the route is matched.
```javascript
//app.method(path, middleware, handler)
app.get('/', isLoggedIn, (req, res) => console.log('hello'))
```
App is an instance of the `express();`. Method refers to an HTTP request method(get, post, put, delete, etc.). Path is a path on the server.

## Code organization
Create separate js files for each ROUTE and use the EXPRESS Router. You only have to export the router. 
```javascript
const router = express.Router()
router.get('/', (req, res) => console.log('hello'))
//swap app.<request> for router.<request>
module.exports = router;
```
In the app.js require in the route files and indicate to Express to use each one of them:
```javascript	
const routeOne = require('routeOne.js');
const routeTwo = require('routeTwo.js');

app.use('<baseRoute>', routeOne);
app.use('<baseRoute>', routeTwo);
```
The statements order is important. Put the routes at the bottom, after authentication.

### Base routes
If you specify a base route in the app.js you have to omit it in the individual route.js files. In the express app.js you will want to import various route files and thereby you can indicate the baseURL for each route.

For example, the comments routes all start with `/comments`: 
```javascript
const commentsRoutes = require('commentsRoutes.js')
app.use('/comments', commentsRoutes);
```
In the individual route files you can now omit the /comment and simply write  `/` , `new` or `/delete`.

IMPORTANT: doing so when using ID's for pages or posts might mean the ID's become inaccessible to other routes, especially when using nested routes as, for example, `campground/comments/:id` whereby alo the campground has an id route at `campgrounds/:id`. Preserve the `req.params values` from the parent router. If the parent and the child have conflicting param names, the child’s value take precedence. Therefore in each route add the MERGE PARAMS option to the express router:
```javascript
const router = express.Router({mergeParams: true}),  
```

### Helper functions
On the same route you often have both a GET and POST request route. Those can be put into a helper function to make the code more readable (helper.js): 
```javascript
const db = require('../models');
exports.getTodos = (req, res) => {
    db.'<Model>'.find().then(fn(data){//do smth});
    .catch(function(err){res.send(err);});};
}
exports.createTodos = (req, res) => {
    db.`<Model>`.create(req.body)
    .then(function(newData){res.status(201).json(newTodo)})
    .catch(function(err){res.send(err)}); };
}
//In routeFile.js
const   express = require('express'),
        router  = express.Router(),
        db      = require('../models'),
        helpers = require('../helpers/routeHelpers');

router.route('/')
    .get(helpers.getTodos)
    .post(helpers.createTodos);
```
## Route parameters / path variables
You can set up multiples routes patterns that correspond to folders, titles, id's or comments in the database that will be created at a later stage, either by the site administrator or the users.

The pattern is defined by '/' and ':':
```javascript	
app.get('/:page', (req, res) => {
	console.log(req.params);
})	
```	
THe `:page` parameter can be anything, it is a route that now exists which may lead to `/shop`, `/forum` or whatever.
	
If you type in the browser `/shop`, the Node console will log the request parameter as an object: `{ page: "shop"}`.

Example of a more complicated forum-like structure:
```javascript
app.get('/:page/:topic/:post/:id', handler)
//-> { page: 'page', topic: 'topic', post: 'post', id: 'id' }
//-> '/football/ryan-giggs/tearing-you-apart/since1991' will be a valid route
{ 
	page: 'football',
  	topic: 'ryan-giggs',
  	post: 'tearing-you-apart',
  	id: 'since1991' 
}
//-> '/football' or '/football/ryan-giggs' are invalid unless they are specifically defined as well:
```
To access the parameter data coming from the request use: `req.params`.