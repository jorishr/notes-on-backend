# Websockets
Table of contents
- [Websockets](#websockets)
	- [About Websockets](#about-websockets)
	- [The Websocket Protocol](#the-websocket-protocol)
	- [Creating a Websocket connection](#creating-a-websocket-connection)
	- [Data transfer](#data-transfer)
		- [Rate limiting](#rate-limiting)
		- [Close connections](#close-connections)
	- [NGINX Setup for Websockets](#nginx-setup-for-websockets)

## About Websockets
WebSockets are an alternative to HTTP communication in Web Applications. They offer a persistent, bidirectional communication channel between client and server. Once established, the channel is kept open, offering a very fast connection with low latency and overhead.

WebSockets are great for real-time and long-lived communications. HTTP is great for occasional data exchange and interactions initiated by the client.

HTTP is much simpler to implement, while WebSockets require a bit more overhead.

WebSocket is secured by TLS, (same as HTTPS is HTTP over TLS), the transport security layer encrypts the data at sender and decrypts at the receiver. So data packets are passed through proxies in encrypted form.

## The Websocket Protocol
When `new WebSocket(url)` is created, the browser starts with a a regular HTTP GET Request that asks through the headers for the protocol to be upgraded to Websocket with a a random browser-generated key for security.
```
GET /chat
Host: javascript.info
Origin: https://javascript.info
Connection: Upgrade
Upgrade: websocket
Sec-WebSocket-Key: Iv8io/9s+lYFgZWcXczP8Q==
Sec-WebSocket-Version: 13
```
If the server response is correct you get a 101:
```
101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: hsBlbuDTkk24srzEOTBUlZAlC2g=
```
## Creating a Websocket connection
Always use the secure, encrypted protocol for WebSockets, `wss://`.
```Javascript
const url = 'wss://myserver.com/something'
const socket = new WebSocket(url)
//-> connection is a WebSocket object.

//When the connection is successfully established, the open event is fired.

socket.onopen = (e) => {console.log('ws connection open')}

socket.onerror = (err) => {console.log('ws connection error:', err)}

//There are two other events:
socket.onmessage = (e) => console.log(`Data received from server: ${e.data}`)

socket.onclose = (e) => {  
	if (e.wasClean) {
	   console.log(`Connection closed cleanly, code=${e.code} reason=${e.reason}`);
	} else {
		console.log(`Unexpected connection loss`)
		//-> e.g. server process killed or network down
		// event.code is usually 1006 in this case
	}
}
```
## Data transfer
WebSocket communication consists of frames of data fragments that can be sent from either side, and can be of several types:
- text and binary frames
- ping frames to check connection
- closing frame to close the connection

The WebSocket `.send()` method can send either text or binary data: `socket.send(data)`

When we receive the data, text always comes as string. And for binary data, we can choose between Blob and ArrayBuffer formats. That is set by `socket.bufferType` property, it's "blob" by default, so binary data comes as Blob objects.

Blob is a high-level binary object, it directly integrates with anchor and image tags, so that's a good default.

### Rate limiting
Imagine the user has a slow network connection. We can call `socket.send(data)` again and again but through rate limiting the data will be buffered (stored) in memory and sent out only as fast as network speed allows.
```javascript
setInterval(() => {
  if (socket.bufferedAmount == 0) {
    socket.send(moreData());
  }
}, 100);
//-> every 100ms examine the socket and send more data only if all the existing data was sent out
```
### Close connections
When the browser or server wants to close the connection, they send a connection close frame with a numeric code and a textual reason: `socket.close([code], [reason]);`

## NGINX Setup for Websockets
WebSocket by itself does not include reconnection, authentication and many other high-level mechanisms. So there are client/server libraries for that, and it's also possible to implement these capabilities manually.

Sometimes, to integrate a WebSocket into existing project, people run a WebSocket server in parallel with the main HTTP-server, and they share a single database. Requests to WebSocket use `wss://ws.site.com`, a subdomain that leads to the WebSocket server, while `https://site.com` goes to the main HTTP-server.

Reference [video tutorial](https://www.youtube.com/watch?v=zutCD7HMgwA)

The http protocol has two types of HEADERS: regular end-to-end headers and hop-by-hop headers.

End-to-end headers are transferred to the ultimate endpoint of a request or response. Thus intermediate points like NGINX will forwards these headers by default.

HOP-BY-HOP like Connection and Upgrade are not automatically passed through by intermediate point such as NGINX.

To have these headers setup correctly in a websocket you need to configure NGINX.