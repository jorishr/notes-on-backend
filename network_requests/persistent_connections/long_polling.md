# Long Polling
Long polling is the simplest way of having persistent connection with server that doesn't use any specific protocol like WebSocket or Server Side Events.

The flow:
- A request is sent to the server.
- The server doesn't close the connection until it has a message to send. There is a pending connection.
- When a message appears the server responds to the request with it.
- The browser makes a new request immediately.

See [Long Polling](https://javascript.info/long-polling)