
# Data Synchronization Tool

## Overview

This Python script is designed to synchronize data between two MySQL databases, ensuring consistency across multiple tables. The script identifies new, updated, and deleted records in both databases and applies these changes while preserving data integrity. It also supports testing with large datasets and simulates concurrent updates to evaluate the synchronization process.

## Features

- **Database Connection with Retry Logic**: Establishes a connection to the MySQL databases with retry logic to handle transient connection issues.
- **SQL Execution**: Executes SQL scripts to set up the necessary database schema and initial data.
- **Data Synchronization**: Synchronizes tables between two databases by identifying and applying new, updated, and deleted records.
- **Large Dataset Population**: Populates a database table with a large number of records for performance testing.
- **Concurrent Update Simulation**: Simulates concurrent updates to test data integrity during synchronization.

## Requirements

- Python 3.x
- MySQL server
- Python packages:
  - `mysql-connector-python`
  - `logging`

## Installation
  
3. Install the required Python packages:
    ```bash
    pip install mysql-connector-python
    ```

## Usage

1. **Configure Database Connections**:

   Modify the `db_config1` and `db_config2` dictionaries in the script to match your MySQL database connection details:

    ```python
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
    ```

2. **Execute the Script**:

    Run the script to synchronize the databases:

    ```bash
    python sync_script.py
    ```

3. **SSH Tunneling (if needed)**:

    If you need to connect to remote databases securely, utilize SSH tunneling:

    ```bash
    ssh -L 3307:127.0.0.1:3306 user@remote_server
    ```

    This command forwards your local port `3307` to the remote server's MySQL port `3306`, allowing secure access.

## Testing

The script includes a testing mechanism for:

- **Large Dataset Handling**: Populate a table with 1000+ records to test the synchronization performance.
- **Concurrent Updates**: Simulate updates to the same table from different database connections to ensure data integrity.

## Synchronization Logic

1. **New Records**: Identifies records that exist in the source database but not in the target database and inserts them.
2. **Updated Records**: Detects records that have been modified in the source database and updates them in the target database.
3. **Deleted Records**: Locates records in the target database that do not exist in the source and deletes them.

## Logging

All operations are logged to `sync_log.log`, including connection attempts, SQL execution, and data synchronization details. This log file provides detailed insight into the synchronization process and helps troubleshoot any issues.

## Troubleshooting

- **Error: Data too long for column**: Ensure that the data types in the database schema match the expected input size.
- **Connection Issues**: If the script fails to connect to the database, verify the connection details and ensure that the MySQL server is running.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Contact

For any issues or questions, please contact [david.mandia@example.com](mailto:david.mandia@example.com).

---

This `README.md` provides a comprehensive overview of the project, installation steps, usage instructions, and troubleshooting tips. You can further customize it to suit your project's needs.
