IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ipl_ticket_booking')
BEGIN
    CREATE DATABASE ipl_ticket_booking;
END
GO

USE ipl_ticket_booking;
GO

DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += N'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id))
    + '.' + QUOTENAME(OBJECT_NAME(parent_object_id)) 
    + ' DROP CONSTRAINT ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.foreign_keys;
EXEC sp_executesql @sql;
GO

IF OBJECT_ID('dbo.Payment', 'U') IS NOT NULL DROP TABLE dbo.Payment;
IF OBJECT_ID('dbo.Booking', 'U') IS NOT NULL DROP TABLE dbo.Booking;
IF OBJECT_ID('dbo.SeatDetails', 'U') IS NOT NULL DROP TABLE dbo.SeatDetails;
IF OBJECT_ID('dbo.StandDetails', 'U') IS NOT NULL DROP TABLE dbo.StandDetails;
IF OBJECT_ID('dbo.MatchDetails', 'U') IS NOT NULL DROP TABLE dbo.MatchDetails;
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users;
GO

CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Role NVARCHAR(20) NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20)
);

CREATE TABLE MatchDetails (
    MatchId INT IDENTITY(1,1) PRIMARY KEY,
    MatchName NVARCHAR(100) NOT NULL,
    TeamA NVARCHAR(50) NOT NULL,
    TeamB NVARCHAR(50) NOT NULL,
    Venue NVARCHAR(100) NOT NULL,
    MatchDate DATETIME NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Upcoming'
);

CREATE TABLE StandDetails (
    StandId INT IDENTITY(1,1) PRIMARY KEY,
    MatchId INT NOT NULL FOREIGN KEY REFERENCES MatchDetails(MatchId) ON DELETE CASCADE,
    StandName NVARCHAR(50) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    TotalSeats INT NOT NULL
);

CREATE TABLE SeatDetails (
    SeatId INT IDENTITY(1,1) PRIMARY KEY,
    StandId INT NOT NULL FOREIGN KEY REFERENCES StandDetails(StandId) ON DELETE CASCADE,
    SeatNumber NVARCHAR(20) NOT NULL,
    IsBooked BIT DEFAULT 0,
    Price DECIMAL(18,2) NOT NULL
);

CREATE TABLE Booking (
    BookingId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL FOREIGN KEY REFERENCES Users(UserId),
    MatchId INT NOT NULL FOREIGN KEY REFERENCES MatchDetails(MatchId),
    StandId INT NOT NULL FOREIGN KEY REFERENCES StandDetails(StandId),
    SeatId INT NOT NULL FOREIGN KEY REFERENCES SeatDetails(SeatId),
    TicketType NVARCHAR(50) NOT NULL DEFAULT 'Normal',
    IncludeFood BIT DEFAULT 0,
    BookingDate DATETIME DEFAULT GETDATE(),
    BasePrice DECIMAL(18,2) NOT NULL,
    TaxAmount DECIMAL(18,2) NOT NULL,
    TotalPrice DECIMAL(18,2) NOT NULL,
    PaymentStatus NVARCHAR(20) DEFAULT 'Pending',
    BookingStatus NVARCHAR(20) DEFAULT 'Confirmed'
);

CREATE TABLE Payment (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    BookingId INT NOT NULL FOREIGN KEY REFERENCES Booking(BookingId) ON DELETE CASCADE,
    PaymentMode NVARCHAR(50) NOT NULL,
    TransactionRef NVARCHAR(100) NOT NULL,
    AmountPaid DECIMAL(18,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE()
);

INSERT INTO Users (Username, Password, Role, FullName, Email, Phone) VALUES 
('admin', 'admin123', 'Admin', 'Administrator', 'admin@ipl.com', '9876543210'),
('user1', 'user123', 'User', 'Rahul Sharma', 'rahul@gmail.com', '9123456789'),
('user2', 'user123', 'User', 'Priya Patel', 'priya@gmail.com', '9988776655');

INSERT INTO MatchDetails (MatchName, TeamA, TeamB, Venue, MatchDate, Status) VALUES
('CSK vs MI - Match 01', 'Chennai Super Kings', 'Mumbai Indians', 'MA Chidambaram Stadium, Chennai', '2026-04-15 19:30:00', 'Upcoming'),
('RCB vs KKR - Match 02', 'Royal Challengers Bengaluru', 'Kolkata Knight Riders', 'M. Chinnaswamy Stadium, Bengaluru', '2026-04-16 19:30:00', 'Upcoming'),
('DC vs GT - Match 03', 'Delhi Capitals', 'Gujarat Titans', 'Arun Jaitley Stadium, Delhi', '2026-04-17 19:30:00', 'Upcoming');

INSERT INTO StandDetails (MatchId, StandName, Price, TotalSeats) VALUES
(1, 'North Stand (VIP)', 3500.00, 5),
(1, 'South Upper Stand', 1500.00, 5),
(1, 'East Pavilion', 2200.00, 5),
(2, 'Grand Stand', 4000.00, 5);

INSERT INTO SeatDetails (StandId, SeatNumber, IsBooked, Price) VALUES
(1, 'N-101', 0, 3500.00), (1, 'N-102', 0, 3500.00), (1, 'N-103', 0, 3500.00), (1, 'N-104', 0, 3500.00), (1, 'N-105', 0, 3500.00),
(2, 'S-201', 0, 1500.00), (2, 'S-202', 0, 1500.00), (2, 'S-203', 0, 1500.00), (2, 'S-204', 0, 1500.00), (2, 'S-205', 0, 1500.00),
(3, 'E-301', 0, 2200.00), (3, 'E-302', 0, 2200.00), (3, 'E-303', 0, 2200.00), (3, 'E-304', 0, 2200.00), (3, 'E-305', 0, 2200.00),
(4, 'G-101', 0, 4000.00), (4, 'G-102', 0, 4000.00), (4, 'G-103', 0, 4000.00), (4, 'G-104', 0, 4000.00), (4, 'G-105', 0, 4000.00);
