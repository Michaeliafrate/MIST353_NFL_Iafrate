import streamlit as st                                                                                               # streamlit provides all the UI components — headers, text inputs, buttons, tables, etc.
from fetch_data import fetch_data                                                                                    # fetch_data handles the API call so this file only needs to focus on the UI logic

def get_teams_in_same_conference_division_as_specified_team_ui():                                                    # this function renders the entire UI for the team lookup — it's called from the main app when the user selects this option
    st.header("Get Teams in Same Conference and Division as Specified Team")                                         # displays a large header at the top of this section

    team_name = st.text_input("Enter Team Name")                                                                     # creates a text box — whatever the user types is stored in this variable (e.g. "Steelers")

    if st.button("Fetch Teams"):                                                                                     # st.button returns True only when clicked — everything inside only runs on button click
        if not team_name.strip():                                                                                     # .strip() removes whitespace — if nothing remains, the user left the field blank
            st.warning("Please enter a team name.")                                                                  # st.warning shows a yellow banner to prompt the user to provide input
        else:
            input_params = {}                                                                                        # build a dictionary of parameters to send to the API
            input_params["team_name"] = team_name.strip()                                                           # the API will use this team name to look up its conference and division, then find all teams in that same group
            df = fetch_data("get_teams_in_same_conference_division_as_specified_team/", input_params)               # send the request to the API and get back a DataFrame of matching teams

            if df is not None and not df.empty:                                                                      # check that we actually got results before trying to display them
                st.subheader(f"Teams in the same conference and division as {team_name}:")                          # display a smaller header above the results table
                st.dataframe(df, use_container_width=True, hide_index=True)                                         # render the DataFrame as an interactive table — hide_index removes the default row numbers
            else:
                st.info(f"No teams found in the same conference and division as {team_name}. Please check the team name and try again.")  # st.info shows a blue banner when there are no results to display
