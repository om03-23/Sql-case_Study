create database Hotwheels;
use Hotwheels;
show tables;

-- Creating tables
CREATE TABLE Series (
    SeriesID INT PRIMARY KEY,
    Name VARCHAR(100),
    ReleaseYear INT
);
desc Series; 
select * from series;

CREATE TABLE Cars (
    CarID INT PRIMARY KEY,
    Name VARCHAR(100),
    Model VARCHAR(100),
    Year INT,
    SeriesID INT,
    FOREIGN KEY (SeriesID) REFERENCES Series(SeriesID)
);
desc Cars;
select * from cars;

CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(100)
);
desc Manufacturers;
select * from Manufacturers;

CREATE TABLE Car_Manufacturers (
    CarID INT,
    ManufacturerID INT,
    PRIMARY KEY (CarID, ManufacturerID),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID)
);
desc Car_Manufacturers;
select * from Car_Manufacturers;
show tables;

-- Inserting data
INSERT INTO Series VALUES (1, 'Race World', 2015), (2, 'Track Stars', 2018), (3, 'Hot Rods', 2012), (4, 'Exotic Cars', 2020);
INSERT INTO Cars VALUES (1, 'Speedster', 'X1', 2016, 1), (2, 'Turbo Flash', 'T2', 2019, 2), (3, 'Drift King', 'D3', 2013, 3), (4, 'Hyper Jet', 'H4', 2021, 4);
INSERT INTO Manufacturers VALUES (1, 'Mattel', 'USA'), (2, 'Hot Wheels Inc.', 'USA'), (3, 'SpeedTech', 'Germany'), (4, 'AutoX', 'Japan');
INSERT INTO Car_Manufacturers VALUES (1, 1), (2, 2), (3, 3), (4, 4);

INSERT INTO Cars VALUES 
(5, 'Blaze Racer', 'B5', 2017, 1),
(6, 'Nitro Speed', 'N6', 2018, 1),
(7, 'Street Blaster', 'S7', 2019, 1),
(8, 'Firestorm', 'F8', 2020, 1),
(9, 'Storm Chaser', 'SC9', 2021, 1),
(10, 'Lightning Flash', 'LF10', 2015, 2);

-- Subqueries
-- 1. Find all cars released after 2010 with their series name
SELECT Name, Model, Year, (SELECT Name FROM Series WHERE Series.SeriesID = Cars.SeriesID) AS SeriesName FROM Cars WHERE Year > 2010;

-- 2. Find the number of cars in each series
SELECT SeriesID, (SELECT Name FROM Series WHERE Series.SeriesID = Cars.SeriesID) AS SeriesName, COUNT(*) AS CarCount FROM Cars GROUP BY SeriesID;

-- 3. Find cars that belong to a unique manufacturer
SELECT Name, Model FROM Cars WHERE CarID IN (SELECT CarID FROM Car_Manufacturers GROUP BY CarID HAVING COUNT(*) = 1);

-- 4. Find series with more than 5 cars
SELECT SeriesID, (SELECT Name FROM Series WHERE Series.SeriesID = Cars.SeriesID) AS SeriesName FROM Cars 
GROUP BY SeriesID HAVING COUNT(*) > 5;
-- issue --
SELECT SeriesID, (SELECT Name FROM Series WHERE Series.SeriesID = Cars.SeriesID) AS SeriesName 
FROM Cars 
GROUP BY SeriesID 
HAVING COUNT(*) > 5;

SELECT SeriesID, COUNT(*) AS CarCount FROM Cars GROUP BY SeriesID  ORDER BY CarCount DESC;

-- Joins
-- 1. List all cars with their series details
SELECT Cars.Name, Cars.Model, Series.Name AS SeriesName FROM Cars JOIN Series ON Cars.SeriesID = Series.SeriesID;

-- 2. List manufacturers and their cars
SELECT Manufacturers.Name AS Manufacturer, Cars.Name AS Car FROM Manufacturers JOIN Car_Manufacturers ON Manufacturers.ManufacturerID = Car_Manufacturers.ManufacturerID JOIN Cars ON Car_Manufacturers.CarID = Cars.CarID;

-- 3. Find the count of cars per manufacturer
SELECT Manufacturers.Name, COUNT(Car_Manufacturers.CarID) AS CarCount FROM Manufacturers JOIN Car_Manufacturers ON Manufacturers.ManufacturerID = Car_Manufacturers.ManufacturerID GROUP BY Manufacturers.Name;

-- 4. List all cars along with their manufacturers and series
SELECT Cars.Name, Cars.Model, Series.Name AS SeriesName, Manufacturers.Name AS Manufacturer FROM Cars JOIN Series ON Cars.SeriesID = Series.SeriesID JOIN Car_Manufacturers ON Cars.CarID = Car_Manufacturers.CarID JOIN Manufacturers ON Car_Manufacturers.ManufacturerID = Manufacturers.ManufacturerID;

-- Views
-- 1. Car details including series information
CREATE VIEW CarDetails AS SELECT Cars.Name, Cars.Model, Cars.Year, Series.Name AS SeriesName FROM Cars JOIN Series ON Cars.SeriesID = Series.SeriesID;

-- 2. Manufacturer details including cars
CREATE VIEW ManufacturerDetails AS SELECT Manufacturers.Name AS Manufacturer, Cars.Name AS Car FROM Manufacturers JOIN Car_Manufacturers ON Manufacturers.ManufacturerID = Car_Manufacturers.ManufacturerID JOIN Cars ON Car_Manufacturers.CarID = Cars.CarID;


 select * from cardetails;
 select * from ManufacturerDetails;