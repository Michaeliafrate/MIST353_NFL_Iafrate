import streamlit as st                                                                   # streamlit is imported here so we can display error messages directly in the UI if something goes wrong
import requests                                                                          # requests is a Python library for making HTTP calls — this is how the UI talks to the FastAPI backend
import pandas as pd                                                                      # pandas lets us store and display table data — we convert the API response into a DataFrame for easy rendering

FASTAPI_URL = "https://mist353-api-iafrate.azurewebsites.net" #"http://localhost:8000"  # Adjust if your API is hosted elsewhere

def fetch_data(endpoint: str, input_params: dict, method: str = "GET"):                 # this is a reusable helper — any UI page can call this instead of writing its own request logic
    if method == "GET":                                                                  # GET is the standard HTTP method for retrieving data without changing anything on the server
        response = requests.get(f"{FASTAPI_URL}/{endpoint}", params=input_params)       # the params dict is automatically converted to URL query parameters (e.g. ?team_name=Steelers)
    elif method == "POST":
        response = requests.post(f"{FASTAPI_URL}/{endpoint}", json=input_params)

    if response.status_code == 200:                                                      # status code 200 means the request succeeded — anything else means something went wrong
        payload = response.json()                                                        # parse the JSON body of the response into a Python dictionary
        rows = payload.get("data", [])                                                   # our API always returns results under a "data" key — get() safely returns an empty list if it's missing
        df = pd.DataFrame(rows)                                                          # convert the list of dictionaries into a DataFrame so Streamlit can render it as a table
        return df                                                                         # return the DataFrame to the calling UI function
    else:
        st.error(f"Error fetching data: {response.status_code}")                        # show an error banner in the UI so the user knows something went wrong
        return None

def post_data(endpoint: str, input_params: dict, method: str = "POST") -> dict:
    if method == "POST":
        response = requests.post(f"{FASTAPI_URL}/{endpoint}", params=input_params)

    if response.status_code == 200:
        return response.json()
    else:
        st.error(f"Error posting data: {response.status_code}")
        return {"status_message": f"Error occurred: {response.status_code}"}
