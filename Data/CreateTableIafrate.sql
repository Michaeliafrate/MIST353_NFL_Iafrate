IF OBJECT_ID('FanTeam', 'U') IS NOT NULL
    DROP TABLE FanTeam;
GO

IF OBJECT_ID('NFLAdmin', 'U') IS NOT NULL
    DROP TABLE NFLAdmin;
GO

IF OBJECT_ID('NFLFan', 'U') IS NOT NULL
    DROP TABLE NFLFan;
GO

IF OBJECT_ID('Team', 'U') IS NOT NULL
    DROP TABLE Team;
GO

IF OBJECT_ID('ConferenceDivision', 'U') IS NOT NULL
    DROP TABLE ConferenceDivision;
GO

IF OBJECT_ID('AppUser', 'U') IS NOT NULL
    DROP TABLE AppUser;
GO

CREATE TABLE ConferenceDivision (
    CDID        INT PRIMARY KEY,
    Conference  VARCHAR(20) NOT NULL,
    Division    VARCHAR(20) NOT NULL
);
GO

CREATE TABLE Team (
    TID      INT PRIMARY KEY,
    TName    VARCHAR(20) NOT NULL,
    TCity    VARCHAR(20) NOT NULL,
    TColor   VARCHAR(20),
    CDID     INT,
    FOREIGN KEY (CDID) REFERENCES ConferenceDivision(CDID)
);
GO

CREATE TABLE AppUser (
    AppUserID       INT IDENTITY(1,1) PRIMARY KEY,
    Firstname       NVARCHAR(50) NOT NULL,
    Lastname        NVARCHAR(50) NOT NULL,
    Email           NVARCHAR(100) NOT NULL,
    PhoneNumber     NVARCHAR(20),
    PasswordHash    VARBINARY(200) NOT NULL,
    UserRole        NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE NFLFan (
    NFLFanID    INT PRIMARY KEY REFERENCES AppUser(AppUserID)
);
GO

CREATE TABLE NFLAdmin (
    NFLAdminID  INT PRIMARY KEY REFERENCES AppUser(AppUserID)
);
GO

CREATE TABLE FanTeam (
    NFLFanID    INT NOT NULL REFERENCES NFLFan(NFLFanID),
    TeamID      INT NOT NULL REFERENCES Team(TID),
    PrimaryTeam BIT NOT NULL DEFAULT 0,
    PRIMARY KEY (NFLFanID, TeamID)
);
GO

IF OBJECT_ID('procGetTeamsByConferenceDivision', 'P') IS NOT NULL
    DROP PROCEDURE procGetTeamsByConferenceDivision;
GO

CREATE PROCEDURE procGetTeamsByConferenceDivision
    @ConferenceName VARCHAR(20) = NULL,
    @DivisionName   VARCHAR(20) = NULL
AS
BEGIN
    SELECT t.TName AS TeamName, cd.Conference, cd.Division, t.TColor AS TeamColors
    FROM Team t
    JOIN ConferenceDivision cd ON t.CDID = cd.CDID
    WHERE (@ConferenceName IS NULL OR cd.Conference = @ConferenceName)
      AND (@DivisionName   IS NULL OR cd.Division   = @DivisionName);
END;
GO
