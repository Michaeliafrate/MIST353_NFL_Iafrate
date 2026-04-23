insert into ConferenceDivision (Conference, Division)
values ('AFC', 'North'),
       ('AFC', 'South'),
       ('AFC', 'East'),
       ('AFC', 'West'),
       ('NFC', 'North'),
       ('NFC', 'South'),
       ('NFC', 'East'),
       ('NFC', 'West');

GO
--select * from ConferenceDivision order by ConferenceDivisionID;

GO
insert into Team (TeamName, TeamCityState, TeamColors, ConferenceDivisionID)
VALUES
('Baltimore Ravens', 'Baltimore, MD', 'Purple, Black, Metallic Gold', 1),
('Cincinnati Bengals', 'Cincinnati, OH', 'Black, Orange, White', 1),
('Cleveland Browns', 'Cleveland, OH', 'Brown, Orange, White', 1),
('Pittsburgh Steelers', 'Pittsburgh, PA', 'Black, Gold, White', 1),

('Houston Texans', 'Houston, TX', 'Deep Steel Blue, Battle Red, Liberty White', 2),
('Indianapolis Colts', 'Indianapolis, IN', 'Speed Blue, White', 2),
('Jacksonville Jaguars', 'Jacksonville, FL', 'Teal, Black, Gold, White', 2),
('Tennessee Titans', 'Nashville, TN', 'Titans Navy, Titans Blue, Red, Silver', 2),

('Buffalo Bills', 'Buffalo, NY', 'Royal Blue, Red, White', 3),
('Miami Dolphins', 'Miami, FL', 'Aqua Green, Orange, White', 3),
('New England Patriots', 'Foxborough, MA', 'Navy Blue, Red, Silver, White', 3),
('New York Jets', 'East Rutherford, NJ', 'Gotham Green, Spotlight White, Stealth Black', 3),

('Denver Broncos', 'Denver, CO', 'Broncos Orange, Navy Blue, White', 4),
('Kansas City Chiefs', 'Kansas City, MO', 'Red, Gold, White', 4),
('Las Vegas Raiders', 'Las Vegas, NV', 'Silver and Black', 4),
('Los Angeles Chargers', 'Los Angeles, CA', 'Powder Blue, Sunshine Gold, White', 4),

('Chicago Bears', 'Chicago, IL', 'Navy Blue, Orange, White', 5),
('Detroit Lions', 'Detroit, MI', 'Honolulu Blue, Silver, White', 5),
('Green Bay Packers', 'Green Bay, WI', 'Dark Green, Gold, White', 5),
('Minnesota Vikings', 'Minneapolis, MN', 'Purple, Gold, White', 5),

('Atlanta Falcons', 'Atlanta, GA', 'Red, Black, Silver, White', 6),
('Carolina Panthers', 'Charlotte, NC', 'Black, Panther Blue, Silver, White', 6),
('New Orleans Saints', 'New Orleans, LA', 'Old Gold, Black, White', 6),
('Tampa Bay Buccaneers', 'Tampa Bay, FL', 'Red, Pewter, Black, Orange, White', 6),

('Dallas Cowboys', 'Dallas, TX', 'Navy Blue, Metallic Silver, White', 7),
('New York Giants', 'East Rutherford, NJ', 'Royal Blue, Red, White', 7),
('Philadelphia Eagles', 'Philadelphia, PA', 'Midnight Green, Silver Metallic, Black Metallic, White', 7),
('Washington Commanders', 'Washington D.C.', 'Burgundy, Gold', 7),

('Arizona Cardinals', 'Phoenix, AZ', 'Red, Black, White', 8),
('Los Angeles Rams', 'Los Angeles, CA', 'Royal Blue, Silver, Gold', 8),
('San Francisco 49ers', 'San Francisco, CA', 'Scarlet, Gold', 8),
('Seattle Seahawks', 'Seattle, WA', 'College Navy, Action Green', 8);

-- select * from Team order by TeamID;

GO

