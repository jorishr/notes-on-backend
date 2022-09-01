# RESTful Routing
Table of contents
- [RESTful Routing](#restful-routing)
	- [About](#about)
		- [Versioning](#versioning)
	- [Example](#example)
	- [Nested Routes](#nested-routes)

## About
REST is a convention for setting up route patterns that are easy to understand and share between developers. REST stands for Representational State Transfer: an architecture style for network applications. It almost always uses HTTP(web API's, at least) which is a stateless client-server protocol. 

What REST does is proving a format the HTTP request. It treats server objects as resources that can be created, updated or destroyed. For example a server object can be a blog post in a database. HTTP requests (get, post, put, delete) are used. The REST API structures the exact way this has to happen, using HTTP as protocol.

### Versioning
Use versioning FLAGS for your own API's. This makes the code more maintainable and backwards compatible. If new features are implemented, you do so in v2 while v1 continuous to work as before.
```
app.get('api/v1/create');
app.get('api/v2/create');
```
## Example
Usually there 7 ROUTES:
```
//  name            url          verb    desc
=================================================================
//  INDEX route     /page        GET     list all 
//  NEW route       /page/new    GET     show form  
//  CREATE route    /page        POST    add new sites DB
//  SHOW            /page/:id    GET     show ID info
//  EDIT        /page/:id/edit   GET     show edit form
//  UPDATE          /page/:id    PUT     update db,redirect
//  DESTROY         /page/:id    DELETE  delete in DB,redirect 
```
## Nested Routes
Comments are a good example. They don't make much sense on their own. They are usually linked to a post or an item. Thus you don't create a separate 8th route for comments. Instead you nest them.
```
/page/post/:id/comments/new	-> form to create new comment
/page/post/comments			-> update db and redirect
```
Important to take into account is that routes can be accessed through browser links but also from other apps. If someone knows the exact URL. This is crucial for security purposes and means you will have to think beyond the user clicking through the pages of your app. Routes will have to be protected from abuse. This is done by using middleware functions.