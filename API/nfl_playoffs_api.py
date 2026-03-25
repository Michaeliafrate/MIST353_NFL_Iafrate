from fastapi import FastAPI
from get_teams_by_conference_division import get_teams_by_conference_division
from get_teams_in_same_conference_division_as_specified_team import get_teams_in_same_conference_division_as_specified_team

app = FastAPI()

@app.get("/get_teams_by_conference_division")
def get_teams_by_conference_division_api(conference: str = None, division: str = None):
    return get_teams_by_conference_division(conference=conference, division=division)

@app.get("/get_teams_in_same_conference_division_as_specified_team")
def get_teams_in_same_conference_division_as_specified_team_api(team_name: str):
    return get_teams_in_same_conference_division_as_specified_team(team_name=team_name)
