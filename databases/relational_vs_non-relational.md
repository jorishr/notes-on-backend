# Databases
Table of contents
- [Databases](#databases)
  - [The relational vs non-relational databases debate](#the-relational-vs-non-relational-databases-debate)
    - [Schema](#schema)
    - [Relations](#relations)
    - [Scaling](#scaling)

## The relational vs non-relational databases debate
### Schema
Relational databases requires that you use predefined schemas to determine the structure of your data before you work with it. In addition, all of your data must follow the same structure. This is good for predictability and maintenance but is less flexible. 

A relational structure can require significant up-front preparation, and it can mean that a future change in the structure would be both difficult to implement and disruptive to your whole system.

For example, when storing user data with lots of optional values you still need to foresee columns or fields that can be null. In a non-relational db those fields will simply not exist, except for in the users that you create that property-value.

The flexibility of a non-relational db means that:
- you can create documents without having to first define their structure
- each document can have its own unique structure
- you can add fields as you go

### Relations
Relations are established between tables by QUERIES or JOINS. When for example the user data changes, you don't need to update the product history data, as it is stored in a separate table. 

In a non-relational database, however, you may have duplicate data that may have to be updated in various places.

This is one reason why non-relational databases are considered to be faster or more efficient with large volumes of *read queries* and relational databases have the advantage on large volumes of *write queries*.

### Scaling
Horizontal scaling on relational databases is near impossible as separating and merging the data over multiple servers is very hard to do. You can scale vertically by adding more computational power to the existing server, but that too has its limits.

In a non-relational database there are no relations and various collections can be spread over multiple servers. Thus NoSQL databases are the preferred choice for large or ever-changing data sets.