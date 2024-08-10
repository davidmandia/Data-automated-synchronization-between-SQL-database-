import mysql.connector
from mysql.connector import errorcode
import time
import logging
from threading import Thread

# Configure logging
logging.basicConfig(filename='sync_log.log', level=logging.INFO,
                    format='%(asctime)s:%(levelname)s:%(message)s')

def connect_to_database(host, user, password, database):
    """Establish a connection to the MySQL database with retry logic."""
    attempts = 3
    while attempts > 0:
        try:
            connection = mysql.connector.connect(
                host=host,
                user=user,
                password=password,
                database=database
            )
            logging.info(f"Connected to {database} at {host}")
            return connection
        except mysql.connector.Error as err:
            logging.error(f"Error connecting to {database} at {host}: {err}")
            if attempts > 1:
                logging.info(f"Retrying connection to {database}...")
                time.sleep(5)
            attempts -= 1
    return None

def execute_sql_file(connection, sql_file):
    """Execute an SQL file to create tables and populate data."""
    cursor = connection.cursor()
    try:
        with open(sql_file, 'r') as file:
            sql = file.read()
            for result in cursor.execute(sql, multi=True):
                if result.with_rows:
                    result.fetchall()  # Fetch all rows if it's a SELECT query
                logging.info(f"Executed: {result.statement}")
        connection.commit()
        logging.info(f"Executed SQL file: {sql_file}")
    except Exception as e:
        logging.error(f"Failed to execute SQL file {sql_file}: {e}")
    finally:
        cursor.close()

def synchronize_tables(conn1, conn2, table_name):
    """Synchronize data between two tables with the same schema."""
    cursor1 = conn1.cursor(dictionary=True)
    cursor2 = conn2.cursor(dictionary=True)

    try:
        logging.info(f"Synchronizing table {table_name} from database1 to database2...")
        # Retrieve data from both tables
        cursor1.execute(f"SELECT * FROM {table_name}")
        records1 = cursor1.fetchall()

        cursor2.execute(f"SELECT * FROM {table_name}")
        records2 = cursor2.fetchall()

        records1_dict = {record['pkey']: record for record in records1}
        records2_dict = {record['pkey']: record for record in records2}

        # Insert/update records
        for pkey, record in records1_dict.items():
            if pkey not in records2_dict:
                placeholders = ', '.join(['%s'] * len(record))
                columns = ', '.join(record.keys())
                sql = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
                cursor2.execute(sql, list(record.values()))
                logging.info(f"Inserted new record with pkey {pkey} into {table_name}.")
            elif record != records2_dict[pkey]:
                updates = ', '.join([f"{col}=%s" for col in record.keys()])
                sql = f"UPDATE {table_name} SET {updates} WHERE pkey=%s"
                cursor2.execute(sql, list(record.values()) + [pkey])
                logging.info(f"Updated record with pkey {pkey} in {table_name}.")

        # Delete records
        for pkey in records2_dict.keys():
            if pkey not in records1_dict:
                sql = f"DELETE FROM {table_name} WHERE pkey=%s"
                cursor2.execute(sql, (pkey,))
                logging.info(f"Deleted record with pkey {pkey} from {table_name}.")

        conn2.commit()
        logging.info(f"Synchronized table: {table_name}")
    except mysql.connector.Error as err:
        logging.error(f"Error during synchronization of table {table_name}: {err}")
    finally:
        cursor1.close()
        cursor2.close()

def close_connection(connection):
    """Close the database connection."""
    if connection:
        connection.close()
        logging.info("Database connection closed.")

# Setup for large dataset testing
def populate_large_dataset(connection, table_name, record_count):
    """Populate a table with a large number of records for testing."""
    cursor = connection.cursor()
    try:
        logging.info(f"Populating {record_count} records in {table_name}...")
        for i in range(record_count):
            sql = f"INSERT INTO {table_name} (compoundid, preferredname, smiles) VALUES ('Compound{i}', 'Test{i}', 'C{i}H{i}')"
            cursor.execute(sql)
        connection.commit()
        logging.info(f"Populated {record_count} records in {table_name}")
    except Exception as e:
        logging.error(f"Failed to populate large dataset in {table_name}: {e}")
    finally:
        cursor.close()

# Setup for concurrent updates testing
def simulate_concurrent_updates(connection, table_name):
    """Simulate concurrent updates to the database."""
    cursor = connection.cursor()
    try:
        logging.info(f"Simulating concurrent update on {table_name}...")
        sql = f"UPDATE {table_name} SET assay_type = 'Updated' WHERE pkey = 1"  # Ensure 'Updated' is within the 10-character limit
        cursor.execute(sql)
        connection.commit()
        logging.info(f"Concurrent update performed on {table_name}")
    except Exception as e:
        logging.error(f"Error during concurrent update simulation on {table_name}: {e}")
    finally:
        cursor.close()

# Example connection details (replace with actual credentials)
db_config1 = {
    "host": "localhost",
    "user": "root",
    "password": "password",
    "database": "database1"
}

db_config2 = {
    "host": "localhost",
    "user": "root",
    "password": "password",
    "database": "database2"
}

# Connect to both databases
conn1 = connect_to_database(**db_config1)
conn2 = connect_to_database(**db_config2)

if conn1 and conn2:
    # Execute SQL files to set up the databases
    execute_sql_file(conn1, 'data/dump-database1.sql')
    execute_sql_file(conn2, 'data/dump-database2.sql')

    # Synchronize the tables, starting with target to ensure referential integrity
    synchronize_tables(conn1, conn2, 'target')
    synchronize_tables(conn2, conn1, 'target')
    synchronize_tables(conn1, conn2, 'compounds')
    synchronize_tables(conn2, conn1, 'compounds')
    synchronize_tables(conn1, conn2, 'assay')
    synchronize_tables(conn2, conn1, 'assay')

    # Test with a large dataset
    populate_large_dataset(conn1, 'compounds', 1000)

    # Simulate concurrent updates
    thread1 = Thread(target=simulate_concurrent_updates, args=(conn1, 'assay'))
    thread2 = Thread(target=simulate_concurrent_updates, args=(conn2, 'assay'))
    thread1.start()
    thread2.start()
    thread1.join()
    thread2.join()

# Close the connections after the operations
close_connection(conn1)
close_connection(conn2)
