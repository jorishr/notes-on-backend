# Input validation and sanitization
Table of contents
- [Input validation and sanitization](#input-validation-and-sanitization)
	- [Input validation](#input-validation)
		- [Validation methods](#validation-methods)
		- [Implementation](#implementation)
	- [Sanitization of input data](#sanitization-of-input-data)
	- [Cross site scripting attack](#cross-site-scripting-attack)

## Input validation
The best way to handle validating any kind of input coming from outside in Express is by using the EXPRESS-VALIDATOR package.
```javascript
const { check } = require('express-validator/check')
```
### Validation methods
The validation methods are plenty and can be found in the docs of VALIDATOR JS, a library of string validators and sanitizers. You can also validate the input against a REGULAR EXPRESSION using the javascript native `matches()` method. 

### Implementation
```javascript
app.post('/form', [
	check('name').isLength({ min: 3 }),
	check('email').isEmail(),
	check('age').isNumeric()
], (req, res) => {
	const name = req.body.name
	const email = req.body.email
	const age = req.body.age
})

//You can pipe check() various method:

check('name').isLength({min:3, max:10}).isAlpha('nl-NL');

//Set custom error message:

check().isAlpha.withMessage('Must be only alphabetical chars');
	
check().isLenght.withMessage('Must be at least 10 chars long')

/*
Custom validator:
In the callback function you can reject the validation either by throwing an exception, or by returning a rejected promise:
*/
app.post('/form', [
	check('name').custom(cb)

.custom(name => {
	if(condition){throw new Error('custom error')}
})

//or 

check('email').custom(email => {
	if (alreadyHaveEmail(email)) {
		return Promise.reject('Email already registered')
```

## Sanitization of input data
There are two approaches: one is to add the sanitization methods on top of the validation methods using the same EXPRESS-VALIDATION PACKAGES.
```javascript
check('email').isEmail().normalizeEmail()
check('name').isLength({}).trim().escape()
```
Whereby `trim()` trims characters (whitespace by default) at the beginning and at the end of a string. Escape `escape()` replaces < , > , & , ' , " and / with their corresponding HTML entities.

The other way is tp sanitize the entire `req.body` element using EXPRESS_SANITIZER package, whereby you set the `req.body` object to be a sanitized version of it before calling database operation methods.
```javascript
cosnt sanitizer = require('express-sanitizer'),

req.body.blogPost.body = req.sanitize(req.body.blogPost.body);

BlogPost.create(req.body.blogPost, (err, savedData) => {})
```
See docs of both packages for more details.

## Cross site scripting attack
When using `.innerHTML` on user input, switch to `.innerText`. Or you need to pass that into a string first. So that `<img src onerror="<mailicious code>">` gets rendered a string.