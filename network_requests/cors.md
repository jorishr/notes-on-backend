# CORS: Cross Origin Resource Sharing
Table of contents
- [CORS: Cross Origin Resource Sharing](#cors-cross-origin-resource-sharing)
	- [About](#about)
	- [Levels of access](#levels-of-access)
	- [CORS Requests](#cors-requests)
	- [CORS in ExpressJs](#cors-in-expressjs)

## About
A JavaScript application running in the browser can usually only access HTTP resources on the same domain (origin) that serves it. Cross-origin requests  sent to another domain (even a subdomain) or protocol or port require special headers from the remote side.

The same-origin policy is a critical security mechanism that restricts how a document or script loaded from one origin can interact with a resource from another origin. It helps isolate potentially malicious documents, reducing possible attack vectors.

Loading images or scripts/styles always works, but XHR and FETCH calls to another server will fail, unless that server implements a way to allow that connection.Thus if the other origin has a different DOMAIN, PORT or PROTOCOL the request will fail. 

A web app running on http://domain-a.com can use remote JS libraries such as jquery or remote images. But XMLHttpRequests and the Fetch API follow the 'same-origin policy'. Data requests to another server http://api.domain-b.com/data.json will fail unless CORS is specifically setup in your web app. 

## Levels of access
There are three levels of cross-origin access:
```
No crossorigin attribute	
//-> default: access prohibited

crossorigin="anonymous" 	
//-> access allowed if the server responds with the header Access-Control-Allow-Origin with * or our origin. The browser does not send authorization information and cookies to remote server.

crossorigin="use-credentials" 
//-> access allowed if the server sends back the header Access-Control-Allow-Origin with our origin and Access-Control-Allow-Credentials is set to true. The browser sends authorization information and cookies to remote server.
```
## CORS Requests
The core concept here is origin: a domain/port/protocol triplet. If a request is cross-origin, the browser always adds the ORIGIN HEADER to it with the correct domain/port/protocol.

The server can inspect the Origin header and, if it agrees to accept such a request, adds a special header Access-Control-Allow-Origin to the RESPONSE with the allowed domain or *.

The browser plays the role of a trusted mediator here:
- it ensures that the correct Origin is sent with a cross-origin request.
- it checks for permitting Access-Control-Allow-Origin in the response before the script is granted access.

There is a difference between SIMPLE requests (GET, POST or HEAD) and non-simple requests. The practical difference is that simple requests are sent right away, with Origin header, while for the other ones the browser makes a preliminary 'preflight' request, asking for permission.

## CORS in ExpressJs
To allow CORS you can set the allowed origins in the http headers. You explicitly allow certain domains and all others are rejected, thereby preventing a cross site request forgery attack.

ExpressJs has the CORS package available that serves as middleware:
```
app.get('/', cors(), (req,res) => {})
```
See documentation for implementation details.