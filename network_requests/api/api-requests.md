# API Requests
Table of contents
- [API Requests](#api-requests)
	- [About Restful API's](#about-restful-apis)
		- [Online directory of available API's](#online-directory-of-available-apis)
	- [API Data formats](#api-data-formats)
	- [API Endpoint URI's](#api-endpoint-uris)
	- [Request API data](#request-api-data)
		- [API Requests through NodeJs](#api-requests-through-nodejs)
		- [API Auhtentication](#api-auhtentication)
  
## About Restful API's
API is an Application Program Interface. The waiter that delivers the request from the client to the server in a specified format and returns information to the client in a specified format.

It structures the request-respons cycle.

### Online directory of available API's
See [Programmable Web](https://www.programmableweb.com/).

## API Data formats
XML: Extended Markup Language. Holds key-value pairs in `<key>value</key>` format.

JSON: Javascript Object Notation. Holds key-value pairs into objects with everything stored as a string:
`{"key": "value"}`

You can use the Chrome Extension JSON viewer to inspect API data in more readable color-coded format.

## API Endpoint URI's
Endpoints are the URL/URI of resources on the service that can be accessed by the client application through the formatting provided by the REST API.

The URI is a uniform resource identifier. The identifier can be a name or location, or both. URL is uniform resource locator, thus a subset of URI. A server resource can be identified by its name and/or its location on the server.

## Request API data
Check the documentation for each API to see which type of data you are working with: an array, an object, an array of objects.

When requesting data from a server you usually receive the data as a string. To convert it into a javascript object, use JSON.parse().

Requests can be made through a direct link in the browser and structuring the data with a Chrome extension such as JSON viewer.

### API Requests through NodeJs
Use the npm packages: 
`npm install --save request request-promise`

The request package can be used to create a js file to run api requests or to incorporate it into an Express app.

Two syntaxes are available: using a callback function or using ES6 Promises.
```javascript
request(url, function(error, response, body){})
	
rp(url).then((body) =>{}).catch((err) =>{})
```
The data from the server reponse has a HEADER and a BODY, just as the http request to the server. To access the data we need to look into the BODY.
 
### API Auhtentication
Through clientId and tokens. See documentation for each API. You basically add a token string to each HTTP request that identifies the client.