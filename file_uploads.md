# File upload with Multer
When a web client uploads a file to a server, it is generally submitted through a form and encoded as `multipart/form-data`. Multer is middleware for Express and Node.js that makes it easy to handle this multipart/form-data when your users upload files. 

Middleware is a piece of software that connects different applications or software components. In Express, middleware processes and transforms incoming requests to the server. In our case, Multer acts as a helper when uploading files.

## Setup local server storage
### MULTER
See [file-upload-with-multer-in-node](https://code.tutsplus.com/tutorials/file-upload-with-multer-in-node--cms-32088)

### Formidable
A Node.js module for parsing form data, especially file uploads.

Uploaded files can be stored on your own server or on a third party CDN cloud storage.

See [mage Upload with Node](https://www.youtube.com/watch?v=RHd4rP9U9SA)