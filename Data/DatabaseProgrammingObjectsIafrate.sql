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
    SELECT T.TName AS TeamName, CD.Conference, CD.Division, T.TColor AS TeamColors, FT.PrimaryTeam
    FROM NFLFan F
        INNER JOIN FanTeam FT ON F.NFLFanID = FT.NFLFanID
        INNER JOIN Team T ON FT.TeamID = T.TID
        INNER JOIN ConferenceDivision CD ON T.CDID = CD.CDID
    WHERE F.NFLFanID = @NFLFanID;
END;

