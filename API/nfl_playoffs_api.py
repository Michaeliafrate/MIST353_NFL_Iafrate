from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
from get_teams_by_conference_division import get_teams_by_conference_division

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Team(BaseModel):
    TeamName: str
    Conference: str
    Division: str
    TeamColors: str

class TeamsResponse(BaseModel):
    data: List[Team]

@app.get("/teams", response_model=TeamsResponse, responses={500: {"description": "Internal server error"}})
def read_teams(conference: str = None, division: str = None):
    try:
        return get_teams_by_conference_division(conference, division)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
