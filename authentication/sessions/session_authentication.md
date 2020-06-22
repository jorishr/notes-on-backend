# Session authentication in ExpressJs
Table of contents
- [Session authentication in ExpressJs](#session-authentication-in-expressjs)
	- [Authentication and authorization](#authentication-and-authorization)
		- [Scheme](#scheme)
		- [State](#state)
	- [Sessions authentication](#sessions-authentication)
		- [Process overview](#process-overview)
		- [Statefulness](#statefulness)
		- [Session id and cookies](#session-id-and-cookies)
		- [Example](#example)
		- [Security concers](#security-concers)
## Authentication and authorization
There is authentication: verify IDENTITY, check whether the user is who he claims to be. (401 Unauthorized)

Authorization: verify PERMISSIONS, whether an authenticated user can performs the action he wants to do.(403 Forbidden)

### Scheme
Authentication schemes can either be a username/password scheme, a certificate sheme or token based scheme. 

### State
Statefull authentication is done with sessions and cookies.

Stateless authentication with JWT, OAuth or others.

## Sessions authentication
### Process overview
The user submits credentials (username + password) to the server and the server checks credentials against a database. 

The server creates a SESSION and sends a COOKIE with a session id. Upon each subsequent http request the client attaches that cookie to the request. 

The server VALIDATES the cookie against the SESSION STORE and grants appropriate access (authorization).

When a user logs out, the server destroys the session (id) and clears the cookie.

### Statefulness
Each session that is created has an ACTIVE state that needs to be STORED in either MEMORY (file system of the server), a DATABASE or CACHE (e.g. Redis).

### Session id and cookies
The session ID is an OPAQUE REFERENCE as it does not contain any meaningful data, it's a random string. Only the server can relate that session ID or string to the user data.

The random string stored in a cookie is usually SIGNED with a SECRET KEY. Therefore the CLIENT/USER cannot tamper with the cookie. Additionally the cookies can be protected with server side FLAGS.

There are no real security concerns with a signed cookie. It doesn't need addtional encryption because it does NOT contain meaningfull data.

Cookies are send with each HTTP request in the header just like content-type or authorization.

Each cookie has key(name)-value pairs and can also contain attributes or flags. There are set in the browser through Set-Cookie by the server.

### Example
Example Header of an http response:
```
HTTP/1.1 200 OK
Content-type: text/html
Set-Cookie: sessionID=randomString; Domain=example.com; Path=/ 
```
In a http request by the user the cookie is set in the cookie header.

Attributes: DOMAIN and PATH restrict the use to a domain and for each route on that domain. An expiration date can be set manually if not it becomes a SESSION cookie, thus removed when the browser window is closed.

Flags: 'HttpOnly' means the cookie cannot be read through JS on the client-side, making them unreachable for XSS attacks. The 'Secure' flag means the cookie can only be send over a HTTPS connection. The 'SameSite' flag means the cookie can only be sent from the same domain (no CORS sharing).

### Security concers
Cross Site Request Forgery can be a problem for sessions. You can have unauthorized action by a authenticated user. This problem can be mitigated a seperate X-CSFR-token.