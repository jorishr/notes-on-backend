# AJAX
Table of contents
- [AJAX](#ajax)
	- [About AJAX](#about-ajax)
	- [Request methods](#request-methods)

## About AJAX
Asynchronous Javascript And XML is an umbrella term for network requests in JavaScript. In practice the XML data format has been replaced by JSON, Javascript Object Notation.

Before 2005, the tools were: html, css, js, dom manipulation and XMLHTTPrequest from the browser to the server.

AJAX uses the same tools but uses them to update the webpage with new or dynamic content, *without* the need for *refreshing* the page. Thus the extra layer of JS makes it possible to send and receive server data without interrupting the current page.

A good example is PINTEREST or twitter that have an infinite scroll and without refreshing the page, new data is loaded in as you scroll near the bottom.

## Request methods
In modern web-development XMLHttpRequest is used for three reasons:
- Historical reasons: need to support existing scripts.
- old browsers support
- need something that the `fetch` method can't do yet, e.g. to track upload progress.

The FETCH API, is much easier than the XMLHTTPrequest but useless in IE and even Firefox mobile.

Third-party libraries jQuery, Axios offer a simplified syntax.