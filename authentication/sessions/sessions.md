# Express sessions
Table of contents
- [Express sessions](#express-sessions)
	- [About sessions](#about-sessions)
		- [Initiate a session](#initiate-a-session)
		- [The session object](#the-session-object)
		- [Session store](#session-store)
	- [Session options](#session-options)
		- [Secret](#secret)
		- [Cookie options](#cookie-options)
		- [Resave](#resave)
		- [Save uninitialized](#save-uninitialized)

## About sessions
HTTP requests are independent from each other and do not have information about previous requests made. Sessions are a way to identify users across various requests. 
### Initiate a session
A session is set up with a SECRET. A unique random string that belongs to your project. Do not store it in the app.js but use an environment variable.

Once setup, all the requests to the app routes are now using sessions. Every user of you API or website will be assigned a unique session, and this allows you to store the user state.
```javascript
const session = require('express-session');
app.use(session({
	secret: 'randomString',
	resave: false,
	saveUninitialized: false
}));
```
### The session object
The session data attached to each http-request is an object that can be accessed through `req.session`, `console.log(req.session)`. The session data is stored in memory by default. This is meant for development purposes only. 

For production you can store it in a database like MySQL or Mongo. A third option is to use a memory cache like Redis or Memcached.

All solutions store the session id in a cookie, and keep the full session data server-side. The client will receive the session id in a cookie, and will send it along with every HTTP request.

### Session store
In production, you'll need to set up a scalable `session-store;` 

See the list in the express-session docs. For MongoDB: `connect-mongo` package.

## Session options
### Secret
The session secret is a key used for signing and/or encrypting cookies set by the application to maintain session state.

Cookies are the most common way for web applications to persist state (like the currently logged in user) across distinct HTTP requests. To achieve this, web browsers will hang on to pieces of information that a web server wants to remember, dutifully sending it back with each subsequent request to remind the server that, for example, we are still logged in.

A malicious client could alter the cookie header before transmission, with unpredictable results. Thus servers SHOULD encrypt and sign the contents of cookies. A session secret that is not sufficiently cryptographically random can be guessed with fairly little time, effort and resources.
```javascript
app.use(expressSession({
	secret: process.env.EXPRESS_SECRET,
}));
```
### Cookie options
The example below has the default values. The `secure: true` is a recommended option. However, it requires an https-enabled website. If secure is set, and you access your site over HTTP, the cookie will not be set.

If both cookie options `expires` and `maxAge` are set in the options, then the last one defined in the object is what is used. The expires option should not be set directly; instead only use the maxAge option.

The `maxAge` options is the number (in ms) to use when calculating the `expires set-cookie` attribute. This is done by taking the current server time and adding maxAge milliseconds to the value to calculate an expires datetime. By default, no maximum age is set.
```javascript
app.use(expressSession({
	secret: process.env.EXPRESS_SECRET,
	cookie: { 
		path: '/', 
		httpOnly: true, 
		secure: false, 
		maxAge: null 
	}
}));
```
### Resave
This options forces the session to be saved back to the session store, even if the session was never modified during the request. Set it to false but check the session-store docs.

The best way is to check if it implements the touch method. If it does, you can safely set resave to false. If it does not implement the touch method and your store sets an expiration date on stored sessions, then you likely need `resave: true`.

### Save uninitialized
Forces a session that is "uninitialized" to be saved to the store. A session is uninitialized when it is new but not modified. Choosing false is useful for implementing login sessions, reducing server storage usage, or complying with laws that require permission before setting a cookie. 