from get_db_connection import get_db_connection                          # reuse the shared connection function so we don't repeat that setup logic here


def validate_user(
        email: str,
        password_hash: str
):
    conn = get_db_connection()                                           # open a connection to the database
    cursor = conn.cursor()                                               # a cursor is what lets us send SQL commands through the connection

    cursor.execute("{call procValidateUser(?, ?)}", (email, password_hash))  # call the stored procedure — passes the email and password hash to SQL Server to check if they match a user

    rows = cursor.fetchall()                                             # retrieve all rows the stored procedure returned — will be empty if no match was found
    conn.close()                                                         # close the connection immediately after — we have the data we need

    # convert each row from a raw database object into a plain dictionary so it can be sent back as JSON
    results = [
        {
            "AppUserID": row.AppUserID,                                  # the unique ID of the user in the database
            "Fullname": row.Fullname,                                    # the user's first and last name combined (done in SQL)
            "UserRole": row.UserRole                                     # the role of the user e.g. Admin or Fan
        }
        for row in rows
    ]

    return {"data": results}                                             # wrapping in a "data" key gives the API response a consistent structure the UI can always rely on