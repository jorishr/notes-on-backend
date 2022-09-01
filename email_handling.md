# Email handling
Table of contents
- [Email handling](#email-handling)
	- [Sending / receiving email](#sending--receiving-email)
		- [Send feedback to the user by email](#send-feedback-to-the-user-by-email)
		- [User form data to email (contact form)](#user-form-data-to-email-contact-form)
	- [HTML Emails](#html-emails)
	- [HTML templates with Express](#html-templates-with-express)
		- [Express configuration](#express-configuration)
		- [HTML styling in email clients](#html-styling-in-email-clients)
		- [MJML: Mailjet Markup language](#mjml-mailjet-markup-language)
		- [Template example in React](#template-example-in-react)

Email is wide topic with a lot of potential issues. You'll have to vet and rely upon good third party solutions.

## Sending / receiving email
### Send feedback to the user by email 
See video tutorial: [Responsive HTML Email with Node.js - Send Rich, Responsive HTML Emails Using Ink, Yeoman & Express](https://www.youtube.com/watch?v=FrB8mxdWR7o)

### User form data to email (contact form)
See video tutorial: [Submit a form and receive email - Express + Nodejs + Nodemailer + MailGun
](https://www.youtube.com/watch?v=JpcLd5UrDOQ)

Add data validation to it to prevent spam (captcha?)

## HTML Emails
There are lot's of different EMAIL clients that handle html in a different way. This means we cannot simply send html + css files. It will have to be compiled into one single message.

You could handle everything yourself with your own mailserver but that needs to be maintained and is harder to scale. Mailgun and Sendgrid are the most popular options.

## HTML templates with Express
Template languages you can use are ejs, mustache, underscore or handlebars.

The HTML template is a separate file that will be rendered by the EXPRESS server and gets passed into it the variables (data-object) you specify there.

### Express configuration
Important consideration: When using `send.render()` in a get or post request the ejs template gets rendered upon each requests. This puts load onto the server, which is fine for showing pages. But for email templates this is not necessary. You can compile the ejs code upon sever start-up just once, not every time a users signs up or asks for a password reset.

You can do a manual compilation upon start-up and keep that code out of the post/get requests.
```javascript
let mailTemplate = fs.readFileSync(
	'/views/email/mail.ejs', 'UTF-8');
let compiledMailTemplate = ejs.compile(mailTemplate);

//iIn the post/get request Mailgun/Sendgrid

html: compiledMailTemplate.render({dataObject_to_add})
```
### HTML styling in email clients
You cannot use classes nor the style element. Everything has to be written as inline style which is hard to maintain and a pain to write. The solution is to use an inline compiler that allows you to write CSS in a separate CSS file and use GULP to run a task that converts everything into one template file with inline styles defined.

A good example of this approach is ZURB-INK, with `generator-zurb-ink` (requires bower package manager).

### MJML: Mailjet Markup language
MJML tags are high-level components that will be translated into responsive HTML by the MJML engine.

### Template example in React
See blog post: [responsive-emails-in-react-and-mjml](https://medium.com/@mateuszsiara/responsive-emails-in-react-and-mjml-8a861668047)