insert into AppUser (Firstname, Lastname, Email, PhoneNumber, PasswordHash, UserRole)
VALUES
('Tom', 'Brady', 'tom.brady@example.com', '555-1234', 0x01, N'NFLFan'),
('Aaron', 'Rodgers', 'aaron.rodgers@example.com', '555-9012', 0x01, N'NFLFan'),
('Drew', 'Brees', 'drew.brees@example.com', '555-2222', 0x01, N'NFLFan'),
('Patrick', 'Mahomes', 'patrick.mahomes@example.com', '555-7890', 0x01, N'NFLFan'),

('Bill', 'Belichick', 'bill.belichick@example.com', '555-5678', 0x01, N'NFLAdmin'),
('Sean', 'McVay', 'sean.mcay@example.com', '555-3456', 0x01, N'NFLAdmin'),
('Mike', 'Tomlin', 'mike.tomlin@example.com', '555-1111', 0x01, N'NFLAdmin'),
('Andy', 'Reid', 'andy.reid@example.com', '555-3333', 0x01, N'NFLAdmin');

GO

insert into NFLFan (NFLFanID)
VALUES
(1),
(2),
(3),
(4);

GO

insert into NFLAdmin (NFLAdminID)
VALUES
(5),
(6),
(7),
(8);

GO

insert into FanTeam (NFLFanID, TeamID, PrimaryTeam)
VALUES
(1, 11, 1),
(1, 24, 0), -- Tom Brady is a fan of New England Patriots and Tampa Bay Buccaneers, but Patriots is his primary team
(2, 19, 1),
(2, 12, 0),
(2, 4, 0),-- Aaron Rodgers is a fan of Green Bay Packers, New York Jets, and Pittsburgh Steelers, but Packers is his primary team
(3, 3, 1), -- Drew Brees is a fan New Orleans Saints (primary) and Los Angeles Chargers
(3, 16, 0),
(4, 14, 1); -- Patrick Mahomes is a fan of Kansas City Chiefs (primary)

go

INSERT INTO Stadium (StadiumName, StadiumCityState, Capacity) VALUES
('M&T Bank Stadium', 'Baltimore, MD', 71008),
('Paycor Stadium', 'Cincinnati, OH', 65515),
('Huntington Bank Field', 'Cleveland, OH', 67431),
('Acrisure Stadium', 'Pittsburgh, PA', 68400),
('NRG Stadium', 'Houston, TX', 72220),
('Lucas Oil Stadium', 'Indianapolis, IN', 67000),
('EverBank Stadium', 'Jacksonville, FL', 62000),
('Nissan Stadium', 'Nashville, TN', 69143),
('Geodis Park', 'Nashville, TN', 30000), -- Titans temporary while Nissan demolished/rebuilt
('Highmark Stadium', 'Orchard Park, NY', 71608),
('Gillette Stadium', 'Foxborough, MA', 65878),
('MetLife Stadium', 'East Rutherford, NJ', 82500), -- Giants share with Jets
('Empower Field at Mile High', 'Denver, CO', 76125),
('GEHA Field at Arrowhead Stadium', 'Kansas City, MO', 76416),
('Allegiant Stadium', 'Las Vegas, NV', 65000),
('SoFi Stadium', 'Inglewood, CA', 70240), --Rams share with Chargers
('Soldier Field', 'Chicago, IL', 61500),
('Ford Field', 'Detroit, MI', 65000),
('Lambeau Field', 'Green Bay, WI', 81441),
('U.S. Bank Stadium', 'Minneapolis, MN', 66860),
('Mercedes-Benz Stadium', 'Atlanta, GA', 71000),
('Bank of America Stadium', 'Charlotte, NC', 74867),
('Caesars Superdome', 'New Orleans, LA', 73208),
('Raymond James Stadium', 'Tampa, FL', 69218),
('AT&T Stadium', 'Arlington, TX', 80000),
('Lincoln Financial Field', 'Philadelphia, PA', 69796),
('Northwest Stadium', 'Landover, MD', 67617),
('State Farm Stadium', 'Glendale, AZ', 63400),
('Levi''s Stadium', 'Santa Clara, CA', 68500),
('Lumen Field', 'Seattle, WA', 69000),
('Oakland Coliseum', 'Oakland, CA', 56057), -- Raiders immediate past
('Jack Murphy/Qualcomm Stadium', 'San Diego, CA', 70561), -- Chargers immediate past
('Hard Rock Stadium', 'Miami Gardens, FL', 65300);

