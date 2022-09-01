# Authentication options
Table of contents
- [Authentication options](#authentication-options)
  - [Options for user authentication](#options-for-user-authentication)
  - [Sessions versus tokens debate](#sessions-versus-tokens-debate)
    - [Why not to use JWT for Webapps?](#why-not-to-use-jwt-for-webapps)
    - [Security measures](#security-measures)

## Options for user authentication
Basically there are three main options:
- Session + PassportJs
- Custom solutions: JSON Web Tokens + Local Storage
- Third party API's: AuthO, OAuth2.0 (Open Standard), Firebase, etc. 

## Sessions versus tokens debate
Sessions are battle-tested for 20+ years and are not open to XSS attacks if cookies use the correct flags (http-only). They also do no contain any meaningful data that can be exploited.

Downside are:
- sessions needs to be secured against CSRF attacks
- all active sessions need to be stored on a server or cache manager which present scalability challenges
- possible single point of failure if all sessions are managed by a single server.
- sharing the data over multiple servers is challenging: see STICKY SESSION with load-balancing (horizontal scaling and Cross Origin Resources Sharing).
- cookies need to be enabled

JSON Web Tokens shine when apps use various servers on the back-end to separate their data. For example, a bank with a server for bank info and another server for retirement accounts: a user should be able to navigate through various sections with the same login session (CORS: cross origin resource sharing).

With JWT the user-info is stored on the client-side (browser) and if the same serialization key is used for both servers, the same token can be verified by both servers. 

Since JWT work across different servers you can move the entire authorization process to a separate server and thereby divide the workload. 

The server can identify a user by reading the token that is embedded inside the request, thus less database lookups.

The main advantages is big enterprise scaling.

Downside:
- unless the token is encrypted the user data embedded in the token is publicly available as it is only URL encoded. If the site is vulnerable to XSS cross-site-scripting attacks with JS malicious code injection, the tokens can be read and used to make malicious AJAX requests to server on behalf of the authorized user.
- the server still needs to track the active tokens somehow by blacklisting the old or expired tokens. This means that JWT actually are not entirely STATELESS. Usually the best way to handle this is with a WHITELIST of tokens, thus nobody gets access unless on the whitelist.
- data in the payload of a token can go out of sync with the server as it is cached, it goes stale.
- requires Javascript to be enabled as Client Storage is a JS API.

### Why not to use JWT for Webapps?
- server state needs to be maintained either way
- sessions are easily extended or invalidated
- with sessions data is secured on the server side and cannot leak through XSS (as http-only cookies are not accessible for JS)
- CSFR attacks are easier to mitigate
- user data is always in sync with the database

### Security measures
XSS always remains a concern:
- security headers must be set
- ssl/https is important

Auxiliary measures
- ip verification
- user agent verification
- two factor auth
- API throttling