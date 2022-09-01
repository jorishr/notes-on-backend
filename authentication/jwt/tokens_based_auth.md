# JSON Web Tokens
Table of contents
- [JSON Web Tokens](#json-web-tokens)
  - [About JWT](#about-jwt)
  - [Examining JWT](#examining-jwt)
  - [Refresh tokens](#refresh-tokens)
  - [Stateless vs stateful](#stateless-vs-stateful)
    - [Traditional stateless approach](#traditional-stateless-approach)
    - [Stateful JWT](#stateful-jwt)

References:  
- [jwt.io](https://jwt.io/)
- [Mastering Auth](https://github.com/alex996/presentations/blob/master/auth.md)

## About JWT
JSON WEB TOKEN is an open source standard for authorization and info-exchange.

It is compact, self-contained and URL-safe and signed with a SIGNATURE that is either SYMMETRIC (secret) or a public/private key pair, thus ASYMMETRIC. 

It is not encrypted as the client-side needs to be able to access the payload data, thus there is no secure way to store the token on the client side. No sensitive data should be stored in the JWT (no passwords for example). 

When a request is made by the user, the server verifies the JWT token it has signed itself earlier. If correct, it can deserialize the token and access the user-info.

Tokens should be short-lived. Since they cannot be stored securely, they have to be refreshed at an interval.

## Examining JWT
```
'HTTP/1.1 200 OK
Content-type: application/json
Authorization: Bearer
eyffsfsskdfjsslsjfsls.eyddfsfpskpfpwpeweepw.eopwweopwpoeopwopoe'
```
The token has three parts separated by a `.`: 
- header (metadata), 
- payload (claims or data-attributes), 
- and signature. 

The token is URL ENCODED thus you can use the ATOB function in javascript to decode the content. Note that if the token starts with 'ey' you can infer it contains JSON data object as 'ey' in url encoding refers to "{".
```javascript
atob(`token-header`);		
//-> {"alg":"HS256", "typ": "JWT"}
atob(`token-payload`);	
//-> {"sub":"", "name":"", "iat": , "exp":""}
```
The payload consist of:
- a subject, usually the user id; 
- other claims or data-attributes such as username; 
- issued at 'iat': in seconds
- when the token expires exp: ''

## Refresh tokens
Once a JWT is created, it does not expire unless you give it an expiration date. This means that a user that has logged in once, will be forever able to access the app data with that same token. This is not secure and therefore the initial tokens are set expire after x minutes.

A refresh token is used to renew the access token. The refresh token is stored separately, thus you revoke the base token every couple of minutes and the user needs to present the refresh token to continue to use the app.

The problem of a stolen token persists but you can invalidate the refresh token by creating a logout route.

## Stateless vs stateful
### Traditional stateless approach
Tokens are NOT stored on the server, only generated once with the user payload and then send to client via the Authorization header. The client stores the token in plain text, thus unsecure, local storage 

Each token is SIGNED by a secret to avoid tampering on the client-side and base64-url encoded. With each request by the user the server can verify the trustworthiness of the token. The user info is retrieved from the token.

Refresh tokens are sent with the initial access token and expired or revoked tokens are maintained in a blacklist.

### Stateful JWT
Only a user reference is stored in the payload (as an ID). The token is again signed by the server and base64-url encoded. Sent via header as a HTTP-ONLY flagged cookie (not accessible by js code) along-side a non-http `X-CSFR-TOKEN COOKIE`, accessible by js, read by the client and send along each new user request.

The server uses the user id in the TOKEN to retrieve the full user data from a DB
No user sessions stored on the server and revoked tokens need to persist on a blacklist.