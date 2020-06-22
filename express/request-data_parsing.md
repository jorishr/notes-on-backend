# Request data parsing
Table of contents
- [Request data parsing](#request-data-parsing)
	- [Raw request data](#raw-request-data)
	- [Body parser methods](#body-parser-methods)
## Raw request data
The raw data from the header and body is not very convenient to work with as it is not accessible through the request root object (`req.body`) by default. You would have to write specific code to access each property. To simplify this process you can use the package BODY-PARSER.

Body-parser is middleware that extracts the entire body portion of an incoming request stream and exposes it on `req.body` object as something easier to interface with. 

Only after setting the `req.body` to the desirable contents will it call the next middleware in the stack, which can then access the request data without having to think about how to unzip and parse it.

For comparison; in PHP all of this is automatically done and exposed in $_POST.

## Body parser methods 
The method `bodyParser.urlencoded()` parses the text as URL encoded data (which is how browsers tend to send form data from regular forms set to POST) and exposes the resulting object (containing the keys and values) on the `req.body` object. This parser accepts only UTF-8 encoding of the body.

The `req.body` object will contain key-value pairs, where the value can be a string or array when the extended option is set to false. Or any data type when extended option is set to true.

The `bodyParser.json()` method accepts any type of Unicode encoding of the body and parses the text as JSON and exposes the resulting object on `req.body`.

The body parser of your choice needs to be configured in the express app.
```javascript
app.use(bodyParser.urlencoded({extended: true}));
// or
app.use(bodyParser.json());
```	