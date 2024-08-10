sudo apt-get update
sudo apt-get install mysql-server
sudo service mysql start
sudo service mysql status
sudo usermod -aG mysql $USER
ls -l /var/run/mysqld/mysqld.sock
sudo chmod 777 /var/run/mysqld/mysqld.sock
ps aux | grep mysqld
mysql -u root -p -h 127.0.0.1

#in sql
sudo mysql -u root

SELECT user, host, plugin FROM mysql.user WHERE user = 'root';


sudo service mysql stop
sudo mysqld_safe --skip-grant-tables &
mysql -u root

#in sql
mysql> CREATE DATABASE database1;
Query OK, 1 row affected (0.03 sec)

mysql> CREATE DATABASE database2;
Query OK, 1 row affected (0.04 sec)

mysql> EXIT;
