# Password reset with Mailgun
Table of contents
- [Password reset with Mailgun](#password-reset-with-mailgun)
	- [Example](#example)
	- [Packages](#packages)
	- [User data model](#user-data-model)
	- [Routes](#routes)
	- [Token generation and sending email](#token-generation-and-sending-email)
		- [Reset route](#reset-route)
		- [Update password route](#update-password-route)

To help users restore their password in you need the capability to send emails from your server. 

## Example
To test a working example see [Catacamp](catacamp.jorisr.com). To see the code on Github go to: [yelp-camp](https://github.com/jorishr/yelp-camp)

## Packages
- Require in CRYPTO which is part of NodeJS to generate tokens
- Mailgun is a transactional Email API that enable you to send, receive, and track emails.
```
npm i -S mailgun
```
```javascript
const crypto  = require('crypto')
const mailgun = require('mailgun-js');
```

## User data model
Add the properties `resetPasswordToken (String)` and `resetPasswordExperis(Date)` to the User model. They are not part of a newly created document, because they are set only after a password reset request is submitted. Since we haven't specified default values, those properties will not be set when creating a new user. But they have be forseen your data model.

## Routes
There are four routes in the password reset process:
1. GET request to render the forgot password form
2. Post request to generate a token, send an email to the user (Mailgun code) and render a message on the page that an email has been sent.
3. GET request to render the reset form with the token received in the email
4. POST request to actually update the password in the database

## Token generation and sending email
The sequence of async code is provided by MAILGUN. First the Nodejs package CRYPTO is used to generate a token. 

Next you have to find the user email in your database. If the record exists, then you add the token to the `foundUserObject` together with an expiration date. Save that new record in the databse.

Next you have the MAILGUN configuration where you can configure the email message.

Important is where the email link will send the user to when he clicks on the token. The route is: `/reset/:token`. The url is constructed as: `http://${req.headers.host}/reset/${token}`.

### Reset route
The reset route is thus `/reset/:token`.First look up the user in the db with a corresponding token and check if the token expiration is greater than now. If that is correct you render the RESET FORM and pass along the token. 

If the token has expired or the user has no token REDIRECT:
```javascript
User.findOne({
    resetPasswordToken: req.params.token, 
    resetPasswordExpires: {$gt: Date.now()}
})

res.render('users/reset', {token: req.params.token});
```

### Update password route
The form that is rendered will have two fields: password and confirm. Both have to match! If not the form will rendered again. Again, first look up the user in the db with a corresponding token and check if the token expiration is greater than now. If that is correct write the new password to the database and reset the tokens to undefined. Optional: auto-login the user.
```javascript
if(req.body.password === req.body.confirm){
   	foundUser.setPassword(req.body.password, (err) => {
		foundUser.resetPasswordToken   = undefined;
		foundUser.resetPasswordExpires = undefined;
		foundUser.save((err) => {
			req.logIn(foundUser, (err) => {
				cb(err, foundUser);
			})
		})
   })
}
// When that is done, you can also repeat the Mailgun code for sending a confirmation email about the process of password restoration
```