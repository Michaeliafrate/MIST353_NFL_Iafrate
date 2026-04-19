import streamlit as st
from fetch_data import fetch_data

def get_teams_for_specified_fan_ui():
    st.header("Get Teams for Specified Fan")

    fan_id = st.number_input("Enter Fan ID", min_value=1, step=1)

    if st.button("Fetch Teams"):
        input_params = {"fan_id": int(fan_id)}
        df = fetch_data("get_teams_for_specified_fan/", input_params)

        if df is not None and not df.empty:
            st.subheader(f"Teams for Fan ID {int(fan_id)}:")
            st.dataframe(df, use_container_width=True, hide_index=True)
        else:
            st.info(f"No teams found for Fan ID {int(fan_id)}. Please check the ID and try again.")
