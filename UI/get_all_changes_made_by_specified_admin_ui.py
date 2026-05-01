import streamlit as st
from fetch_data import get_data

def get_all_changes_made_by_specified_admin_ui():
    st.header("All Changes Made By Admin")

    parameters = {"nfl_admin_id": st.session_state.app_user_id}
    df = get_data("get_all_changes_made_by_specified_admin/", parameters)

    if df is not None and not df.empty:
        st.subheader(f"Changes made by {st.session_state.app_user_fullname}:")
        st.dataframe(df, use_container_width=True, hide_index=True)
    else:
        st.info("No changes found for this admin.")
