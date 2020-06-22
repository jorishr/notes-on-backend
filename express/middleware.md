# Middleware
Table of contents
- [Middleware](#middleware)
	- [About middleware](#about-middleware)
	- [Login-protected routes](#login-protected-routes)
## About middleware
Middleware are functions that are executed between the route request and the HTTP request handler functions. It hooks into the routing process and is used to edit the request or response objects before it reaches the route handler code.

Middleware can pre-written library code or your own custom code. Store it in a seperate file and import where necessary (in the route files).

## Login-protected routes
Routes that are only accesible to logged in users. This is accomplished by adding middleware. 
```javascript
router.get('/new', middleware, (req, res) => {})

//middleware module:
middlewareObj = {};
middlewareObj.isLoggedIn = function (req, res, next){
	if(req.isAuthenticated()){
       	return next();
   	};
   	res.redirect('/login');
};

module.exports = middlewareObj;
```
Always call `next()` at the end of our middleware function, to pass the execution to the next middleware or route handler, unless we want to prematurely end the response, and send it back to the client. The return next() is calling the next middleware functions or the handler functions.

To check whether autentication is true use the passport method `is.Authenticated` on the http request object.

If there is no authentication present, redirect to to the login form.