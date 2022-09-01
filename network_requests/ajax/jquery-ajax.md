# AJAX with jQuery
The advantage of using JQUERY: much less code. 

Making the request AND parsing the data to a JS object notation can be done in just one line!
```Javascript
$.getJSON('<url>', function(data){
	//do smth
});
```
If you inspect the jQUERY source code you will see that it basically calls a basic XMLHttpRequest() with `xhr.open('method', 'url')` and `xhr.send();`.

## Four methods
```javascript
$.ajax() 
//-> base method

// Shorthand method built on top of $.ajax()
$.get()
$.post()
$.getJSON()

$.ajax({method: 'GET', url: '<url>', dataType: 'json'})
.done(function(res){//do smth})
.fail(function(){})
```
jQuery makes an intelligent guess about the data-type and will usually parse the JSON into a JS Object. To control this process, adjust the OPTIONS object or use `$.getJSON()`. 