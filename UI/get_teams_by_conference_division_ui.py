import streamlit as st                                                                                   # streamlit provides all the UI components — headers, text inputs, buttons, tables, etc.
from fetch_data import fetch_data                                                                        # fetch_data handles the API call so this file only needs to focus on the UI logic

def get_teams_by_conference_division_ui():                                                               # this function renders the entire UI for filtering teams — it's called from the main app when the user selects this option
    st.header("Get Teams by Conference and Division")                                                    # displays a large header at the top of this section

    conference_name = st.text_input("Enter Conference Name")                                             # creates a text box — whatever the user types is stored in this variable (e.g. "AFC")
    division_name = st.text_input("Enter Division Name")                                                 # creates a second text box for division (e.g. "North") — both are optional

    if st.button("Fetch Teams"):                                                                         # st.button returns True only when clicked — everything inside only runs on button click
        if not conference_name.strip() and not division_name.strip():                                    # .strip() removes whitespace — if both are empty after stripping, the user didn't enter anything useful
            st.warning("Please enter either a conference name or a division name.")                      # st.warning shows a yellow banner to prompt the user to provide input
        else:
            input_params = {}                                                                            # build a dictionary of parameters to send to the API
            input_params["conference_name"] = conference_name.strip()                                   # add the conference — the API will use this to filter results
            input_params["division_name"] = division_name.strip()                                       # add the division — the API will use this to further filter results
            df = fetch_data("get_teams_by_conference_division/", input_params)                          # send the request to the API and get back a DataFrame of matching teams

            if df is not None and not df.empty:                                                          # check that we actually got results before trying to display them
                st.subheader(f"Teams in conference {conference_name}, division {division_name}:")       # display a smaller header above the results table
                st.dataframe(df, use_container_width=True, hide_index=True)                             # render the DataFrame as an interactive table — hide_index removes the default row numbers
            else:
                st.info(f"No teams found in the same conference and division as {conference_name} - {division_name}. Please check the names and try again.")  # st.info shows a blue banner when there are no results to display
    