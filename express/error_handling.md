# Error handling in ExpressJs
Table of contents
- [Error handling in ExpressJs](#error-handling-in-expressjs)
	- [Built-in error handling](#built-in-error-handling)
		- [Synchronous vs asynchronous tasks](#synchronous-vs-asynchronous-tasks)
	- [Custom error-handling middleware](#custom-error-handling-middleware)
		- [Example](#example)
	- [Code organization](#code-organization)
	- [Async / await](#async--await)
	- [Handling 404 Errors](#handling-404-errors)
## Built-in error handling
### Synchronous vs asynchronous tasks
You can define error handling manually for each route through the `if(err){}` statements or by using the try-catch blocks: `try {...} catch(err)}{res.status(500).send('internal server error');`

But this is hard to maintain and requires writing a lot of duplicate code.

It is important to note that Express catches and processes all the errors that occur while running route handlers and middleware that occur in synchronous code. 

Asynchronous code, however, requires extra work. Database operations, working with the filesystem etc., will take time to complete and are thus handled as asynchronous by NodeJS and the browser. To let EXPRESS handle errors that occur inside those asynchronous tasks you need to use an extra parameter NEXT and use the `next()` function to pass errors to ExpressJs.
```javascript
app.get("/", function (req, res, next) {
  fs.readFile("/file-does-not-exist", function (err, data) {
    if (err) {
      next(err); // Pass errors to Express.
    }
    else {
      res.send(data);
    }
  });
});
```
If you pass an error to next() the built-in error handler of ExpressJs will handle the error. Alternatively, you can use custom error-handling middleware (see next section).

## Custom error-handling middleware
The process:
- catch or throw your error with a useful message
- pass the error parameter into next()
- centralize your errors in error-handling middleware

Error handling middleware functions take FOUR arguments and will only get called if an error occurs. 
```javascript
app.use(function (err, req, res, next) {
 	res.locals.error = err;
  	res.status(err.status || 500);
	res.render('error');
	console.error(err.stack);
});
```
The `console.error` contains the error stack or stack trace. Through the `res.locals` we make the error object available in the route response object. Now it can be rendered in the view page for errors.

The `res.status` will either be the http response status or the default 500 server error code.

The final response from within this  middleware function is a JSON String. But you can use any format like an HTML error page or a simple message.

IMPORTANT! In the app.js this error handling middleware needs to come AFTER all route calls.
### Example
```javascript
app.get('*', function(req, res, next) {
	let err = new Error(`${req.ip} tried to reach ${req.originalUrl}`); 
	err.statusCode = 404;
	err.shouldRedirect = true;
// shouldRedirect: set this to true and use it as condition in the middleware:
	if (!err.statusCode){
		err.statusCode = 500;
	}; 
	if (err.shouldRedirect) {
   		res.render('error')
   	} else {
		res.status(err.statusCode).send(err.message);
   }
});
```
Thus if `shouldRedirect` is not defined in the error, send the original err data.
If no `err.statusCode` is set, set the generic 500;


## Code organization
You can write a separate error.js file with multiple functions for different type of errors.
When not calling the next() method in a custom error-handling function, you are responsible for writing (and ending) the response with `res.render()`. Otherwise those requests will 'hang' and will not be eligible for garbage collection by the default express error handling.
```javascript
app.use(logErrors);
app.use(clientErrorHandler);
app.use(errorHandler);

function logErrors (err, req, res, next) {
  console.error(err.stack)
  next(err)
}
// client error handling for XHR requests:
function clientErrorHandler (err, req, res, next) {
	if (req.xhr) {
		res.status(500).send({ error: 'Something failed!' })
	} else {
 		next(err)
  	}
}
// catch all other errors:
function errorHandler (err, req, res, next) {
  	res.status(500)
  	res.render('error', { error: err })
}
```
## Async / await
Express was mostly written 2011-2014, before ES6, and it still lacks a good answer for how to handle the async/await keywords. We can write the above code in async/await manner. With a little helper function, you can tie async/await errors in with Express error handling middleware. Remember that async functions return promises, so you need to make sure to `.catch()` any errors and pass them to `next()`:
```javascript
function wrapAsync(fn){
	return (req, res, next) => {
		fn(req, res, next).catch(next);
	};
};

app.get('/', wrapAsync(async function(req,res){
	await new Promise(...)
	...	
}))
```
## Handling 404 Errors
In Express, 404 NOT FOUND responses are not the result of an error, so the error-handler middleware will not capture them by default. This behavior is because a 404 response simply indicates the absence of additional work to do. All middleware functions and routes are checked out and none of them responded. 

Handling 404 (not found) can be done with HTTP-ERRORS package.
```javascript
app.use(function(req, res, next) {
	next(createError(404));
}); 
```