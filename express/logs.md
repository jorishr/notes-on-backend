# Logs in ExpressJs
Table of contents
- [Logs in ExpressJs](#logs-in-expressjs)
	- [Packages](#packages)
		- [Formats](#formats)
	- [Log to files](#log-to-files)
		- [Rotating log files](#rotating-log-files)
	- [Dual logging](#dual-logging)
## Packages
Express generator comes with MORGAN pre-installed. An alternative would be WINSTON.
```javascript
const logger = require('morgan');
app.use(logger('<format>', options));
```
### Formats	
The 'dev' format produces a concise output colored by response status for development use. The `:status` token will be colored red for server error codes, yellow for client error codes, cyan for redirection codes, and uncolored for all other codes. 

The 'common' and 'combined' produce standard Apache common/combined log output.

## Log to files
Write logs to a file.
```javascript
const fs = require('fs')
// create a write stream (in append mode)

const accessLogStream = fs.createWriteStream(path.join(__dirname, 'access.log'), { flags: 'a' })
	
// setup the logger
app.use(morgan('combined', { stream: accessLogStream }))
```
### Rotating log files
Rotate log files to one file per day with the rotating-file-stream package. A simple app that will log all requests in the Apache combined format to one log file per day in the log/ directory using the rotating-file-stream module.
```javascript
var rfs = require('rotating-file-stream')

// create a rotating write stream

var accessLogStream = rfs('access.log', {
	interval: '1d', 
	path: path.join(__dirname, 'log')})

app.use(morgan('combined', { stream: accessLogStream }))
```
## Dual logging
Dual logging to console and files:
```javascript
app.use(logger('dev'))
app.use(logger('common'), {
	stream: fs.createWriteStream(path.join(__dirname, 'access.log'), { flags: 'a' })
})
```