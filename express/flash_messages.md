# Flash messages
Table of contents
- [Flash messages](#flash-messages)
	- [Connect-flash](#connect-flash)
	- [Flash message on all routes](#flash-message-on-all-routes)
## Connect-flash
Npm package: `npm install --save connect-flash`

The `app.use(flash());` needs to come before the PassPortJs config statements.On the middleware incorporate a success/error flash statement BEFORE the redirect statement:
```javascript
req.flash('error', '<message>');
res.redirect('/page')
```
This does not actually display the message. You have to pass the flash message as an object to the next html file that will be rendered. On the route '/page' you add:
```javascript	
router.get('/page', (req, res) => { 
	res.render('page', {
		message: req.flash('error')
})})
```
## Flash message on all routes
To make the flash message available on ALL routes:
```javascript	
app.use((req, res, next) => {
	res.locals.currentUser = req.user;
	res.locals.error = req.flash('error');
	res.locals.success = req.flash('success');
	next();
});
```
In the HTML for 'page' you can now add:
```	
if(message && message.length > 0)
<h2><%= message %></h2>
```
And later style it the way you want it or use Bootstrap Flash message support.
```HTML
<div class="alert alert-success alert-danger" role="alert">
```
Best practice is to reserve space in the header.ejs for this purpose. This way all flash messages will show up in predictable manner regardless of the page content.