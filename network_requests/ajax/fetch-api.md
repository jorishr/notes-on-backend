# Fetch API
Table of contents
- [Fetch API](#fetch-api)
	- [About Fetch API](#about-fetch-api)
		- [Async/await example](#asyncawait-example)
		- [Promise example](#promise-example)
		- [Response processing methods](#response-processing-methods)
		- [Response headers](#response-headers)
		- [Request headers](#request-headers)
	- [Post requests](#post-requests)
	- [Form Data Object](#form-data-object)
		- [Example](#example)
	- [Track donwload progress](#track-donwload-progress)
	- [Fetch Options](#fetch-options)
		- [Referer](#referer)
		- [Referer policy](#referer-policy)

## About Fetch API
The browser starts the request right away and returns a PROMISE that the calling code should use to get the result.
```javascript
let promise = fetch(url, [options]);
```
Without options, that is a simple GET request, downloading the contents of the url. 

It is a TWO-STAGE process:
- The promise, returned by fetch, resolves with an object of the built-in Response class as soon as the server responds with headers. At this stage we can check HTTP status to see whether it is successful or not and we can check headers. But we don't have the body yet.
```
response.status	//-> HTTP Status code
response.ok		//-> true if HTTP-status is 200-299
```
- Access the response body by using an additional method call. We can choose only one body-reading method. If we've already got the response with `response.text()`, then `response.json()` won't work. The body content can only be processed once.

### Async/await example
```javascript
(async () => {
	let response = await fetch(url);		//-> promise
	if (response.ok) {
		let json = await response.json();   //-> response body
		let text = await response.text();
			//->fails,consumed already!
	} else {
  	console.log("HTTP-Error: " + response.status);
}
})();
```
### Promise example
```javascript
fetch(url)
.then((response) => response.json())
.then((jsonData){console.log(jsonData)})
.catch(err){console.log(err)};
```
### Response processing methods
```
response.text() 		
//-> read the response and return as text
response.json() 		
//-> parse the response as JSON
response.formData() 	
//-> return the response as FormData object
response.body 	
//-> a ReadableStream object, it allows you to read the body chunk-by-chunk

response.blob() 		
//-> return the response as binary data
response.arrayBuffer() 
//-> return the response as ArrayBuffer, a low-level representaion of binary data
```
### Response headers
The response headers are available in a Map-like headers object in `response.headers`.
```javascript
let response = await fetch('https://api.github.com/repos/javascript-tutorial/en.javascript.info/commits');

// get one header
console.log(response.headers.get('Content-Type')); 
//-> application/json; charset=utf-8

// iterate over all headers
for (let [key, value] of response.headers) {
  console.log(`${key} = ${value}`);
}
```
### Request headers
Most request headers are to ensure proper and safe HTTP, so they are controlled exclusively by the browser but could be set in the options:
```javascript
let response = fetch(protectedUrl, {
			headers: {
				Authentication: 'secret'}});
```
## Post requests
To make a POST request, or a request with another method, we need to use fetch options.
```javascript
let user = {
  name: 'John',
  surname: 'Smith'
};

fetch('<url>', {
	method: 'POST', 
	headers: {
		'Content-Type': 'application/json'
	}
	body: JSON.stringify(user)
	}
);
```
The data needs to be stored in the db as JSON, not a JS object. You can either code in as a JSON object directly or keep on using the JS notation inside a `JSON.stringify()` method.

The request body can be: 
- a string (e.g. JSON-encoded),
- FormData object, to submit the data as form/multipart,
- Blob/BufferSource to send binary data,
- URLSearchParams, to submit the data in x-www-form-urlencoded encoding, rarely used.

If the request body is a string, then Content-Type header is set to text/plain;charset=UTF-8 by default.

But, as we're going to send JSON, we use headers option to send application/json instead, the correct Content-Type for JSON-encoded data.


## Form Data Object
FormData object is the object to represent HTML form data. If the HTML form element is provided, it automatically captures its fields.

The special thing about FormData is that network methods, such as fetch, can accept a FormData object as a body. It's encoded and sent out with the request header `Content-Type: form/multipart`.
`let formData = new FormData([form]);`

### Example
```HTML
<form id="formElem">
  <input type="text" name="name" value="John">
  <input type="text" name="surname" value="Smith">
  <input type="submit">
</form>
```
```javascript
formElem.onsubmit = async (e) => {
	e.preventDefault();

	let response = await fetch('<url>', {
	method: 'POST',
	body: new FormData(formElem)
	});

 	let result = await response.json();

    console.log(result.message);
};
```

## Track donwload progress
To track download progress, we can use the `response.body` property as it has a `ReadableStream`, a special object that provides body chunk-by-chunk, as it comes. 

Readable streams are described in the Streams API specification.

See [Fetch progress](https://javascript.info/fetch-progress)


## Fetch Options
### Referer
Usually that header is set automatically and contains the url of the page that made the request. 

You may want to remove the referrer by setting it to empty string.
```javascript
fetch('<url>', {
	referrer: "" //-> no Referer header });
```
### Referer policy
The referrerPolicy option sets general rules for Referrer. By default FETCH always sends the Referer header with the full url of our page (except when we request from HTTPS to HTTP, then no Referer).

If you have an admin page that should not be visible to the outside world you may restrict the referrer policy to referrerPolicy: `origin-when-cross-origin` so that only the domain is visible, not the full page url.

Referrer policy is not just for fetch, but more global. In particular, it's possible to set the default policy for the whole page using Referrer-Policy HTTP header, or per-link, with `<a rel="noreferrer">`.