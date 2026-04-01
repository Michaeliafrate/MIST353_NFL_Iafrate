import os                                                                                                                                                                                              # os lets us securely read credentials stored in environment variables instead of hardcoding them in the code
import pyodbc                                                                                                                                                                                          # pyodbc is the library that allows Python to talk to a SQL Server database
from dotenv import load_dotenv                                                                                                                                                                         # load_dotenv reads a .env file and makes its values available via os.getenv()

def get_db_connection():                                                                                                                                                                               # this function is called any time we need to query the database — it handles the connection setup for us
    load_dotenv()                                                                                                                                                                                      # this must be called before os.getenv() so the .env values are loaded into memory

    db_server = os.getenv('DB_SERVER')                                                                                                                                                                # the server address where SQL Server is running (stored in .env so it's not exposed in code)
    db_name = os.getenv('DB_NAME')                                                                                                                                                                    # the name of the specific database we want to connect to
    db_login = os.getenv('DB_LOGIN')                                                                                                                                                                  # the SQL Server username (kept in .env for security)
    db_password = os.getenv('DB_PASSWORD')                                                                                                                                                            # the SQL Server password (kept in .env for security)

    connection_string = f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={db_server};DATABASE={db_name};UID={db_login};PWD={db_password};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'  # pyodbc requires all connection info in a single formatted string — this tells it exactly how to connect

    try:
        connection = pyodbc.connect(connection_string)                                                                                                                                                 # attempt to establish the connection using the string we built above
        return connection                                                                                                                                                                               # if successful, return the connection so the caller can use it to run queries
    except Exception as e:
        raise RuntimeError(f"Database connection failed: {e}")                                                                                                                                         # if the connection fails (wrong credentials, server down, etc.), stop execution and explain why
