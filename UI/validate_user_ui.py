import streamlit as st
from fetch_data import fetch_data


def validate_user_ui():

    st.header("Validate User")

    email = st.text_input("Enter Email")
    password_hash = st.text_input("Enter Password", type="password")

    if st.button("Validate User"):
        input_params = {}
        if not email.strip():
            st.error("Email is required.")
        else:
            input_params["email"] = email.strip()
        if not password_hash.strip():
            st.error("Password is required.")
        else:
            input_params["password_hash"] = password_hash.strip()

        # define fetch_data function and call it with input_params
        df = fetch_data("validate_user/", input_params)

        if df is not None and not df.empty:
            st.subheader(f"User {email} is valid:")
            st.dataframe(df, use_container_width=True, hide_index=True)
            st.session_state.app_user_id = df["AppUserID"].values[0]
            st.session_state.app_user_fullname = df["Fullname"].values[0]
        else:
            st.info(f"User {email} is not valid. Please check the inputs and try again.")