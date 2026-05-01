import streamlit as st                                                                                        # streamlit is the library that runs the whole web app
from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui                          # import the UI function for filtering teams by conference/division
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui  # import the UI function for finding teams in the same group as a given team
from validate_user_ui import validate_user_ui                                                                # import the UI function for validating a user login
from get_teams_for_specified_fan_ui import get_teams_for_specified_fan_ui                                    # import the UI function for getting teams for a specified fan
from schedule_game_ui import schedule_game_ui
from get_all_changes_made_by_specified_admin_ui import get_all_changes_made_by_specified_admin_ui

st.title("NFL Playoffs App")                                                                                 # displays the main title at the top of the page
st.write("Welcome to the NFL Playoffs App! Use the sidebar to navigate through different features and explore information.")  # displays a welcome message below the title

# Creating a sidebar for navigation
# Dropdown for nfl playoff functionalities
with st.sidebar:                                                                                             # everything inside this block appears in the left sidebar panel
    st.title("NFL Playoff Functionalities")                                                                  # title shown at the top of the sidebar

    api_endpoint = st.selectbox(                                                                             # creates a dropdown menu — whatever the user picks is stored in api_endpoint
        "Select a functionality:",
        ["Get Teams by Conference and Division", "Get Teams in Same Conference and Division as Specified Team", "Validate User", "Get Teams for Specified Fan", "Schedule a Game", "Get All Changes Made By Admin"]
    )

if api_endpoint == "Get Teams by Conference and Division":                                                   # check which option the user picked and call the matching UI function
    get_teams_by_conference_division_ui()

elif api_endpoint == "Get Teams in Same Conference and Division as Specified Team":                          # each elif checks the next possible selection
    get_teams_in_same_conference_division_as_specified_team_ui()

elif api_endpoint == "Validate User":                                                                        # if validate user is selected, show the login form
    validate_user_ui()

elif api_endpoint == "Get Teams for Specified Fan":
    get_teams_for_specified_fan_ui()

elif api_endpoint == "Schedule a Game":
    if "app_user_id" not in st.session_state:
        st.warning("Please log in to access the Schedule a Game functionality.")
    elif st.session_state.app_user_role != "NFLAdmin":
        st.warning("Only users with the NFLAdmin role can access the Schedule a Game functionality.")
    else:
        schedule_game_ui()

elif api_endpoint == "Get All Changes Made By Admin":
    if "app_user_id" not in st.session_state:
        st.warning("Please log in to access the Get All Changes Made By Admin functionality.")
    elif st.session_state.app_user_role != "NFLAdmin":
        st.warning("Only users with the NFLAdmin role can access the Get All Changes Made By Admin functionality.")
    else:
        get_all_changes_made_by_specified_admin_ui()