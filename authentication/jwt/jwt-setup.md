# JWT in ExpressJs
Table of contents
- [JWT in ExpressJs](#jwt-in-expressjs)
	- [Reference example](#reference-example)
	- [Pre-limimary steps](#pre-limimary-steps)
	- [Initiate a JWT upon log-in](#initiate-a-jwt-upon-log-in)
	- [Authorization middleware](#authorization-middleware)

## Reference example
For a working example see my github: [JWT-Authorization](https://github.com/jorishr/jwt-authorization)
## Pre-limimary steps
- Basic express setup.
- Basic route setup for API
- Basic authentication setup (with login/logout)
- Get the username form `req.body.username`
- create an authorization middleware function

## Initiate a JWT upon log-in
Inside the LOGIN ROUTE:
- get the username from `req.body.username` to create a user object
- this user object is serialized as the payload with JWT, using the `TOKEN_SECRET` stored as environment variable.
- store the result in a variable as the accesstoken
```javascript
const accessToken = jwt.sign(user, TOKEN)
res.json({accessToken: accessToken});
```
Thus now each time user is logged-in correctly an accessToken is generated which has the user data stored inside it for future reference.

## Authorization middleware
Create a function that can be applied as middleware to various protected routes.
- get the JWTtoken, verify it and return that verified user
- the JWT token is available in the headers and is stored after the keyword: `Bearer`
- the `req.headers['authorization']` is a string we split into an array of substrings, where we access the second value [1]:
```javascript
const authHeader = req.headers['authorization']
const token = authHeader && authHeader.split(' ')[1];
```
- then first check if there is and `authHeader`
- if there is none, send an error message
- if there is one, verify it with the `SECRET TOKEN`:
The verify function has callback `(err, user)`: 
```javascript
/*
if the verification fails, inform user about invalid token (403) 
if verification is a success, set the req.user to the deserialized user object.
*/
if(token == null){ return res.sendStatus(401) };
jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {
    if(err) return res.sendStatus(403);
    req.user = user; 
}    
// move on with next() middleware
/*
On the PROTECTED ROUTE you can now access access the authorized user object req.user = user and use it, for example, as a filter.
*/
app.get('/posts', authorizeUser, (req, res) => {
	res.json(posts.filter(post => post.username ===	req.user.name));
});
```