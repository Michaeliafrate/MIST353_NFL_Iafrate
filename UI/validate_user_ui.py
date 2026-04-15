import streamlit as st                                                                    # streamlit is the library that builds the web page
from fetch_data import fetch_data                                                         # fetch_data is our helper function that sends requests to the API


def validate_user_ui():

    st.header("Validate User")                                                           # displays a large header at the top of this section

    email = st.text_input("Enter Email")                                                 # creates a text box where the user types their email
    password_hash = st.text_input("Enter Password", type="password")                    # creates a password box — type="password" hides the characters as dots

    if st.button("Validate User"):                                                       # everything inside here only runs when the button is clicked
        input_params = {}                                                                # create an empty dictionary to store the values we will send to the API
        if not email.strip():                                                            # .strip() removes extra spaces — if nothing is left, the field was blank
            st.error("Email is required.")                                               # show a red error message if email is missing
        else:
            input_params["email"] = email.strip()                                       # add the email to the dictionary so it gets sent to the API
        if not password_hash.strip():                                                    # check if the password field was also left blank
            st.error("Password is required.")                                            # show a red error message if password is missing
        else:
            input_params["password_hash"] = password_hash.strip()                      # add the password to the dictionary so it gets sent to the API

        df = fetch_data("validate_user/", input_params)                                 # send the email and password to the API and get back the result as a table

        if df is not None and not df.empty:                                              # if we got results back, the user exists in the database
            st.subheader(f"User {email} is valid:")                                     # show a success message with the user's email
            st.dataframe(df, use_container_width=True, hide_index=True)                 # display the user's info in a table — hide_index removes the row numbers
            st.session_state.app_user_id = df["AppUserID"].values[0]                   # save the user's ID to session state so other pages can use it later
            st.session_state.app_user_fullname = df["Fullname"].values[0]              # save the user's full name to session state so other pages can use it later
        else:
            st.info(f"User {email} is not valid. Please check the inputs and try again.")  # show a blue message if no matching user was found
