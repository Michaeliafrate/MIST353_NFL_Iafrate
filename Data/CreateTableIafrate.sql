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
