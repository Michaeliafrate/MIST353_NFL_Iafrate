from get_db_connection import get_db_connection                                    # reuse the shared connection function so we don't repeat that setup logic here

def get_teams_by_conference_division(conference: str = None, division: str = None): # both parameters are optional — the stored procedure handles NULL values and returns all teams if nothing is passed
    conn = get_db_connection()                                                       # open a connection — always close this when done to avoid leaving connections open
    cursor = conn.cursor()                                                           # a cursor is what lets us send SQL commands through the connection

    cursor.execute("{call procGetTeamsByConferenceDivision(?, ?)}", (conference, division))  # call the stored procedure in SQL Server — the ? placeholders safely pass values to prevent SQL injection

    rows = cursor.fetchall()                                                         # retrieve all rows the stored procedure returned
    conn.close()                                                                     # close the connection immediately after — we have the data we need

    results = [                                                                      # pyodbc returns raw Row objects, so we convert each one to a plain dictionary that can be serialized to JSON
        {
            "TeamName": row.TeamName,                                                # maps to the TeamName column in the database result
            "Conference": row.Conference,                                            # maps to the Conference column (e.g. AFC or NFC)
            "Division": row.Division,                                                # maps to the Division column (e.g. North, South, East, West)
            "TeamColors": row.TeamColors                                             # maps to the TeamColors column
        }
        for row in rows
    ]

    return {"data": results}                                                         # wrapping in a "data" key gives the API response a consistent structure the UI can always rely on
