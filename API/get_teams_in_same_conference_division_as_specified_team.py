from get_db_connection import get_db_connection

def get_teams_in_same_conference_division_as_specified_team(
        team_name: str
):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("{call procGetTeamsInSameConferenceDivisionAsSpecifiedTeam(?)}", (team_name,))
    rows = cursor.fetchall()
    conn.close()

    # Convert pyodbc.Row objects to dicts
    results = [
        {
            "TeamName": row.TeamName,
            "Conference": row.Conference,
            "Division": row.Division
        }
        for row in rows
    ]

    return {"data": results}
