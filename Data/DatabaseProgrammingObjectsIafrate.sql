IF OBJECT_ID('procValidateUser', 'P') IS NOT NULL
    DROP PROCEDURE procValidateUser;
GO

CREATE PROCEDURE procValidateUser
(
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(200)
)
AS
BEGIN
    SELECT AppUserID, Firstname + ' ' + Lastname AS Fullname, UserRole
    FROM AppUser
    WHERE Email = @Email AND
    PasswordHash = CONVERT(VARBINARY(200), @PasswordHash, 1);
END;
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

IF OBJECT_ID('procGetTeamsInSameConferenceDivisionAsSpecifiedTeam', 'P') IS NOT NULL
    DROP PROCEDURE procGetTeamsInSameConferenceDivisionAsSpecifiedTeam;
GO

CREATE PROCEDURE procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
    @TeamName VARCHAR(20)
AS
BEGIN
    SELECT t.TName AS TeamName, cd.Conference, cd.Division
    FROM Team t
    JOIN ConferenceDivision cd ON t.CDID = cd.CDID
    WHERE cd.CDID = (
        SELECT cd2.CDID
        FROM Team t2
        JOIN ConferenceDivision cd2 ON t2.CDID = cd2.CDID
        WHERE t2.TName = @TeamName
    )
    AND t.TName != @TeamName;
END;
GO

IF OBJECT_ID('procValidateUser', 'P') IS NOT NULL
    DROP PROCEDURE procValidateUser;
GO

CREATE OR ALTER PROCEDURE procValidateUser
(
    @Email        NVARCHAR(100),
    @PasswordHash NVARCHAR(200)
)
AS
BEGIN
    SELECT
        AppUserID,
        Firstname + ' ' + Lastname AS Fullname,
        UserRole
    FROM AppUser
    WHERE Email        = @Email
      AND PasswordHash = CONVERT(VARBINARY(200), @PasswordHash, 1);
END;

GO

CREATE OR ALTER PROCEDURE procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    SELECT T.TeamName, CD.Conference, CD.Division, T.TeamColors
    FROM NFLFan F
        INNER JOIN Team T
        ON F.NFLFanID = T.TeamID
        INNER JOIN ConferenceDivision CD
        ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE F.NFLFanID = @NFLFanID;
END;

