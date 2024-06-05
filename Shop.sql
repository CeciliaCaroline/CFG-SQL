CREATE DATABASE shop;
use shop;

CREATE TABLE SALES1 (
    Store VARCHAR(20) NOT NULL,
    Week VARCHAR(20) NOT NULL,
    Day VARCHAR(20) NOT NULL,
    SalesPerson VARCHAR(20) NOT NULL,
    SalesAmount DECIMAL(6 , 2 ) NOT NULL,
    Month VARCHAR(20) NULL
); 

INSERT INTO  SALES1
(Store, Week, Day, SalesPerson, SalesAmount, Month) 
VALUES 
('London', '2', 'Monday', 'Frank', CAST(56.25 AS Decimal(6, 2)), 'May'),
('London', '5', 'Tuesday', 'Frank', CAST(74.32 AS Decimal(6, 2)), 'Sep'),
('London', '5', 'Monday', 'Bill', CAST(98.42 AS Decimal(6, 2)), 'Sep'),
('London', '5', 'Saturday', 'Bill', CAST(73.90 AS Decimal(6, 2)), 'Dec'),
('London', '1', 'Tuesday', 'Josie', CAST(44.27 AS Decimal(6, 2)), 'Sep'),
('Dusseldorf', '4', 'Monday', 'Manfred', CAST(77.00 AS Decimal(6, 2)), 'Jul'),
('Dusseldorf', '3', 'Tuesday', 'Inga', CAST(9.99 AS Decimal(6, 2)), 'Jun'),
('Dusseldorf', '4', 'Wednesday', 'Manfred', CAST(86.81 AS Decimal(6, 2)), 'Jul'),
('London', '6', 'Friday', 'Josie', CAST(74.02 AS Decimal(6, 2)), 'Oct'),
('Dusseldorf', '1', 'Saturday', 'Manfred', CAST(43.11 AS Decimal(6, 2)), 'Apr');

-- check how our table looks in order to proceed with queries

-- Find all sales records (and all columns) that took place in the London store, not in December,
-- but sales concluded by Bill or Frank for the amount higher than Â£50.

SELECT * FROM sales1
WHERE Store = "London"
AND Month != "Dec"
AND SalesPerson IN ("Bill", "Frank")
AND SalesAmount > 50;


-- Find out how many sales took place each week (in no particular order)

SELECT week, COUNT(salesAmount)
FROM sales1
GROUP BY Week
ORDER BY Week;

-- Find out how many sales took place each week (and present data by week in descending and then in ascending order)
