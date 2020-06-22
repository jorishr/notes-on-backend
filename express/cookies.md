# Managing cookies in ExpressJs
Parse the COOKIE header and populate `req.cookies` with an object keyed by the cookie names.

Since version 1.5.0, the cookie-parser middleware no longer needs to be used for this module to work. This module now directly reads and writes cookies on req/res. 

Using cookie-parser may result in issues if the secret is not the same between this module and cookie-parser. Thus, cookieparser is no longer needed when using express-session.

## Response object
The `res.cookie()` method will set, manipulate or clear cookies.
```javascript
res.cookie('username',  'joris', {options})
res.clearCookie('username')

//options:
{
	expires: new Date(Date.now() + 900000), 
	httpOnly: true,
	secure: true
}

//if no expiration is set the cookie is a session cookie

//maxAge: set the expiry time relative to the current time, in ms

//path: the cookie path. Defaults to /

//secure: https only

//signed: set the cookie to be signed

//httpOnly:	only accessible by the server, not client-side js