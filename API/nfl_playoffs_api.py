from fastapi import FastAPI                                                                          # FastAPI is a web framework that lets us create API endpoints using Python functions
from get_teams_by_conference_division import get_teams_by_conference_division                        # this function handles the database logic for filtering teams by conference/division
from get_teams_in_same_conference_division_as_specified_team import get_teams_in_same_conference_division_as_specified_team  # this function handles the database logic for finding rivals of a given team
from validate_user import validate_user                                                              # this function handles the database logic for validating a user's credentials
from get_teams_for_specified_fan import get_teams_for_specified_fan                                  # this function handles the database logic for getting teams for a specified fan
from schedule_game import schedule_game
from datetime import date, time

app = FastAPI()                                                                                      # this creates the API — all endpoints are registered on this object

@app.get("/get_teams_by_conference_division")                                                        # this decorator tells FastAPI to listen for GET requests at this URL path
def get_teams_by_conference_division_api(conference_name: str = None, division_name: str = None):   # the URL parameters (e.g. ?conference_name=AFC) are automatically passed as arguments
    return get_teams_by_conference_division(conference=conference_name, division=division_name)      # we pass the URL parameters into the database function and return whatever it gives back

@app.get("/get_teams_in_same_conference_division_as_specified_team")                                 # second endpoint — listens for GET requests at this URL path
def get_teams_in_same_conference_division_as_specified_team_api(team_name: str):                    # team_name is required here — if it's missing, FastAPI will automatically return an error
    return get_teams_in_same_conference_division_as_specified_team(team_name=team_name)             # pass the team name into the database function and return the results

@app.get("/validate_user")                                                                          # third endpoint — listens for GET requests at this URL path
def validate_user_api(email: str, password_hash: str):                                             # email and password_hash are required query parameters
    return validate_user(email=email, password_hash=password_hash)                                 # pass credentials into the database function and return the results

@app.get("/get_teams_for_specified_fan")                                                            # fourth endpoint — listens for GET requests at this URL path
def get_teams_for_specified_fan_api(fan_id: int):                                                  # fan_id is a required integer query parameter
    return get_teams_for_specified_fan(fan_id=fan_id)                                              # pass the fan ID into the database function and return the results

@app.post("/schedule_game/")
def schedule_game_api(
        home_team_id: int,
        away_team_id: int,
        game_round: str,
        game_date: date,
        game_time: time,
        stadium_id: int,
        nfl_admin_id: int
):
    return schedule_game(
        home_team_id=home_team_id,
        away_team_id=away_team_id,
        game_round=game_round,
        game_date=game_date,
        game_time=game_time,
        stadium_id=stadium_id,
        nfl_admin_id=nfl_admin_id
    )
