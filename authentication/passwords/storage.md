# Password storage in web apps
Storing user passwords in your database is common practice but it brings important security concers as your database may get hacked into or insiders may steal the stored information. Therefore, storing passwords as plain text is not secure and even hashing them is not secure enough. Many users tend to have the same (easy) password and those hashed will be the same and easily identified with online tables that solve the hashes for most common passwords. 

The secure way is to add "salt" to each hash. It's an extra hash generated with a plain text string and the resulting hash gets mixed into to calculation of the final hash that is stored. Thereby each hash is unique and cannot be easily solved using the most common hash tables because even the most common 123456 password gets mixed in with another random string. 

The only vulnerability that remains is obviously a weak password that can be found using a bruteforce attack, or a very simple hash algorithm. 

Matching the stored hash with a password typed at login is done by running the typed in paswword through the same salted hashing algorihm and if the resulting hash matches the stored hash, the login can go ahead. This way you can store and grant login to users without knowing what their password is.