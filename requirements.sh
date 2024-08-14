sudo apt-get update
sudo apt-get install mysql-server
sudo service mysql start

sudo mysql -u root

#in sql
mysql> CREATE DATABASE database1;
Query OK, 1 row affected (0.03 sec)

mysql> CREATE DATABASE database2;
Query OK, 1 row affected (0.04 sec)

mysql> EXIT;

#For python:
pip install mysql-connector-python