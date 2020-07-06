# Redis for session storage in production
For setting up Redis on a Ubuntu server see my Linux documentation.

The Express code for managing sessions with Redis is self-explanatory. For more option configuration see Connect-Redis and Redis documentation. 
```js
const express = require('express');
const session = require('express-session');
const redis = require('redis');
const redisStore = require('connect-redis')(session);
//const redisClient = redis.createClient(port, host);
//port and host can be define here or below in the options object
//default is to only allow connections from the same server (localhost)
const redisClient = redis.createClient();

const app = express();

redisClient.on('error', (err) => {
  console.log('Redis error: ', err);
});
app.use(session({
    store: new redisStore({ 
        host: 'localhost', 
        port: 6379, client: 
        redisClient, 
        ttl: 86400 
    }),
    secret: 'secret',
    name: '_thisIsOptional',
    resave: false,
    saveUninitialized: true,
}));
```