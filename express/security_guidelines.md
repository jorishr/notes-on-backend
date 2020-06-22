# Basic securiy measure in ExpressJs
Table of contents
- [Basic securiy measure in ExpressJs](#basic-securiy-measure-in-expressjs)
  - [Secure HTTP headers with Helmet](#secure-http-headers-with-helmet)
  - [Cookie protection](#cookie-protection)
  - [User input validation and sanitazation](#user-input-validation-and-sanitazation)
## Secure HTTP headers with Helmet
Helmet is a collection of 13 middleware functions for setting HTTP response headers. In particular, there are functions for:
- setting Content Security Policy, 
- handling Certificate Transparency, 
- preventing clickjacking, 
- disabling client-side caching, 
- or adding some small XSS protections.

The minumym is to disable the `X-Powered-By header` which can be used to detect that the app is running on express.
```javascript
app.disable('x-powered-by') 
```
## Cookie protection
See notes on cookie: [Cookies](../network_requests/browser_storage/cookies.md)
## User input validation and sanitazation
See notes on validation and sanitization: [Validation and sanitization](../input_validation_and_sanitization.md)