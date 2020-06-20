# Axios Library
The Axios Library offers:
- automatic JSON parsing
- can be used in NodeJs
- lightweight, without all other jQUERY bloat
- excellent browser support as it is built upon the basic XMLHttpRequest().

## Syntax
```javascript
axios.get('url')
.then(function(res){console.log(res.data)})
.catch(function(err){console.log(err)})
```
## Error Handling
Axios allows to differentiate between `response.error` and `request.error`. For example, correct URL domain but wrong endpoint results in a response error. An incorrect url domain generates a request error:
```javascript
function handleErrors(err) {
  if (err.response) {
    console.log("Problem With Response ", err.response.status);
  } else if (err.request) {
    console.log("Problem With Request!");
  } else {
    console.log('Error', err.message);
  }
}
```