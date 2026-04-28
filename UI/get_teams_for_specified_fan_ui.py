import streamlit as st
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
    st.header("Get Teams for Specified Fan")

    if "app_user_id" not in st.session_state:                                              # check if the user has logged in yet
        st.warning("Please log in first using the Validate User page.")                    # prompt them to log in if session state has no user ID
        return                                                                             # stop here — nothing else should run without a valid user

    fan_id = st.session_state.app_user_id                                                  # pull the user ID saved during login — no need to ask again
    fullname = st.session_state.get("app_user_fullname", f"Fan {fan_id}")                  # get the full name if available, otherwise fall back to the ID
    st.info(f"Fetching teams for: {fullname}")                                             # show the user who they are logged in as

    if st.button("Fetch Teams"):
        input_params = {"fan_id": int(fan_id)}
        df = fetch_data("get_teams_for_specified_fan/", input_params)

        if df is not None and not df.empty:
            st.subheader(f"Teams for {fullname}:")
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.info(f"No teams found for {fullname}. Please check your account and try again.")
