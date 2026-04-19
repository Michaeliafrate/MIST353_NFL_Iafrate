from get_db_connection import get_db_connection                                    # reuse the shared connection function so we don't repeat that setup logic here

def get_teams_by_conference_division(conference: str = None, division: str = None): # both parameters are optional — the stored procedure handles NULL values and returns all teams if nothing is passed
    conn = get_db_connection()                                                       # open a connection — always close this when done to avoid leaving connections open
    cursor = conn.cursor(as_dict=True)
    conference = conference if conference else None
    division = division if division else None
    cursor.callproc("procGetTeamsByConferenceDivision", (conference, division))
    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "TeamName": row["TeamName"],
            "Conference": row["Conference"],
            "Division": row["Division"],
            "TeamColors": row["TeamColors"]
        }
        for row in rows
    ]

    return {"data": results}                                                         # wrapping in a "data" key gives the API response a consistent structure the UI can always rely on
