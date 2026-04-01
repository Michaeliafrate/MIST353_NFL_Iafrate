# Import the database connection function we want to test
from get_db_connection import get_db_connection
import os
import pyodbc
# load_dotenv reads the .env file so environment variables are available during testing
from dotenv import load_dotenv

# Load the .env file at the top level so all tests can access the variables
load_dotenv()

# This function runs three checks to make sure the database connection works correctly
def test_get_db_connection():
    # Test 1: Make sure all required environment variables exist in the .env file
    required_vars = ["DB_SERVER", "DB_NAME", "DB_LOGIN", "DB_PASSWORD"]
    missing = [v for v in required_vars if not os.getenv(v)]
    assert not missing, f"Missing env vars: {missing}"
    print("✅ Env vars loaded")

    # Test 2: Connection returns a pyodbc.Connection object
    # Confirms the function returns the right type, not None or an error
    conn = get_db_connection()
    assert isinstance(conn, pyodbc.Connection), "Expected a pyodbc.Connection"
    print("✅ Connection object returned")

    # Test 3: Connection is usable (run a simple query)
    # "SELECT 1" is the simplest possible query — if it works, the connection is live
    cursor = conn.cursor()
    cursor.execute("SELECT 1")
    result = cursor.fetchone()
    assert result[0] == 1, "Expected query result of 1"
    print("✅ Connection is live and queryable")

    # Close the connection cleanly after all tests pass
    conn.close()
    print("✅ Connection closed cleanly")
    print("\n🎉 All tests passed!")

# This block runs the test when you execute the file directly (e.g. python test_get_db_connection.py)
if __name__ == "__main__":
    test_get_db_connection()
