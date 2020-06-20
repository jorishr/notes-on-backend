# Progressive Web Apps
Table of contents
- [Progressive Web Apps](#progressive-web-apps)
  - [NPM Setup](#npm-setup)
  - [Dev tools console](#dev-tools-console)
  - [Google Workbox](#google-workbox)
    - [Update HTML](#update-html)
  - [Service worker adjustments](#service-worker-adjustments)
    - [What to cache](#what-to-cache)
    - [Cache fetch data](#cache-fetch-data)
    - [Cache Google Fonts](#cache-google-fonts)
  - [Make the web app installable locally](#make-the-web-app-installable-locally)
    - [Update HTML](#update-html-1)

## NPM Setup
Add a script: `"SERVE": "http-server -p 1336 build -c-1"` that sets up a http-server on port 1336 and disables caching (-c-1), see `http-server` docs. The folder used is "build".

## Dev tools console
Go to application -> service workers -> offline. To check the offline capability.

## Google Workbox
Run the command and this will guide you through setup process.
```	
workbox wizard
```
Workbox is going to cache the files you specify to make them available offline. Once the workbox is configured you can run `generateSW` to get the actual service worker file.
```
workbox generateSw
```
This creates the sw.js file.

### Update HTML
If a service worker is detected, register it upon windows load.
```HTML
  <script>
      if ('serviceWorker' in navigator) {
          window.addEventListener('load', () => {
              navigator.serviceWorker.register('/sw.js');
          });
      }
  </script>
```
In the console you can now see the cache storage under application as well as a message in the console.

The app will continue to be available offline, be it without the fetched data.

## Service worker adjustments
Add a file src-sw.js along side the workbox-config.js in the root folder.

importScripts('https://storage.googleapis.com/workbox-cdn/releases/3.0.0/workbox-sw.js');

Update the workox-config.js: "swSrc": "src-sw.js"

Inject the customizations after modifying the src-sw.js:

`workbox injectManifest`

### What to cache
Now you can add the customizations, you have to specfiy what to cache exactly. For exact syntax see Google Workbox documentation.

You may need to refresh a couple of times to have things show up in the console.

### Cache fetch data
```javascript
workbox.routing.registerRoute(
    new RegExp('https://jsonplaceholder.typicode.com/users'),
    workbox.strategies.cacheFirst()
); 
```
### Cache Google Fonts
The fonts needs to be imported in the HTML, not CSS.
```javascript
workbox.routing.registerRoute(
    new RegExp('https://fonts.(?:googleapis|gstatic).com/(.*)'),
    workbox.strategies.cacheFirst({
      cacheName: 'google-fonts',
      plugins: [
        new workbox.expiration.Plugin({
          maxEntries: 30,
        }),
        new workbox.cacheableResponse.Plugin({
          statuses: [0, 200]
        }),
      ],
    }),
  );
```

## Make the web app installable locally
Add a MANIFEST. Go to WEB APP MANIFEST GENERATOR. The short name is what gets shown on the users HOME SCREEN ICON.
Background color is the loading screen color. Orientation: standalone.

Add the manifest.json to the BUILD folder.
Including an image folder if you use an icon.

### Update HTML
Add a link tag to the manifest.json. You can use the web app manifest generator for this as well.