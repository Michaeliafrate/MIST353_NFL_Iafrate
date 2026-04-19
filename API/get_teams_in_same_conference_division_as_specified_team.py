from get_db_connection import get_db_connection

def get_teams_in_same_conference_division_as_specified_team(team_name: str):
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    cursor.callproc("procGetTeamsInSameConferenceDivisionAsSpecifiedTeam", (team_name,))
    rows = cursor.fetchall()
    conn.close()

    results = [
        {
            "TeamName": row["TeamName"],
            "Conference": row["Conference"],
            "Division": row["Division"]
        }
        for row in rows
    ]

    return {"data": results}