-- select * from Stadium order by StadiumID;

go

INSERT INTO TeamStadium
(TeamID, StadiumID, StartYear, EndYear)
VALUES
-- Baltimore Ravens
(1, 1, 1998, NULL),
-- Cincinnati Bengals
(2, 2, 2000, NULL),
-- Cleveland Browns
(3, 3, 1999, NULL),
-- Pittsburgh Steelers
(4, 4, 2001, NULL),
-- Houston Texans
(5, 5, 2002, NULL),
-- Indianapolis Colts
(6, 6, 2008, NULL),
-- Jacksonville Jaguars
(7, 7, 1995, NULL),
-- Tennessee Titans (Nissan Stadium, now being replaced)
(8, 8, 1999, 2026),
-- Tennessee Titans (temporary home at Geodis Park while new stadium is built)
(8, 9, 2027, NULL),
-- Buffalo Bills
(9, 10, 2026, NULL),
-- New England Patriots
(11, 11, 2002, NULL),
-- New York Jets (MetLife)
(12, 12, 2010, NULL),
-- Denver Broncos
(13, 13, 2001, NULL),
-- Kansas City Chiefs
(14, 14, 1972, NULL),
-- Las Vegas Raiders (Allegiant)
(15, 15, 2020, NULL),
-- Las Vegas Raiders immediate past (Oakland Coliseum)
(15, 31, 1966, 2019),
-- Los Angeles Chargers (SoFi)
(16, 16, 2020, NULL),
-- Los Angeles Chargers immediate past (Qualcomm/StubHub)
(16, 32, 1967, 2016),
-- Chicago Bears
(17, 17, 1971, NULL),
-- Detroit Lions
(18, 18, 2002, NULL),
-- Green Bay Packers
(19, 19, 1957, NULL),
-- Minnesota Vikings
(20, 20, 2016, NULL),
-- Atlanta Falcons
(21, 21, 2017, NULL),
-- Carolina Panthers
(22, 22, 1996, NULL),
-- New Orleans Saints
(23, 23, 1975, NULL),
-- Tampa Bay Buccaneers
(24, 24, 1998, NULL),
-- Dallas Cowboys
(25, 25, 2009, NULL),
-- New York Giants (MetLife)
(26, 12, 2010, NULL),
-- Philadelphia Eagles
(27, 26, 2003, NULL),
-- Washington Commanders
(28, 27, 1997, NULL),
-- Arizona Cardinals
(29, 28, 2006, NULL),
-- Los Angeles Rams (SoFi)
(30, 16, 2020, NULL),
-- San Francisco 49ers
(31, 29, 2014, NULL),
-- Seattle Seahawks
(32, 30, 2002, NULL),
-- Miami Dolphins
(10, 33, 1987, NULL);

GO

DISABLE TRIGGER trgTrackChangesOnSchedulingGame ON Game;

INSERT INTO Game (GameRound, GameDate, GameStartTime, HomeTeamID, AwayTeamID, StadiumID, HomeTeamScore, AwayTeamScore, WinningTeamID)
VALUES
    ('Wild Card',  '2026-01-10', '16:30:00', 22, 30, 22, 31, 34, 30),
    ('Wild Card',  '2026-01-10', '20:00:00', 17, 19, 17, 31, 27, 17),
    ('Wild Card',  '2026-01-11', '13:00:00',  7,  9,  7, 24, 27,  9),
    ('Wild Card',  '2026-01-11', '16:30:00', 27, 31, 26, 19, 23, 31),
    ('Wild Card',  '2026-01-11', '20:00:00', 11, 16, 11, 16,  3, 11),
    ('Wild Card',  '2026-01-12', '20:15:00',  4,  5,  4,  6, 30,  5),
    ('Divisional', '2026-01-17', '16:30:00', 13,  9, 13, 33, 30, 13),
    ('Divisional', '2026-01-17', '20:00:00', 32, 31, 30, 41,  6, 32),
    ('Divisional', '2026-01-18', '15:00:00', 11,  5, 11, 28, 16, 11),
    ('Divisional', '2026-01-18', '18:30:00', 17, 30, 17, 17, 20, 30);

