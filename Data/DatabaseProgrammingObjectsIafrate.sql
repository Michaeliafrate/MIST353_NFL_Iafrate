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

CREATE OR ALTER PROCEDURE procGetTeamsByConferenceDivision
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

GO

CREATE OR ALTER PROCEDURE procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
    @TeamName NVARCHAR(50)
AS
BEGIN
    SELECT t.TeamName, cd.Conference, cd.Division
    FROM Team t
    JOIN ConferenceDivision cd ON t.ConferenceDivisionID = cd.ConferenceDivisionID
    WHERE cd.ConferenceDivisionID = (
        SELECT cd2.ConferenceDivisionID
        FROM Team t2
        JOIN ConferenceDivision cd2 ON t2.ConferenceDivisionID = cd2.ConferenceDivisionID
        WHERE t2.TeamName = @TeamName
    )
    AND t.TeamName != @TeamName;
END;

GO

CREATE OR ALTER PROCEDURE procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    SELECT T.TeamName, CD.Conference, CD.Division, T.TeamColors, FT.PrimaryTeam
    FROM NFLFan F
        INNER JOIN FanTeam FT ON F.NFLFanID = FT.NFLFanID
        INNER JOIN Team T ON FT.TeamID = T.TeamID
        INNER JOIN ConferenceDivision CD ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE F.NFLFanID = @NFLFanID;
END;

GO

CREATE OR ALTER PROCEDURE procScheduleGame
(
    @HomeTeamID    INT,
    @AwayTeamID    INT,
    @GameRound     NVARCHAR(50),
    @GameDate      DATE,
    @GameStartTime TIME,
    @StadiumID     INT,
    @NFLAdminID    INT -- the logged-in admin who is scheduling the game
)
AS
BEGIN
    -- Store the NFLAdminID in context so that the trigger can access it when inserting into AdminChangesTracker
    DECLARE @context VARBINARY(128) = CAST(@NFLAdminID AS VARBINARY(128));
    SET context_info @context;

    INSERT INTO Game (HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID)
    VALUES (@HomeTeamID, @AwayTeamID, @GameRound, @GameDate, @GameStartTime, @StadiumID);
END;

GO

CREATE OR ALTER TRIGGER trgTrackChangesOnSchedulingGame
ON Game
AFTER INSERT
AS
BEGIN
    DECLARE @NFLAdminID        INT;
    DECLARE @GameID            INT;
    DECLARE @ChangeType        NVARCHAR(50);
    DECLARE @ChangeDescription NVARCHAR(500);
    DECLARE @GameRound         NVARCHAR(50);
    DECLARE @GameDate          DATE;
    DECLARE @GameStartTime     TIME;
    DECLARE @HomeTeamID        INT;
    DECLARE @AwayTeamID        INT;
    DECLARE @HomeTeamName      NVARCHAR(50);
    DECLARE @AwayTeamName      NVARCHAR(50);
    DECLARE @StadiumID         INT;
    DECLARE @StadiumName       NVARCHAR(100);
    DECLARE @AdminFullName     NVARCHAR(100);

    -- get the NFLAdminID from context
    SET @NFLAdminID = CONVERT(INT, CONVERT(BINARY(4), context_info()));

    -- get the details of the newly inserted game
    SELECT @GameID = GameID, @GameRound = GameRound, @GameDate = GameDate,
           @GameStartTime = GameStartTime, @HomeTeamID = HomeTeamID,
           @AwayTeamID = AwayTeamID, @StadiumID = StadiumID
    FROM inserted;

    SELECT @HomeTeamName  = TeamName                    FROM Team    WHERE TeamID   = @HomeTeamID;
    SELECT @AwayTeamName  = TeamName                    FROM Team    WHERE TeamID   = @AwayTeamID;
    SELECT @StadiumName   = StadiumName                 FROM Stadium WHERE StadiumID = @StadiumID;
    SELECT @AdminFullName = Firstname + ' ' + Lastname  FROM AppUser WHERE AppUserID = @NFLAdminID;

    SET @ChangeType = 'Insert';
    SET @ChangeDescription = @AdminFullName + ' scheduled a new game with GameID ' + CAST(@GameID AS NVARCHAR(50))
        + ': ' + @HomeTeamName + ' vs ' + @AwayTeamName + ' on ' + CAST(@GameDate AS NVARCHAR(50))
        + ' at ' + CAST(@GameStartTime AS NVARCHAR(50)) + ' in stadium ' + @StadiumName
        + '. Game round: ' + @GameRound;

    INSERT INTO AdminChangesTracker (NFLAdminID, GameID, ChangeType, ChangeDescription)
    VALUES (@NFLAdminID, @GameID, @ChangeType, @ChangeDescription);
END;
