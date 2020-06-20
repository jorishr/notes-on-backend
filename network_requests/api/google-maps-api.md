# Google Maps
Table of contents
- [Google Maps](#google-maps)
	- [API Keys](#api-keys)
	- [Code setup](#code-setup)
	- [Adding markers](#adding-markers)
	- [Generating markers](#generating-markers)

## API Keys
Works with two API keys. 

The first one should be unrestricted and is only used on the backend. It is stored in the ENV and thus not visible to the outside world.

The second one is visible in the HTML at some point and therefore HAS to be restricted to the domain or localhost.

You have to create a project in the Google dev tools console.

## Code setup
See google dev page for code example.
- a div with #id where the map will be generated.
- a script tag that initiates the map function `initMap()` with the map options inside a variable `options = {}`, basically to center the map the correct latitude
- a script that holds the link to the map API key
- the map div needs to have a width and height

## Adding markers
```javascript
var marker = new google.maps.Marker(position:(), map:map, icon: 'customIconLink')

var infoWindow = new google.maps.InfoWindow({content: 'text with info'});
//in content you can add plain html

marker.addEventListener('click', function(){infoWindow.open(map, marker)})
```
## Generating markers
The process of individually writing the code for each marker is inefficient. Write a function that writes the marker code for us as you pass in an array of objects with info about each marker point.
```javascript
function addMarker(props){
	var marker = 
		new.google.maps.Marker({position:(props.coord), map: map, 
			//icon: props.iconImg})
	if(props.icon){market.setIcon(props.iconImg)}
}
addMarker({coord:{lat:xxx, lng: xxx}, iconImg: 'link'})
addMarker({coord:{lat:xxx, lng: xxx}})
```
Not all markers will get a custom icon, so use an if statement to avoid undefined values.

Same thing for the CONTENT of the infoWindow.
```javascript
function addMarker(props){
	var marker = 
		new.google.maps.Marker({position:(props.coord), map: map}) 
			//icon: props.iconImg})
		if(props.icon){ marker.setIcon(props.iconImg) }
		if(props.content){
			var infoWindow = 
				new.google.maps.InfoWindow({content: props.content});
	}
})
addMarker({coord:{lat:xxx, lng: xxx}, iconImg: 'link'})
addMarker({coord:{lat:xxx, lng: xxx}, content: '<h1>title</h1>})
```
Put the market objects into an array of objects, loop through it and call the function for each object value.