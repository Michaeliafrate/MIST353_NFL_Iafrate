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
