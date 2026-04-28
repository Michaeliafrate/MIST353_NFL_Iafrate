from get_db_connection import get_db_connection
import pymssql

def get_teams_for_specified_fan(
        fan_id: int
    ):
    #with get_db_connection() as conn:
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    #cursor.callproc("procGetTeamsForSpecifiedFan", (fan_id))
    cursor.execute("exec procGetTeamsForSpecifiedFan %s", (fan_id))#for single param, use execute with exec procName param
    rows = cursor.fetchall()
    conn.close()

    #Convert pymssql.Row objects to dicts
    results = [
        {
            "TeamName": row["TeamName"],
            "Conference": row["Conference"],
            "Division": row["Division"],
            "TeamColors": row["TeamColors"],
            "PrimaryTeam": row["PrimaryTeam"]
        }
        for row in rows
    ]

    return {"data": results}
