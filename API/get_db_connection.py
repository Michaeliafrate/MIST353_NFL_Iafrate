import os
import pyodbc
from dotenv import load_dotenv

def get_db_connection():
    # Load environment variables from .env file
    load_dotenv()

    # Retrieve database connection parameters from environment variables
    db_server = os.getenv('DB_SERVER')
    db_name = os.getenv('DB_NAME')
    db_login = os.getenv('DB_LOGIN')
    db_password = os.getenv('DB_PASSWORD')

    # Construct the connection string
    connection_string = f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={db_server};DATABASE={db_name};UID={db_login};PWD={db_password};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'

    try:
        connection = pyodbc.connect(connection_string)
        return connection
    except Exception as e:
        raise RuntimeError(f"Database connection failed: {e}")