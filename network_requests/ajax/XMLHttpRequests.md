# XMLHttpRequests
Table of contents
- [XMLHttpRequests](#xmlhttprequests)
  - [Asynchronous XMLHttpRequest](#asynchronous-xmlhttprequest)
  - [Track download progress](#track-download-progress)
  - [Parse incoming data](#parse-incoming-data)

XMLHttpRequest has two modes of operation: synchronous and asynchronous.

## Asynchronous XMLHttpRequest
Example:
```javascript
let xhr = new XMLHttpRequest();
xhr.open('GET', '<api-URL>');
xhr.send()
xhr.onreadystatechange = function(){
  console.log(xhr.readyState);
  if(xhr.readyState == 4 && xhr.status == 200){
    console.log(xhr.responseText);
  };
};
```
Create a new instance and configure the request. The http method is usually 'GET or 'POST' and the URL is a string.  
```javascript
let xhr = new XMLHttpRequest();
xhr.open(method, URL, [async, user, password])
```
Async is true by default, set to false for synchronous 

Open does NOT open a connection, that is done by `xhr.send`, open merely configures the request.
 
The send method opens the connection and sends the request to server. The optional body parameter contains the request body. Some request methods like GET do not have a body. And some of them like POST use body to send the data to the server. `xhr.send([body])`

Listen to xhr events for a response: `xhr.onload`. The request is completed and the response is fully downloaded (including possible 400 or 500 responses)

You have now access to properties:
- xhr.status (http status code) and xhr.statusText
- xhr.response server response body (or xhr.responseText)

The `xhr.onprogress` method, triggers periodically while the response is being downloaded
The `xhr.onerror` method triggers when the request couldn't be made, e.g. invalid URL
The `xhr.timeout = 10000;` can be set to cancel the request if no response after 10 sec

The `.onreadystatechange` method checks the changing state on every step of the way. You can log this with the `.readyState` method:
```
0: UNSENT the .open() has not been called yet; 
1: OPEN, the .open() has been called; 
2: HEADERS_RECEIVED; 
3: LOADING, response text is being downloaded; 
4: DONE, operation complete.
```
Check for the status code as well, as you need to foresee the possibility there is server connection problem.

## Track download progress
```javascript
xhr.onprogress = function(event) {
	if (event.lengthComputable) {
    		console.log(`Received ${event.loaded} of 					${event.total} bytes`);
  	} else {
    		console.log(`Received ${event.loaded} bytes`); 
		// no Content-Length header sent by server
  	}
};

xhr.onload = function() {
  alert(`Loaded: ${xhr.status} ${xhr.response}`);
};
```
## Parse incoming data
The data is usually a JSON object sent as a string. To use in JS code you need to parse it to JS object. After that you can work with the various object properties.
```javascript
let responseData = JSON.parse(xhr.responseText);
img.src = responseData.url;
```