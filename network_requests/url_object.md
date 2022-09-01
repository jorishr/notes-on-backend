# URL Objects
There are no networking methods that require exactly an object as Uniform Resource Locator. The URL object can be passed to any method instead of a string, as most methods will perform the string conversion that turns a URL object into a string with full URL.

In Javascript there is a URL constructor function: `const url = new URL(url, [base]);`

The base URL is optional: if set and url argument has only path, then the URL is generated relative to base.

`const url = new URL('/info', 'https://goudster.be')`

When created with URL class constructor you get access to its components:
```
url.protocol;	//-> 'https'
url.host;		//-> 'goudster.be'
url.pathname;	//-> '/info'
url.port;		//-> '' or '8080'
url.search;	    //-> string of parameters, starts with ?
url.hash;		//-> starts with hash character #
```

## Search parameters
You can set search parameters in a url string or use `.searchParams.set()` method. Example: `https://www.google.com/?q=look+up+this`
```javascript
const url = new URL('https://www.google.com')
url.searchParams.set('q', 'look up this');
url.search;	    //-> '?q=look+this+up'
url;			
//-> 'https://www.google.com/?q=look+this+up'
```
## URL Encoding
There's a standard RFC3986 that defines which characters are allowed in URLs and which are not. Those that are NOT allowed, must be encoded. For example, non-latin letters and spaces are replaced with their UTF-8 codes, prefixed by %, such as %20.

The good news is that URL objects handle all that automatically. We just supply all parameters unencoded, and then convert the URL to string. If we use a string though, we need to encode/decode special characters manually:
```javascript
//For the entire url use encodeURI method: 
const url = encodeURI('http://site.com/??????');
// for searchParams only use encodeURIComponent
const music = encodeURIComponent('Rock&Roll'); 
const url = `https://google.com/search?q=${music}`;
```