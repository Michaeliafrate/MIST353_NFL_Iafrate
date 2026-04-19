import os
#import pyodbc
import pymssql
from dotenv import load_dotenv

load_dotenv()

def get_db_connection():
    input_server = os.getenv('DB_SERVER')
    input_database = os.getenv('DB_NAME')
    input_user = os.getenv('DB_LOGIN')
    input_password = os.getenv('DB_PASSWORD')
    #connection_string = f"DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password};"
    #connection_string += "Encrypt=yes;TrustServerCertificate=yes;Connection Timeout=30;"

    #return pyodbc.connect(connection_string)
    return pymssql.connect(server=input_server, user=input_user, password=input_password, database=input_database, port=1433, tds_version='7.4')
