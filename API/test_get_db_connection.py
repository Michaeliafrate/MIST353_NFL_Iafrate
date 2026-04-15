from get_db_connection import get_db_connection                                               # import the function we want to test
import os                                                                                     # os lets us check if environment variables are loaded
import pyodbc                                                                                 # pyodbc is the library that connects Python to SQL Server
from dotenv import load_dotenv                                                                # load_dotenv reads the .env file so environment variables are available during testing

load_dotenv()                                                                                 # load the .env file at the top level so all tests can access the variables

def test_get_db_connection():
    required_vars = ["DB_SERVER", "DB_NAME", "DB_LOGIN", "DB_PASSWORD"]                      # list of all the variables that must exist in the .env file
    missing = [v for v in required_vars if not os.getenv(v)]                                 # check each variable — if any are missing, add them to this list
    assert not missing, f"Missing env vars: {missing}"                                       # if anything is missing, stop the test and show which variables are missing
    print("✅ Env vars loaded")                                                               # if we get here, all required variables were found

    conn = get_db_connection()                                                                # call our function to open a database connection
    assert isinstance(conn, pyodbc.Connection), "Expected a pyodbc.Connection"               # make sure it returned an actual connection object and not None or an error
    print("✅ Connection object returned")                                                    # if we get here, the connection was created successfully

    cursor = conn.cursor()                                                                    # a cursor lets us send SQL commands through the connection
    cursor.execute("SELECT 1")                                                                # SELECT 1 is the simplest possible query — if it works, the connection is live
    result = cursor.fetchone()                                                                # fetch the single row that SELECT 1 returns
    assert result[0] == 1, "Expected query result of 1"                                      # confirm the result is 1 — proves the query actually ran
    print("✅ Connection is live and queryable")                                              # if we get here, the connection can successfully run queries

    conn.close()                                                                              # close the connection cleanly after all tests pass
    print("✅ Connection closed cleanly")                                                     # confirms the connection was closed without errors
    print("\n🎉 All tests passed!")                                                           # all three checks passed — the database connection is working correctly

if __name__ == "__main__":                                                                    # this block runs the test when you execute the file directly e.g. python test_get_db_connection.py
    test_get_db_connection()                                                                  # call the test function
