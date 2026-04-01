import streamlit as st                                                                                                           # streamlit is the framework that turns Python scripts into interactive web apps
from get_teams_by_conference_division_ui import get_teams_by_conference_division_ui                                             # import the UI function for the first feature
from get_teams_in_same_conference_division_as_specified_team_ui import get_teams_in_same_conference_division_as_specified_team_ui  # import the UI function for the second feature

def nfl_playoffs_ui():                                                                                                           # this is the main entry point for the app — it controls the layout and which feature is shown
    st.title("NFL Playoffs App")                                                                                                 # st.title renders the largest heading on the page
    st.write("Welcome to the NFL Playoffs App! Use the sidebar to navigate through different features and explore information about NFL teams.")  # st.write renders plain text or markdown on the page

    with st.sidebar:                                                                                                             # the sidebar is a panel on the left side — good for navigation controls that stay visible across the app
        st.title("NFL Playoff Functionalities")                                                                                  # sidebar title shown above the dropdown

        api_endpoint = st.selectbox(                                                                                             # st.selectbox creates a dropdown — the selected value is stored in api_endpoint and changes whenever the user picks a different option
            "Select a functionality:",
            ["Get Teams by Conference and Division", "Get Teams in Same Conference and Division as Specified Team"]
        )

    if api_endpoint == "Get Teams by Conference and Division":                                                                   # check which option is selected and render the matching UI — only one section is shown at a time
        get_teams_by_conference_division_ui()                                                                                    # render the conference/division filter UI

    elif api_endpoint == "Get Teams in Same Conference and Division as Specified Team":                                          # if the user switched to the second option
        get_teams_in_same_conference_division_as_specified_team_ui()                                                            # render the team lookup UI

if __name__ == "__main__":                                                                                                       # this block only runs when the file is executed directly (e.g. via streamlit run) — not when imported by another file
    nfl_playoffs_ui()                                                                                                            # call the main function to start the app
