from get_db_connection import get_db_connection

def get_all_stadiums():
    conn = get_db_connection()
    cursor = conn.cursor(as_dict=True)
    cursor.execute("exec procGetAllStadiums")
    rows = cursor.fetchall()
    cursor.close()
    conn.close()
    results = [{"StadiumID": row["StadiumID"], "StadiumName": row["StadiumName"]} for row in rows]
    return {"data": results}
