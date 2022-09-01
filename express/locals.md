# Locals in ExpressJs
## Express or app.locals
If you configure the object `app.locals` the key-value pairs persist throughout the life of the application and accessible on every route.

This is similar to the `res.locals` object properties that are valid only for the lifetime and scope of the request. They are available only to the view(s) rendered during that request / response cycle (if any).

You can access local variables in templates rendered within the application. This is useful for application-level data (names, titles, etc.) and helper functions (moment-js). 

## Example
Make moment-js functions available on all views: 
```javascript
app.locals.moment = require('moment'); 
```
In the view file:
```HTML
<%= moment(campground.createdAt).fromNow() %> 
```
Local variables are available in middleware via `req.app.locals` thus inside a middleware function you can write:
```javascript
let month = req.app.locals.moment().month("January");
```