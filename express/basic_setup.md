# ExpressJs Server Framework
Table of contents
- [ExpressJs Server Framework](#expressjs-server-framework)
	- [Basic setup](#basic-setup)
		- [NPM dependencies](#npm-dependencies)
	- [Express generator](#express-generator)
	- [MVC: View](#mvc-view)
		- [Template engines](#template-engines)
			- [React](#react)
			- [Embedded Js](#embedded-js)
			- [Optional virtual path prefix](#optional-virtual-path-prefix)
	- [Database connection setup](#database-connection-setup)

## Basic setup
### NPM dependencies
```bash
npm install --save
	ejs 			# view engine
	body-parser 	
	request request-promise
	method-override	
	# to account for put & delete requests in HTML form method attribute
```
In an app.js file, write the server code:
```javascript	
// require in the packages and setup (local) server, path is NodeJs package
const 
	path 	= require('path'), 
	express = require('express'),
	app 	= express(),
	port	= portNumber;
	
app.listen(port, () => 
	console.log(`Example app listening on port ${port}!`)
	);

// Set the static folder path. If you don't use a view engine and just serve plain html also indicate where the views directory is located.
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.static(path.join(__dirname, 'app/views')));
	
// use the BodyParser package to make the body data available as a JS object in `req.body`
app.use(bodyParser.urlencoded({extended: true}));

// set the views folder path and view engine
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
```
## Express generator
Automate the above with the generator.Specify the view engine, the css stylesheet engine, and gitignore file.

`npx express-generator --view=<engine> --css=sass --git <dir>`

NOTE: the --css flag can be omitted because the sass compilation within node /express is created for dev use only. 	Use Gulp or Webpack to handle that task. 	
The view files and basic server is pre-configured to run on `localhost:3000`.

## MVC: View
Express is capable of handling SERVER-SIDE TEMPLATE ENGINES. Template engines allow us to add data to a view, and generate HTML dynamically. A template engine enables you to use static template files in your application. At runtime, the template engine replaces variables in a template file with actual values, and transforms the template into an HTML file sent to the client. 

### Template engines
#### React
You can render a React application server-side, using the `express-react-views package`. 
```javascript
app.set('view engine', 'jsx');
app.engine('jsx', require('express-react-views').createEngine());

// in the views folder you have the .jsx files that get rendered when you call them:
app.get('/page', (req,res) => {res.render('jsx-page')});
```
#### Embedded Js
Express will look in the `./views` folder for ejs files to render. Once specified the view-engine, you can leave out the ejs extension.

Inside the EJS you can use plain HTML and JS with variables and function that hold and use data from the database.
```javascript
<%= 'javascript-here' %>	
// gets rendered on the html page
<%	%>	// no output in html
<%-	%>	// outputs the unescaped value 
```	

### Code organization
In the views folder create a subfolder partials. This will contain a `header.ejs` and `footer.ejs`. Just as in Wordpress you include those in the individual pages that are being rendered. This way you don't have to always include manually the doctype, the script tags and css link tags (except for a landing page that may have different functionality).

To include in the page files:
```
<% include partials/_header %>
<% include partials/_footer %>
```
NOTE: Use an absolute path for the css link tag "/main.css" in these partial files.

### Serving static files
Static files can be loaded by using `express.static` and specifying the root directory of those files.
```javascript
app.use(express.static('root', [options]))
app.use(express.static('.', [options]))
app.use(express.static('./images', [options]))
```
Express looks up the files in the order in which you set the static directories with the express.static middleware function. You can then load those files from the browser:
```
http://localhost:3000/index.html
http://localhost:3000/images/dog.jpg
```
By default Express looks for folders relative to the NPM root folder of the app. If you want to run the express app.js from another folder use PATH:
```javascript
app.use(express.static(path.join(__dirname, 'public')));
```
A common folder structure is to use a "public" folder where the main html, css and image files live.

#### Optional virtual path prefix
You can add a path that does not actually exist in the file system to hide the real location of your files.
```javascript
app.use('/dummy', express.static('public', [options]))
// -> `http://localhost:3000/dummy/index.html`
```
## Database connection setup
See docs for MongoDB/Mongoose or MySQL/Serialize.

What you need to do in express is establish a connection with the database. For MongoDB this is done with the MONGOOSE package:
```javascript
mongoose.connect(process.env.DB_CONN,{useNewUrlParser: true});
	
db.on('error', console.error.bind(console, 'connection error:'));
```
The environment variable is stored in the .env file. Or you can simply use a string with the URL of the DB.