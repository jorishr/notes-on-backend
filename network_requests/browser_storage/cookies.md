# Cookies
Table of contents
- [Cookies](#cookies)
	- [About Cookies](#about-cookies)
	- [Read and write cookies](#read-and-write-cookies)
	- [Cookie options](#cookie-options)
		- [Path](#path)
		- [Domain](#domain)
		- [Expiration](#expiration)
		- [Secure](#secure)
		- [Same site](#same-site)
		- [Lax mode](#lax-mode)
		- [HTTPONLY](#httponly)
	- [Third party cookies](#third-party-cookies)
	- [GDPR Compliance](#gdpr-compliance)

## About Cookies
Cookies are small strings of data that are stored directly in the browser. They are a part of HTTP protocol. Cookies are usually set by a web-server using the response header: `Set-Cookie HTTP-header`. The browser automatically adds them to (almost) every request to the same domain using Cookie HTTP-header.

It is recommended to use a cookie library as the default js functionality is limited.

See [JS-Cookie](https://github.com/js-cookie/js-cookie).


## Read and write cookies
Cookies can be accessed through: 
```javascript
document.cookie
console.log(document.cookie)
```
The value of `document.cookie` consists of a string of name=value pairs, delimited by ;. Each one is a separate cookie.

When adding key-value pairs they all go into one string seperated by `;` and expiration dates need to be in the UTC string format. Each new instance of `document.cookie` creates a new cookie. To never expire, set a data far into the future.
```javascript
document.cookie = 'name=John; expires=' + 'new Date(2020, 1, 1).toUTCString()'
document.cookie = 'name=Eddy; expires=' + 'new Date(9999, 1,1).toUTCString()'
```

## Cookie options
### Path
Set path to the `root: path=/` to make the cookie accessible from all website pages. If set to `path=/admin` the cookie is only visibile at that page and its subroutes.

### Domain
By default, a cookie is accessible only at the domain that set it. Though not at subdomains. To include the subdomains explicitly set the domain option to: 
`document.cookie = "user=John;email=john@doe.com;domain=site.com"`

### Expiration
By default a cookie disappears when the browser is closed as it is a session cookies. To let cookies survive browser close, we can set either set the expires or max-age option.
```javascript
const date = new Date(Date.now() + 86400e3); 	
//-> 1 day in ms

const date = date.toUTCString();		
//-> correct format
document.cookie = "user=John; expires=" + date;
```
Max-age is an alternative to expires and specifies the cookie expiration in seconds from the current moment. If zero or negative, then the cookie is deleted.
`document.cookie = "user=John; max-age=0";` (->delete cookie now).

### Secure
Cookies are domain-based, they do not distinguish between the protocols and will work on both https or http. To only restrict the use to https use the secure option.
`document.cookie = "user=John; secure; expires=" + date;`

### Same site
This option is a protection measure against cross site request forgery attacks but has one major drawback: it is not supported by old browsers, year 2017 or so. A cookie with `samesite=strict` is never sent if the user comes from outside the same site. This method is reliable but has consequences for user experience as a correct url initiated from outside the browser will not work.

### Lax mode
Lax mode, `samesite=lax`, forbids the browser to send cookies when coming from outside the site, but adds an exception.It allows the most common 'go to URL' operation to have cookies, as long as it is a safe http method (GET but not POST). For example, opening a website link from notes satisfies these conditions.

### HTTPONLY
This option forbids any JavaScript access to the cookie. We can't see such cookie or manipulate it using `document.cookie`.That's used as a precautionary measure, to protect from certain attacks when a hacker injects his own JavaScript code into a page and waits for a user to visit that page. That shouldn't be possible at all in the first place.

## Third party cookies
When visiting page.com a banner may be loaded from an external source ads.com. That external site also sets a cookie and when that ads.com is visited through another website or directly, the server of ads.com receives that cookie with an id that identifies the user and a part of his browsing history.

Some modern browsers employ special policies for such cookies and some can block them entirely.

If we load a script from a third-party domain, like `<script src="https://google-analytics.com/analytics.js">`, and that script uses `document.cookie` to set a cookie, then such cookie is not a third-party.

If a script sets a cookie, then no matter where the script came from the cookie belongs to the domain of the current webpage.


## GDPR Compliance
GDPR enforces a set of rules for websites to respect user's privacy. And one of such rules is to require an explicit permission for tracking cookies from a user. Note, that's only about tracking/identifying/authorizing cookies. Thus if we are going to set a cookie with an authentication session or a tracking id, then a user must allow that.

If we set a cookie that just saves some information, but neither tracks nor identifies the user, then we are free to do it. 

Usually there are two scenarios:
- if a website wants to set tracking cookies for everyone, a modal will be used to require newcomers to agree.
- if a website wants to set tracking cookies only for authenticated users, there is a checkbox upon signup.