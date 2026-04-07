import streamlit as st
from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui
from validate_user_ui import validate_user_ui

st.title("NFL Playoffs App")
st.write("Welcome to the NFL Playoffs App! Use the sidebar to navigate through different features and explore information.")

# Creating a sidebar for navigation
# Dropdown for nfl playoff functionalities
with st.sidebar:
    st.title("NFL Playoff Functionalities")

    api_endpoint = st.selectbox(
        "Select a functionality:",
        ["Get Teams by Conference and Division", "Get Teams in Same Conference and Division as Specified Team", "Validate User"]
    )

if api_endpoint == "Get Teams by Conference and Division":
    get_teams_by_conference_division_ui()

elif api_endpoint == "Get Teams in Same Conference and Division as Specified Team":
    get_teams_in_same_conference_division_as_specified_team_ui()

elif api_endpoint == "Validate User":
    validate_user_ui()