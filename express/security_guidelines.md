# Basic security measure in ExpressJs
Table of contents
- [Basic security measure in ExpressJs](#basic-security-measure-in-expressjs)
  - [Secure HTTP headers with Helmet](#secure-http-headers-with-helmet)
  - [Cookie protection](#cookie-protection)
  - [User input validation and sanitization](#user-input-validation-and-sanitization)
## Secure HTTP headers with Helmet
Helmet is a collection of 13 middleware functions for setting HTTP response headers. In particular, there are functions for:
- setting Content Security Policy, 
- handling Certificate Transparency, 
- preventing click-jacking, 
- disabling client-side caching, 
- or adding some small XSS protections.

The minimum is to disable the `X-Powered-By header` which can be used to detect that the app is running on express.
```javascript
app.disable('x-powered-by') 
```
## Cookie protection
See notes on cookie: [Cookies](../network_requests/browser_storage/cookies.md)
## User input validation and sanitization
See notes on validation and sanitization: [Validation and sanitization](../input_validation_and_sanitization.md)