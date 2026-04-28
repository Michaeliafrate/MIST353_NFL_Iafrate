import streamlit as st
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():

    if "app_user_id" not in st.session_state:
        st.warning("Please log in first using the Validate User page.")
        return

    fan_name = st.session_state.app_user_fullname
    st.header(f"Teams associated with {fan_name}")

    input_parameters = {}
    fan_id  = st.text_input("Fan ID", value=st.session_state.app_user_id, disabled=True)
    input_parameters["fan_id"] = fan_id

    df = fetch_data("get_teams_for_specified_fan/", input_parameters)

    if df is not None and not df.empty:
        st.dataframe(df, use_container_width=True, hide_index=True)
    else:
        st.info("No teams found for the specified fan.")
