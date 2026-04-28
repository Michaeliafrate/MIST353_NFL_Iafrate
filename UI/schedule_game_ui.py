import streamlit as st
from fetch_data import post_data

def schedule_game_ui():
    st.header("Schedule a Game")
    home_team_id = st.text_input("Enter Home Team ID: ")
    away_team_id = st.text_input("Enter Away Team ID: ")
    game_round = st.text_input("Enter Game Round (e.g., Regular Season, Playoffs): ")
    game_date_str = st.text_input("Enter Game Date (YYYY-MM-DD): ")
    game_time_str = st.text_input("Enter Game Time (HH:MM:SS): ")
    stadium_id = int(st.text_input("Enter Stadium ID: "))
    nfl_admin_id = int(st.text_input("Enter NFL Admin ID: "))

    # Convert date and time strings to appropriate formats
    from datetime import datetime
    game_date = datetime.strptime(game_date_str, "%Y-%m-%d").date()
    game_time = datetime.strptime(game_time_str, "%H:%M:%S").time()

    if st.button("Schedule Game"):
        # Call the API function to schedule the game
        result = post_data(
            "schedule_game/",
            {
                "home_team_id": home_team_id,
                "away_team_id": away_team_id,
                "game_round": game_round,
                "game_date": game_date,
                "game_time": game_time,
                "stadium_id": stadium_id,
                "nfl_admin_id": nfl_admin_id
            },
            method="POST"
        )
        st.write(result)
