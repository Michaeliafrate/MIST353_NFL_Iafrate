INSERT INTO ConferenceDivision (CDID, Conference, Division) VALUES
(1, 'AFC', 'East'),
(2, 'AFC', 'North'),
(3, 'AFC', 'South'),
(4, 'AFC', 'West'),
(5, 'NFC', 'East'),
(6, 'NFC', 'North'),
(7, 'NFC', 'South'),
(8, 'NFC', 'West');

INSERT INTO Team (TID, TName, TCity, TColor, CDID) VALUES
(1, 'Bills', 'Buffalo', 'Blue', 1),
(2, 'Dolphins', 'Miami', 'Aqua', 1),
(3, 'Patriots', 'New England', 'Navy', 1),
(4, 'Jets', 'New York', 'Green', 1),

(5, 'Ravens', 'Baltimore', 'Purple', 2),
(6, 'Bengals', 'Cincinnati', 'Orange', 2),
(7, 'Browns', 'Cleveland', 'Brown', 2),
(8, 'Steelers', 'Pittsburgh', 'Black', 2),

(9, 'Texans', 'Houston', 'DeepSteel', 3),
(10, 'Colts', 'Indianapolis', 'Blue', 3),
(11, 'Jaguars', 'Jacksonville', 'Teal', 3),
(12, 'Titans', 'Tennessee', 'Navy', 3),

(13, 'Broncos', 'Denver', 'Orange', 4),
(14, 'Chiefs', 'Kansas City', 'Red', 4),
(15, 'Raiders', 'Las Vegas', 'Black', 4),
(16, 'Chargers', 'LA', 'PowderBlue', 4),

(17, 'Cowboys', 'Dallas', 'Navy', 5),
(18, 'Giants', 'New York', 'Blue', 5),
(19, 'Eagles', 'Philadelphia', 'Green', 5),
(20, 'Commanders', 'Washington', 'Burgundy', 5),

(21, 'Bears', 'Chicago', 'Navy', 6),
(22, 'Lions', 'Detroit', 'HonoluluBlue', 6),
(23, 'Packers', 'Green Bay', 'Green', 6),
(24, 'Vikings', 'Minnesota', 'Purple', 6),

(25, 'Falcons', 'Atlanta', 'Red', 7),
(26, 'Panthers', 'Carolina', 'Blue', 7),
(27, 'Saints', 'New Orleans', 'Gold', 7),
(28, 'Buccaneers', 'Tampa Bay', 'Red', 7),

(29, 'Cardinals', 'Arizona', 'Red', 8),
(30, 'Rams', 'LA', 'RoyalBlue', 8),
(31, '49ers', 'San Fran', 'Red', 8),
(32, 'Seahawks', 'Seattle', 'Navy', 8);
