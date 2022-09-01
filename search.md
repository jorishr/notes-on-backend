# Search
## Form Setup
A simple `method="GET"` request is send from the form. Important to know is that this is not handled by express in the `req.body` but in the `REQ.QUERY`.

Name it `name="search"` and then on the server side you can have access to the query string at `req.query.search`.

## REGEX Setup
In the yelp-camp example we do a simple search for campgrounds only. You can use NPM packages such as `search-index` that facilitate lots of features but the basic things can be done with REGEX.

Note that you there is a possibility for DDOS attacks. The remedy is to run the query string to a replace function that filters out special characters.

The `replace()` method returns a new string with some or all matches of a pattern replaced by a replacement.
```javascript
function escapeRegex(queryString) {
		return queryString.replace(
		/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
};

const regex = new RegExp(escapeRegex(req.query.search), 'gi');
Campground.find(
	{$or:[
            {'name': regex},
            {'location': regex},
            {'author.username': regex}
        ]}
```
IMPORTANT: to search inside multiple object properties use the MongoDB operator: `$or: []` which expects an array of identifier objects.

## Rendering search results
To render the search result on the page you have to pass the array of found objects to the HTML template.