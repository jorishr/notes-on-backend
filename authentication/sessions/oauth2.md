# OAuth2
Table of contents
- [OAuth2](#oauth2)
  - [About OAuth2](#about-oauth2)
  - [Process overview](#process-overview)

## About OAuth2
OAuth2 is an open standard for ACCESS DELEGATION, commonly used as a way for Internet users to grant websites or applications access to their information on other websites but without giving them the passwords. To access the resources from a different service or server you need to specify exactly which user data you want to access.

For example, login with your Google Account to an another website called SHOP. The client or end-user does very little. He clicks the option to login with a Google Account and has to authorize the use of specific Google Account data. Most work happens in the background between the Google server and SHOP server.

## Process overview
The client clicks LOGIN and is sent over to the GOOGLE server with an authorization request. The destination is a specially crafted URL that indicates the client_id and scope of the data that is required. The client obtains an authorization GRANT if the user accepts. If he clicks cancel an error message is displayed through the callback.

The obtained GRANT is used to ask the AUTHORIZATION SERVER at GOOGLE to obtain an ACCESS TOKEN. Thus there is no direct access to the data at this point. Also sent with the new request is the client_secret. The client obtains an ACCESS TOKEN that temporary grants access, usually 7 days. Sometimes there's also a refresh token issued so that the access token can be renewed. Refresh tokens don't have to expire. The reason for access tokens to expire is because they give you direct access to the data, while refresh tokens don't and need to be come with the client_secret to obtain the acutal access token. 

Now you can make authenticated API calls to the resource server to obtain the actual USER DATA.