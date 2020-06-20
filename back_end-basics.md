# Back-end basics
Table of contents
- [Back-end basics](#back-end-basics)
	- [About Back-end](#about-back-end)
		- [Common tasks and features](#common-tasks-and-features)
		- [Back-end Structure](#back-end-structure)
	- [HTTP Request-Reponse Cycle](#http-request-reponse-cycle)
		- [HTTP](#http)
		- [HTTP GET Request examination](#http-get-request-examination)
			- [Query Strings](#query-strings)

## About Back-end
### Common tasks and features
- check if a user is logged in, based on that condition send different type of html/css/JS
- on the server: signup a new user, add new post to database, create new comment
- on the database: remove post/comment, sort posts/comments 

### Back-end Structure
Once the server is started, it will be listening for HTTP requests coming from a usually a browser or ftp requests from a ftp client.
1. Server Setup code, listing dependencies that are used
2. Database setup
3. Routing setup (routes to pages)


## HTTP Request-Reponse Cycle
A certain type of request is made to the server (get, post, patch, copy, delete, etc.) by either the browser, command line (NodeJs), app (Postman), etc. The server processes this request and sends back a response. For example: retrieve the google.com homepage is a GET request. What you get back is HTML/CSS/JS combo code which the browser shows a usable page.

POST requests is when you submit new information to a server, thus alongside the http request you send additional data, for example, a comment, a picture, etc. PUT and PATCH are to update or edit existing data.

The HTTP request has a BODY and a HEADER. The body contains all the actual data that is being send. Text input or CSS/HTML/JS combo from the server. The header contains functional or meta-data about the request. Most important is to understand the status codes.

### HTTP
The hypertext transfer PROTOCOL is just a protocol through which we expect certain things to happen. Sending the DELETE request, for example, we EXPECT the server to go and delete an item from the database. Whether this actually happens or not does not depend on the HTTP request. Each HTTP request is independent. It does not have nor store information about previous or future requests. 

To complement the user experiences other tools can be used: cookies, local storage or sessions. But at it's core a http request stands on its own.

HTTP/2 (version 2) allows for multiplexing which means you can have multiple request that run at the same time in parallel. This has not much implications for web developers but it does increases efficiency and speed.

HTTPS adds a secure encryption to each http cycle using SSL or TLS. SSL: secure sockets layer; TLS: transport security layer. TLS is the successor of SSL and SSL handshakes are now called TLS handshakes, although the "SSL" name is still in wide use.

### HTTP GET Request examination
In this example we use the Postman app but under the network tab in chrome dev tools you can find similar information. 

The GET request for google.com produces a response from the google servers that contains:
- body: raw code (containing html, css, js), same as thepage source you can access in the browser
- headers (12): metadata about the response containing timestamp, content-type
- status (200 OK): the status codes are part of the http protocol, if a page is not found on the server you get a 404 error code.

#### Query Strings
Get is only used to retrieve info from the server and thus we do not send data with it, EXCEPT for search queries. When searching we do not add data to a server/database. We just send some additional query string with the http request. The browser bar itself can only make GET requests (no put, delete or post) and there you can see or even write the query strings:
`?q=value&key=value`.
```
// Examples: 
https://www.reddit.com/search?q=test1%20test2&city=bcn
https://www.reddit.com/search?q=tower&structure=bridge
%20 	//-> is a space
& 		//-> seperates the different queries
```
Thus when such a GET request is made, the server is programmed to work with those requests by running a specific code. For example, code that searches for keywords inside an array of objects.
```HTML
<form action="/url" method="POST">
	<input type="text" name="object property1 name">
	<input type="text" name="object property2 name">
	<input type="submit">
</form>
```
The above form sends a post http request to the specified url and the values entered into the form will become the values to the specified object properties in the database. The POST request can also redirect away from the current page and then refresh the page with newly rendered content.