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

ssh -L local_port:remote_host:remote_port ssh_user@ssh_host -N


for ssh:
from sshtunnel import SSHTunnelForwarder
import mysql.connector

# # Setup SSH tunnel
# tunnel = SSHTunnelForwarder(
#     ('ssh_host', 22),  # SSH server
#     ssh_username='ssh_user',
#     ssh_password='ssh_password',  # Or use a private key instead of password
#     remote_bind_address=('127.0.0.1', 3306),  # Remote MySQL server
#     local_bind_address=('0.0.0.0', 3307)  # Local port for the tunnel
# )

# tunnel.start()

# # Connect to MySQL through the tunnel
# conn = mysql.connector.connect(
#     host='127.0.0.1',
#     port=tunnel.local_bind_port,  # Use the local port of the tunnel
#     user='db_user',
#     password='db_password',
#     database='database_name'
# )

# # Your database operations
# cursor = conn.cursor()
# cursor.execute("SELECT * FROM table_name;")
# result = cursor.fetchall()
# print(result)

# # Clean up
# cursor.close()
# conn.close()
# tunnel.stop()



# Security Considerations:
# SSH Keys: Use SSH key-based authentication instead of passwords for better security.
# Firewall: Ensure that the remote database server’s firewall only allows connections from localhost (the SSH tunnel) and not from external IPs directly.
# Encryption: All data transmitted through the SSH tunnel is encrypted, providing a secure channel even over unsecured networks.


ssh -L 3307:127.0.0.1:3306 ssh_user@ssh_host -N
