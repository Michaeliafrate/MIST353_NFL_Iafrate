IF OBJECT_ID('Team', 'U') IS NOT NULL
    DROP TABLE Team;
GO

IF OBJECT_ID('ConferenceDivision', 'U') IS NOT NULL
    DROP TABLE ConferenceDivision;
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

IF OBJECT_ID('procGetTeamsByConferenceDivision', 'P') IS NOT NULL
    DROP PROCEDURE procGetTeamsByConferenceDivision;
GO

CREATE PROCEDURE procGetTeamsByConferenceDivision
    @ConferenceName VARCHAR(20) = NULL,
    @DivisionName   VARCHAR(20) = NULL
AS
BEGIN
    SELECT t.TID, t.TName, t.TCity, t.TColor, cd.Conference, cd.Division
    FROM Team t
    JOIN ConferenceDivision cd ON t.CDID = cd.CDID
    WHERE (@ConferenceName IS NULL OR cd.Conference = @ConferenceName)
      AND (@DivisionName   IS NULL OR cd.Division   = @DivisionName);
END;
GO
