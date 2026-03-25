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