# The HTTP Request Object Properties
```
req.app	
//-> holds a reference to the Express app object

req.body	
//-> contains the data submitted in the request body and must be parsed into a workable JSON format (body-parser) and/or populated manually before you can access it in Express

req.ip	
//-> ip from where the request originates

req.path
//-> the URL path of the request

req.query	
//-> OBJECT containing all query strings in request. Express makes it very easy by populating the req.query. This object is filled with a property for each query parameter. If there are no query params, it's an empty object. With a for..in loop you can loop through it: for(const key in req.query){}

req.xhr		
//-> TRUE if the request is an XMLHttpRequest

req.baseUrl	
//-> baseUrl of the request
```