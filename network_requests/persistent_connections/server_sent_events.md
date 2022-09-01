# Web workers and server sent events
Table of contents
- [Web workers and server sent events](#web-workers-and-server-sent-events)
  - [Web workers](#web-workers)
  - [SSE](#sse)
## Web workers 
Web workers zijn Javascript modules die in de achtergrond lopen zonder dat dat invloed heeft op de rest van de pagina. 

## SSE
Server-Sent Events specification describes a built-in class EventSource, that keeps connection with the server and allows to RECEIVE events from the server through a persistent connection.

It is less powerful than the WEBSOCKET protocol (can only receive text, not binary data) and is ideal for one directional server sent updates such as news feeds, stock markets, live-scores, etc. 

Also it supports auto-reconnect with retry timeout, something we need to implement manually with WebSocket. 

It's plain old HTTP, not a new protocol.

Message ids to resume events, the last received identifier is sent in Last-Event-ID header upon reconnection.

The current state is in the `readyState` property.