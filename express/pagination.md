# Pagination with query parameters
Table of contents
- [Pagination with query parameters](#pagination-with-query-parameters)
  - [Query parameters](#query-parameters)
  - [Express route setup](#express-route-setup)

## Query parameters
The query parameters can be send to the server via a GET request like: `/route/?limit=5&offset=0`

The limit is the max number of elements to display and the offset is the index number where the list should start.
```js
const users = {
    john: {
        name: 'john'
    },
    jane: {
        name: 'jane'
    },
    bob: {
        name: 'bob'
    }
}
//offset = 1, limit = 2 give us jane and bob
//offset = 0, limit = 0 give us john, jane and bob
//offset = 2, limit = 1 give us bob
```
## Express route setup
The query variables limit and offset come in as a string, so parse them to an integer.

Based on the query values for limit and offset we need to take care of a couple of common cases.

Since we are working with an object, convert to an array and slice the array according to the required length and offset.
```js
app.get('/users', (req, res) => {
    //query values are strings, thus convert to integer
    const limitInt = parseInt(req.query.limit);
    const offsetInt = parseInt(req.query.offset);
    //no limit, send all users
    const length = limitInt > 0 ? limitInt : users.length;
    const offset = offsetInt > 0 ? offsetInt : 0;
    //result should be array
    const result = Object.values(users)
        .slice(offset)      //only keep from offset index to the end
        .slice(0, length);  //apply limit
    res.json(result);
})