ENABLE TRIGGER trgTrackChangesOnSchedulingGame ON Game;

go

INSERT INTO AdminChangesTracker (NFLAdminID, GameID, ChangeDateTime, ChangeType, ChangeDescription)
VALUES
    (5, 1,  '2026-04-23 02:12:19.480', 'Insert', 'Bill Belichick scheduled a new game with GameID 1: Carolina Panthers vs Los Angeles Rams on 2026-01-10 at 16:30:00.0000000 in stadium  Bank of America Stadium. Game round: Wild Card'),
    (6, 1,  '2026-04-23 02:12:23.730', 'Update', 'Scores updated by Sean McVay for GameID=1: Home=Carolina Panthers (31), Away=Los Angeles Rams (34), WinningTeam=Los Angeles Rams'),
    (6, 2,  '2026-04-23 02:12:28.960', 'Insert', 'Sean McVay scheduled a new game with GameID 2: Chicago Bears vs Green Bay Packers on 2026-01-10 at 20:00:00.0000000 in stadium  Soldier Field. Game round: Wild Card'),
    (7, 2,  '2026-04-23 02:12:33.177', 'Update', 'Scores updated by Mike Tomlin for GameID=2: Home=Chicago Bears (31), Away=Green Bay Packers (27), WinningTeam=Chicago Bears'),
    (7, 3,  '2026-04-23 02:12:37.827', 'Insert', 'Mike Tomlin scheduled a new game with GameID 3: Jacksonville Jaguars vs Buffalo Bills on 2026-01-11 at 13:00:00.0000000 in stadium  EverBank Stadium. Game round: Wild Card'),
    (8, 3,  '2026-04-23 02:12:41.863', 'Update', 'Scores updated by Andy Reid for GameID=3: Home=Jacksonville Jaguars (24), Away=Buffalo Bills (27), WinningTeam=Buffalo Bills'),
    (8, 4,  '2026-04-23 02:12:47.003', 'Insert', 'Andy Reid scheduled a new game with GameID 4: Philadelphia Eagles vs San Francisco 49ers on 2026-01-11 at 16:30:00.0000000 in stadium  Lincoln Financial Field. Game round: Wild Card'),
    (5, 4,  '2026-04-23 02:12:50.723', 'Update', 'Scores updated by Bill Belichick for GameID=4: Home=Philadelphia Eagles (19), Away=San Francisco 49ers (23), WinningTeam=San Francisco 49ers'),
    (5, 5,  '2026-04-23 02:12:56.920', 'Insert', 'Bill Belichick scheduled a new game with GameID 5: New England Patriots vs Los Angeles Chargers on 2026-01-11 at 20:00:00.0000000 in stadium  Gillette Stadium. Game round: Wild Card'),
    (6, 5,  '2026-04-23 02:13:00.540', 'Update', 'Scores updated by Sean McVay for GameID=5: Home=New England Patriots (16), Away=Los Angeles Chargers (3), WinningTeam=New England Patriots'),
    (6, 6,  '2026-04-23 02:13:05.570', 'Insert', 'Sean McVay scheduled a new game with GameID 6: Pittsburgh Steelers vs Houston Texans on 2026-01-12 at 20:15:00.0000000 in stadium  Acrisure Stadium. Game round: Wild Card'),
    (7, 6,  '2026-04-23 02:13:08.947', 'Update', 'Scores updated by Mike Tomlin for GameID=6: Home=Pittsburgh Steelers (6), Away=Houston Texans (30), WinningTeam=Houston Texans'),
    (7, 7,  '2026-04-23 02:14:14.147', 'Insert', 'Mike Tomlin scheduled a new game with GameID 7: Denver Broncos vs Buffalo Bills on 2026-01-17 at 16:30:00.0000000 in stadium  Empower Field at Mile High. Game round: Divisional'),
    (8, 7,  '2026-04-23 02:14:18.237', 'Update', 'Scores updated by Andy Reid for GameID=7: Home=Denver Broncos (33), Away=Buffalo Bills (30), WinningTeam=Denver Broncos'),
    (7, 8,  '2026-04-23 02:14:24.417', 'Insert', 'Mike Tomlin scheduled a new game with GameID 8: Seattle Seahawks vs San Francisco 49ers on 2026-01-17 at 20:00:00.0000000 in stadium  Lumen Field. Game round: Divisional'),
    (7, 8,  '2026-04-23 02:14:28.410', 'Update', 'Scores updated by Mike Tomlin for GameID=8: Home=Seattle Seahawks (41), Away=San Francisco 49ers (6), WinningTeam=Seattle Seahawks'),
    (8, 9,  '2026-04-23 02:14:36.577', 'Insert', 'Andy Reid scheduled a new game with GameID 9: New England Patriots vs Houston Texans on 2026-01-18 at 15:00:00.0000000 in stadium  Gillette Stadium. Game round: Divisional'),
    (5, 9,  '2026-04-23 02:14:40.840', 'Update', 'Scores updated by Bill Belichick for GameID=9: Home=New England Patriots (28), Away=Houston Texans (16), WinningTeam=New England Patriots'),
    (6, 10, '2026-04-23 02:14:45.890', 'Insert', 'Sean McVay scheduled a new game with GameID 10: Chicago Bears vs Los Angeles Rams on 2026-01-18 at 18:30:00.0000000 in stadium  Soldier Field. Game round: Divisional'),
    (7, 10, '2026-04-23 02:14:49.420', 'Update', 'Scores updated by Mike Tomlin for GameID=10: Home=Chicago Bears (17), Away=Los Angeles Rams (20), WinningTeam=Los Angeles Rams');

