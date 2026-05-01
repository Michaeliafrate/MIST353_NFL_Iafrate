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
    select T.TeamName, CD.Conference, CD.Division, T.TeamColors, FT.PrimaryTeam
    from FanTeam FT inner join Team T
        on FT.TeamID = T.TeamID
        inner join ConferenceDivision CD
        on T.ConferenceDivisionID = CD.ConferenceDivisionID
    where FT.NFLFanID = @NFLFanID;
END;

GO

create or alter procedure procScheduleGame
(
    @HomeTeamID INT,
    @AwayTeamID INT,
    @GameRound NVARCHAR(50),
    @GameDate DATE,
    @GameStartTime TIME,
    @StadiumID INT,
    @NFLAdminID INT  -- the logged-in admin who is scheduling the game
)
AS
BEGIN
    -- Store the NFLAdminID in context so that the trigger can access it when inserting into AdminChangesTracker
    declare @context VARBINARY(128) = cast(@NFLAdminID as VARBINARY(128)); -- int is only 4 bytes, but context_info can store up to 128 bytes, so we can store additional info in the future if needed
    SET context_info @context;

    insert into Game (HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID)
    values (@HomeTeamID, @AwayTeamID, @GameRound, @GameDate, @GameStartTime, @StadiumID);
END

/*
GameRound: 'Wild Card', HomeTeamID: 22, AwayTeamID: 30, GameDate: '2026-01-10', GameStartTime: '16:30', StadiumID: 22,
NFLAdminID for scheduling: 5 (Bill Belichick)

execute procScheduleGame
    @HomeTeamID = 22,
    @AwayTeamID = 30,
    @GameRound = 'Wild Card',
    @GameDate = '2026-01-10',
    @GameStartTime = '16:30',
    @StadiumID = 22,
    @NFLAdminID = 5;


GameRound: 'Wild Card', HomeTeamID: 17, AwayTeamID: 19, GameDate: '2026-01-10', GameStartTime: '20:00', StadiumID: 17,
NFLAdminID for scheduling: 6 (Sean McVay)

execute procScheduleGame
    @HomeTeamID = 17,
    @AwayTeamID = 19,
    @GameRound = 'Wild Card',
    @GameDate = '2026-01-10',
    @GameStartTime = '20:00',
    @StadiumID = 17,
    @NFLAdminID = 6;

delete from Game where GameID = 12;
select * from Game order by GameID desc;
select * from AdminChangesTracker order by AdminChangesTrackerID desc;

*/

GO

-- trigger to track changes made by NFLAdmin to the Game table
-- 1. triggering event (insert, update, delete) on Game table
-- 2. action: insert a record into AdminChangesTracker with NFLAdminID, GameID, ChangeType, ChangeDescription

create or alter trigger trgTrackChangesOnSchedulingGame
on Game
after insert
as
BEGIN
    declare @NFLAdminID INT;
    declare @GameID INT;
    declare @ChangeType NVARCHAR(50);
    declare @ChangeDescription NVARCHAR(500);
    declare @GameRound NVARCHAR(50);
    declare @GameDate DATE;
    declare @GameStartTime TIME;
    declare @HomeTeamID INT;
    declare @AwayTeamID INT;
    declare @HomeTeamName NVARCHAR(50);
    declare @AwayTeamName NVARCHAR(50);
    declare @StadiumID INT;
    declare @StadiumName NVARCHAR(100);
    declare @AdminFullName NVARCHAR(100);

    -- get the NFLAdminID from context
    set @NFLAdminID = convert(int, convert(binary(4), context_info()));

    -- get the GameID of the newly inserted game
    select @GameID = GameID, @GameRound = GameRound, @GameDate = GameDate, @GameStartTime = GameStartTime,
           @HomeTeamID = HomeTeamID, @AwayTeamID = AwayTeamID, @StadiumID = StadiumID
    from inserted;

    select @HomeTeamName = TeamName from Team where TeamID = @HomeTeamID;
    select @AwayTeamName = TeamName from Team where TeamID = @AwayTeamID;
    select @StadiumName = StadiumName from Stadium where StadiumID = @StadiumID;
    select @AdminFullName = Firstname + ' ' + Lastname from AppUser where AppUserID = @NFLAdminID;

    set @ChangeType = 'Insert';
    set @ChangeDescription = @AdminFullName + ' scheduled a new game with GameID ' + cast(@GameID as NVARCHAR(50))
        + ': ' + @HomeTeamName + ' vs ' + @AwayTeamName + ' on ' + cast(@GameDate as NVARCHAR(50))
        + ' at ' + cast(@GameStartTime as NVARCHAR(50)) + ' in stadium ' + @StadiumName
        + '. Game round: ' + @GameRound;

    insert into AdminChangesTracker (NFLAdminID, GameID, ChangeType, ChangeDescription)
    values (@NFLAdminID, @GameID, @ChangeType, @ChangeDescription);
END

GO

create or alter procedure procGetAllChangesMadeBySpecifiedAdmin
(
    @NFLAdminID INT
)
as
begin
    select ACT.ChangeDateTime, ACT.ChangeType, ACT.ChangeDescription,
    G.GameRound, G.GameDate, G.GameStartTime,
    HT.TeamName as HomeTeam, AT.TeamName as AwayTeam, S.StadiumName
    from AdminChangesTracker ACT inner join Game G
        on ACT.GameID = G.GameID
        inner join Team HT
        on G.HomeTeamID = HT.TeamID
        inner join Team AT
        on G.AwayTeamID = AT.TeamID
        inner join Stadium S
        on G.StadiumID = S.StadiumID
    where ACT.NFLAdminID = @NFLAdminID
    order by ACT.ChangeDateTime desc;
end

--execute procGetAllChangesMadeBySpecifiedAdmin @NFLAdminID = 5; -- Bill Belichick

GO

create or alter procedure procGetAllTeams
as
begin
    select TeamID, TeamName
    from Team
end
-- execute procGetAllTeams;

GO

create or alter procedure procGetAllStadiums
as
begin
    select StadiumID, StadiumName
    from Stadium
end
-- execute procGetAllStadiums;

GO

alter table Team
add TeamLogo VARBINARY(MAX);

GO

create or alter procedure procGetTeamsWithLogosForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    select T.TeamName, CD.Conference, CD.Division, T.TeamColors, FT.PrimaryTeam, T.TeamLogo
    from FanTeam FT inner join Team T
        on FT.TeamID = T.TeamID
        inner join ConferenceDivision CD
        on T.ConferenceDivisionID = CD.ConferenceDivisionID
    where FT.NFLFanID = @NFLFanID;
end
