# MYSQL Setup
Table of contents
- [MYSQL Setup](#mysql-setup)
  - [Linux Server](#linux-server)
    - [Log queries in real time](#log-queries-in-real-time)
  - [Web based interfaces](#web-based-interfaces)
  - [Desktop](#desktop)

## Linux Server
Use package manager to install mysql.
```
apt-get install mysql
sudo mysql -u root

// login with temp password generated during installation
// change the temp root password, grant full privileges 

ALTER USER 'root'@'localhost' IDENTIFIED BY '<newPassword>';
```
### Log queries in real time
In development you can log your queries.
Update my.cnf file and add:
```
general_log_file = /var/log/mysql.log
general_log = 1
```
Restart db and use the linux tail command and now each time you use a query command follow in the cli with: `tail -f /var/log/mysql.log`

## Web based interfaces
GUI interfaces may be more convenient to work with.
See phpAdmin or cPanel.	

## Desktop
See MySQL Workbench.