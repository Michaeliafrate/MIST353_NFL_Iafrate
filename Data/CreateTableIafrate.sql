if(OBJECT_ID('procGetTeamsByConferenceDivision', 'P') is not null)
    drop procedure procGetTeamsByConferenceDivision;

if(OBJECT_ID('AdminChangesTracker') is not null)
    drop table AdminChangesTracker;
if(OBJECT_ID('TeamStadium') is not null)
    drop table TeamStadium;
if(OBJECT_ID('Game') is not null)
    drop table Game;
if(OBJECT_ID('Stadium') is not null)
    drop table Stadium;

if(OBJECT_ID('FanTeam') is not null)
    drop table FanTeam;
if(OBJECT_ID('Team') is not null)
    drop table Team;
if(OBJECT_ID('ConferenceDivision') is not null)
    drop table ConferenceDivision;
if(OBJECT_ID('NFLAdmin') is not null)
    drop table NFLAdmin;
if(OBJECT_ID('NFLFan') is not null)
    drop table NFLFan;
if(OBJECT_ID('AppUser') is not null)
    drop table AppUser;

go

create TABLE ConferenceDivision (
    ConferenceDivisionID INT identity(1,1)
        constraint PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        constraint CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        constraint CK_DivisionNames CHECK (Division IN ('East', 'North', 'South', 'West')),
    constraint UK_ConferenceDivision UNIQUE (Conference, Division)
);

go

create TABLE Team (
    TeamID INT identity(1,1)
        constraint PK_Team PRIMARY KEY,
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(100) NOT NULL,
    ConferenceDivisionID INT NOT NULL
        constraint FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceDivisionID)
);

GO

CREATE TABLE AppUser (
    AppUserID       INT IDENTITY(1,1)
        CONSTRAINT PK_AppUser PRIMARY KEY,
    Firstname        NVARCHAR(50)  NOT NULL,
    Lastname        NVARCHAR(50)  NOT NULL,
    Email           NVARCHAR(100)  NOT NULL
        CONSTRAINT UK_AppUser_Email UNIQUE,
    PhoneNumber     NVARCHAR(20)   NULL,
    PasswordHash    VARBINARY(256)  NOT NULL,
    UserRole        NVARCHAR(20)   NOT NULL
        CONSTRAINT CK_AppUser_UserRole CHECK (UserRole IN (N'NFLFan', N'NFLAdmin'))
);

GO

CREATE TABLE NFLFan (
    NFLFanID INT CONSTRAINT PK_NFLFan PRIMARY KEY,
    CONSTRAINT FK_NFLFan_AppUser FOREIGN KEY (NFLFanID)
        REFERENCES AppUser(AppUserID) ON DELETE CASCADE
);

GO

CREATE TABLE NFLAdmin (
    NFLAdminID INT CONSTRAINT PK_NFLAdmin PRIMARY KEY,
    CONSTRAINT FK_NFLAdmin_AppUser FOREIGN KEY (NFLAdminID)
        REFERENCES AppUser(AppUserID) ON DELETE CASCADE
);

GO

CREATE TABLE FanTeam (
    FanTeamID INT IDENTITY(1,1)
        constraint PK_FanTeam PRIMARY KEY,
    TeamID INT NOT NULL
        constraint FK_FanTeam_Team FOREIGN KEY REFERENCES Team(TeamID) ON DELETE CASCADE,
    NFLFanID INT NOT NULL
        constraint FK_FanTeam_NFLFan FOREIGN KEY REFERENCES NFLFan(NFLFanID) ON DELETE CASCADE,
    constraint UK_FanTeam UNIQUE (TeamID, NFLFanID),
    PrimaryTeam BIT NOT NULL
);

go

create table Stadium (
    StadiumID INT identity(1,1)
        constraint PK_Stadium PRIMARY KEY,
    StadiumName NVARCHAR(100) NOT NULL,
    StadiumCityState NVARCHAR(50) NOT NULL,
    Capacity INT NOT NULL
);

go

create table TeamStadium (
    TeamStadiumID INT identity(1,1)
        constraint PK_TeamStadium PRIMARY KEY,
    TeamID INT NOT NULL
        constraint FK_TeamStadium_Team FOREIGN KEY REFERENCES Team(TeamID),
    StadiumID INT NOT NULL
        constraint FK_TeamStadium_Stadium FOREIGN KEY REFERENCES Stadium(StadiumID),
    StartYear INT NOT NULL,
    EndYear INT NULL,
    constraint UK_TeamStadium UNIQUE (TeamID, StadiumID, StartYear)
);

go

create table Game (
    GameID INT identity(1,1)
        constraint PK_Game PRIMARY KEY,
    GameRound NVARCHAR(50) NOT NULL
        constraint CK_GameRound CHECK (GameRound IN ('Wild Card', 'Divisional', 'Conference', 'Super Bowl')),
    GameDate DATE NOT NULL,
    GameStartTime TIME NOT NULL,
    HomeTeamID INT NOT NULL
        constraint FK_Game_HomeTeam FOREIGN KEY REFERENCES Team(TeamID),
    AwayTeamID INT NOT NULL
        constraint FK_Game_AwayTeam FOREIGN KEY REFERENCES Team(TeamID),
    StadiumID INT NOT NULL
        constraint FK_Game_Stadium FOREIGN KEY REFERENCES Stadium(StadiumID),
    HomeTeamScore INT NULL,
    AwayTeamScore INT NULL,
    WinningTeamID INT NULL
        constraint FK_Game_WinningTeam FOREIGN KEY REFERENCES Team(TeamID),
    constraint CK_Game_Teams CHECK (HomeTeamID != AwayTeamID),
    constraint UK_Game UNIQUE (HomeTeamID, AwayTeamID, GameDate)
);

go

create table AdminChangesTracker (
    AdminChangesTrackerID INT identity(1,1)
        constraint PK_AdminChangesTracker PRIMARY KEY,
    NFLAdminID INT NOT NULL
        constraint FK_AdminChangesTracker_NFLAdmin FOREIGN KEY REFERENCES NFLAdmin(NFLAdminID),
    GameID INT NOT NULL
        constraint FK_AdminChangesTracker_Game FOREIGN KEY REFERENCES Game(GameID),
    ChangeDateTime DATETIME NOT NULL DEFAULT GETDATE(),
    ChangeType NVARCHAR(50) NOT NULL
        constraint CK_AdminChangesTracker_ChangeType CHECK (ChangeType IN (N'Insert', N'Update', N'Delete')),
    ChangeDescription NVARCHAR(500) NOT NULL
);

go

CREATE PROCEDURE procGetTeamsByConferenceDivision
    @ConferenceName NVARCHAR(50) = NULL,
    @DivisionName   NVARCHAR(50) = NULL
AS
BEGIN
    SELECT t.TeamName, cd.Conference, cd.Division, t.TeamColors
    FROM Team t
    JOIN ConferenceDivision cd ON t.ConferenceDivisionID = cd.ConferenceDivisionID
    WHERE (@ConferenceName IS NULL OR cd.Conference = @ConferenceName)
      AND (@DivisionName   IS NULL OR cd.Division   = @DivisionName);
END;