GO

EXECUTE procschedulegame
    @hometeamid = 13,
    @awayteamid = 11,
    @gameround = 'Conference',
    @gamedate = '2026-01-25',
    @gamestarttime = '18:30:00',
    @stadiumid = 13,
    @nfladminid = 5;

-- select * from AdminChangesTracker
-- select * from Game
-- select N.NFLAdminID, U.Firstname, U.LastName from NFLAdmin N inner join APPUser U on N.NFLAdminID = U.AppUserID

-- =============================================
-- CONFERENCE CHAMPIONSHIPS  (January 25, 2026)
-- =============================================

-- AFC Championship: (2) New England Patriots at (1) Denver Broncos
-- Patriots win 10-7
/*
    @GameRound = 'Conference',
    @HomeTeamID = 13, -- Denver Broncos
    @AwayTeamID = 11, -- New England Patriots
    @GameDate = '2026-01-25',
    @GameStartTime = '15:00',
    @StadiumID = 13, -- Empower Field at Mile High
    @NFLAdminID = 5; -- Bill Belichick


    @GameID = 11,
    @HomeTeamScore = 7,
    @AwayTeamScore = 10,
    @NFLAdminID = 6; -- Sean McVay
*/


-- NFC Championship: (5) LA Rams at (1) Seattle Seahawks
-- Seahawks win 31-27
/*
    @GameRound = 'Conference',
    @HomeTeamID = 32, -- Seattle Seahawks
    @AwayTeamID = 30, -- LA Rams
    @GameDate = '2026-01-25',
    @GameStartTime = '18:30',
    @StadiumID = 30, -- Lumen Field
    @NFLAdminID = 6; -- Sean McVay

    @GameID = 12,
    @HomeTeamScore = 31,
    @AwayTeamScore = 27,
    @NFLAdminID = 7; -- Mike Tomlin
*/

-- =============================================
-- SUPER BOWL LX  (February 8, 2026)
-- Levi's Stadium, Santa Clara, CA (neutral site)
-- NFC designated home team per rotation
-- Seahawks win 29-13
-- =============================================

/*
    @GameRound = 'Super Bowl',
    @HomeTeamID = 32, -- Seattle Seahawks (NFC champion, designated home team)
    @AwayTeamID = 11, -- New England Patriots (AFC champion)
    @GameDate = '2026-02-08',
    @GameStartTime = '18:30',
    @StadiumID = 29, -- Levi's Stadium (neutral site)
    @NFLAdminID = 5; -- Bill Belichick

    @GameID = 13,
    @HomeTeamScore = 29,
    @AwayTeamScore = 13,
    @NFLAdminID = 8; -- Mike Tomlin

*/
