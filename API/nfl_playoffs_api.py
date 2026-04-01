from fastapi import FastAPI                                                                          # FastAPI is a web framework that lets us create API endpoints using Python functions
from get_teams_by_conference_division import get_teams_by_conference_division                        # this function handles the database logic for filtering teams by conference/division
from get_teams_in_same_conference_division_as_specified_team import get_teams_in_same_conference_division_as_specified_team  # this function handles the database logic for finding rivals of a given team

app = FastAPI()                                                                                      # this creates the API — all endpoints are registered on this object

@app.get("/get_teams_by_conference_division")                                                        # this decorator tells FastAPI to listen for GET requests at this URL path
def get_teams_by_conference_division_api(conference_name: str = None, division_name: str = None):   # the URL parameters (e.g. ?conference_name=AFC) are automatically passed as arguments
    return get_teams_by_conference_division(conference=conference_name, division=division_name)      # we pass the URL parameters into the database function and return whatever it gives back

@app.get("/get_teams_in_same_conference_division_as_specified_team")                                 # second endpoint — listens for GET requests at this URL path
def get_teams_in_same_conference_division_as_specified_team_api(team_name: str):                    # team_name is required here — if it's missing, FastAPI will automatically return an error
    return get_teams_in_same_conference_division_as_specified_team(team_name=team_name)             # pass the team name into the database function and return the results
