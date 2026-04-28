import streamlit as st
from fetch_data import post_data
from datetime import datetime

def schedule_game_ui():
    st.header("Schedule a Game")

    with st.form("schedule_game_form"):
        home_team_id = st.text_input("Enter Home Team ID: ")
        away_team_id = st.text_input("Enter Away Team ID: ")
        game_round = st.text_input("Enter Game Round (Wild Card, Divisional, Conference, Super Bowl): ")
        game_date_str = st.text_input("Enter Game Date (YYYY-MM-DD): ")
        game_time_str = st.text_input("Enter Game Time (HH:MM:SS): ")
        stadium_id_str = st.text_input("Enter Stadium ID: ")
        nfl_admin_id_str = st.text_input("Enter NFL Admin ID: ")
        submitted = st.form_submit_button("Schedule Game")

    if submitted:
        try:
            game_date = datetime.strptime(game_date_str, "%Y-%m-%d").date()
            game_time = datetime.strptime(game_time_str, "%H:%M:%S").time()
        except ValueError:
            st.error("Please enter a valid date (YYYY-MM-DD) and time (HH:MM:SS).")
            return

        result = post_data(
            "schedule_game/",
            {
                "home_team_id": int(home_team_id),
                "away_team_id": int(away_team_id),
                "game_round": game_round,
                "game_date": str(game_date),
                "game_time": str(game_time),
                "stadium_id": int(stadium_id_str),
                "nfl_admin_id": int(nfl_admin_id_str)
            },
            method="POST"
        )
        st.write(result)
