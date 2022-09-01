# Web Storage
Table of contents
- [Web Storage](#web-storage)
	- [About](#about)
	- [Local Storage](#local-storage)
	- [Session Storage](#session-storage)
	- [Example: Text-area](#example-text-area)

## About
Web storage objects like `localStorage` and `sessionStorage` allow to save key/value pairs in the browser. What's interesting about them is that the data survives a page refresh (for session storage) and even a full browser restart (for local storage).

Unlike cookies, web storage objects are not sent to server with each request. Most browsers allow at least 2 megabytes of data (or more) and have settings to configure that. The storage is bound to the origin (domain/protocol/port triplet. That is, different protocols or subdomains infer different storage objects, they can't access data from each other.

The data is structured as a Map collection (setItem/getItem/removeItem), but also keeps elements in order and allows access by index with key(index).

## Local Storage
Shared between all tabs and windows from the same origin. Thus localStorage is domain specific as other sites cannot access the data of other domains. The data does not expire. It remains after the browser restart and even OS reboot.

To access a stored local storage property value we only have to be on the same origin (domain/port/protocol), the url path can be different. 

The local storage is bigger than cookie-storage, 5MB/domain vs 4kb/cookie. However, we are limited to plain text string data that needs to be SERIALIZED. Thus it is unsecure by design. Scripts and thus XSS attacks can access it, steal tokens and impersonate users.

LocalStorage should only be used for public non-sensitive string data. It does not have off-line capabilities, thus not suitable for web workers in PWA's.

## Session Storage
Properties and methods are the same as in local storage, but it's much more limited. The session storage exists only within the current browser tab, another tab with the same page will have a different storage. The data survives page refresh, but not closing/opening the tab.

## Example: Text-area
A text-area that stores the input you are typing into local storage. Thus, if you accidentally close the window, your data will still be there.
```HTML
<textarea 	style="width:200px; height: 60px;" 
			id="area" placeholder="Write here">
</textarea>

<button 	onclick="localStorage.removeItem('area'); 
			area.value=''">	
			Clear
</button>

<script>
   		area.value = localStorage.getItem('area');
		area.oninput = () => {
      		localStorage.setItem('area', area.value)
		};
</script>	
```