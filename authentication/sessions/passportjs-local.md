# PassportJs
Table of contents
- [PassportJs](#passportjs)
	- [Reference guides:](#reference-guides)
	- [About PassportJs](#about-passportjs)
	- [Install and config](#install-and-config)
		- [Local strategy](#local-strategy)
			- [Configure PassportJs](#configure-passportjs)
	- [Authentication routes](#authentication-routes)
		- [Register new user](#register-new-user)
		- [Login existing user](#login-existing-user)
		- [Logout](#logout)
## Reference guides:
- [Master Auth](https://github.com/alex996/presentations/blob/master/node-auth.md)
- [Sessions + Redis](https://github.com/alex996/presentations/blob/master/express-session.md)
- [Basic auth setup](https://scotch.io/tutorials/easy-node-authentication-setup-and-local)

## About PassportJs
Passport is authentication middleware for Node.js. It is designed to serve a singular purpose: authenticate requests.
Three pieces need to be configured to use PassportJs for authentication: 
	
- (1) Authentication strategies: local, OAuth, or others. Before asking PassportJs to authenticate a request, the strategy (or strategies) used by an application must be configured. Traditionally, users log in by providing a username and password. With the rise of social networking, single sign-on using an OAuth provider such as Facebook or Twitter has become a popular authentication method as well.

- (2) Application middleware: Configure on which type of http requests you want the authentication to happen. This may not be necessary on all routes of the website.

- (3) Express-sessions: Express sessions handles the AUTHORIZATION process: make sure that the user that makes the request is the user that is logged-in. By default Express requests are sequential and no request can be linked to each other as HTTP is a stateless protocol. When EXPRESS SESSIONS is implemented, every user of your API or website will be 	assigned a unique encoded session id, and this allows you to store the user state (logged-in or not). PassportJS will interpret this info and establish a persistent login session. 

## Install and config	
The packages need are:
```
//for the local auth strategy 
//mongoose plugin for the user data model 

npm i --save passport, passport-local, passport-local-mongoose, express-session
```
With the Express sessions enabled users can be identified across http requests as 
all the requests to the app routes are now using sessions. 

### Local strategy
The local strategy does not depend on third party authentication providers and has a simple data model: 
- Define the user account model in a database: create a new collection in the database for USERS or ACCOUNTS. Export the User or Account constructor model and import it into the express app.js.
```javascript
const mongoose = require('mongoose');
const passportLocalMongoose = require('passport-local-mongoose');

let UserSchema = new mongoose.Schema({
	username: String,
	password: String
});

//Add the passport-local-mongoose plugin:
UserSchema.plugin(passportLocalMongoose, {<options>});

const User = mongoose.model('User', UserSchema);
```
Passport-Local-Mongoose will add a username, hash and salt field to store the username, the hashed password and the salt value. Additionally Passport-Local-Mongoose adds some methods to your Schema. See the API Documentation section for more details.

NOTE: this is similar to creating other datastructures with Mongoose. The only difference the use of the plugin.

#### Configure PassportJs
The order of statements is important:
```javascript
app.use(expressSession({}))
app.use(passport.initialize())
app.use(passport.session())

passport.use(new LocalStrategy(User.authenticate()));
passport.serializeUser(User.serializeUser());
passport.deserializeUser(User.deserializeUser());
```
First let ExpressJs initiate the sessions, then initialize Passportjs, and finally make PassportJs use express-session. Then define the auth strategy to use and which USER/ACCOUNT data model is used. End with User data serialization.
	
`SerializeUser` determines which data of the user object should be stored in the session. The result of the `serializeUser` method is attached to the session as `req.session.passport.user = {id: 'xyz'}`. Here we provide the user id as the key, but this can be any key of the user object i.e. name, email, etc.

In deserializeUser that key is matched with the in memory array / database (or any data resource). The fetched/retrieved object is attached to the request object as `req.user`.

## Authentication routes
There are three fundamental routes: register, login, logout. Additionally, there could be a profile page to update and delete user data.

### Register new user
The register GET route is simple: render a FORM. 

The register POST route stores the form data in the database by creating a new User, following the USER MODEL defined above.
```javascript
router.post('/register', (req,res) => {	
	User.register(new User({}), req.body.password, (err)=>{})
```
The `User.register` is a mongoose method which takes in two parameters and the callback function. First you call the User constructor and pass in the form data. Second is the password which is stored seperately. In the callback function you define what to do next, for example auto-login the new user or send a confirmation e-amil and redirect the user.

The form data can be accessed on the `req.body.<name>` and it is best to add VALIDATION and SANITIZATION to it first before storing it in the database.
```javascript
{
	username:	req.body.username,
	firstname:  req.body.firstName,
	lastname:   req.body.lastName,
	email:      req.body.email,
}
```
By default there is no usefull feedback for the user to see if the registering or login was succesfull or not, other than redirecting back to the form or to another page. You can amend that by passing the error message to page rendering where you add this dynamically through ejs: `if(err.message){//show some html}` or it could be handled by Flash messages if installed.
```
if(err){
	return res.render('register', {'error': err.message});}
```

### Login existing user
The GET route is again a simple redirection to a form. 

The post route includes AUTHENTICATION and redirection. The handler function is present but does not include any action by default. You can pass the error handling to ExpressJs:
```javascript
//router.post(route, authenticate, handler)
router.post('/login', passport.authenticate('local', {
    successRedirect: '/campgrounds',
    failureRedirect: '/login',
    failureFlash: true,
}), (req, res, next) => {
   		if(err){err.shouldRedirect = true; 
		return next(err);};	
	}
);
```
An alternative method would be to incorporate the authentication inside the handler. This can be used to auto-login on a route AFTER other action needs to be performed. The syntax is rather strange (currying), see PassportJS docs for details:
```javascript		
//		...
//		...
passport.authenticate('local')(req, res, function({	console.log('User logged-in successfully!')}));

res.redirect('/campgrounds');
```
### Logout
The logout is basically just a link/button with a GET route.
```javascript
router.get('/logout', (req, res) => {
	req.logout();
   	console.log('User logout success!');
	req.flash('success', 'Logged out successfully!')
   	res.redirect('/');
});
```