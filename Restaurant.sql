-- CREATE DATABASE RestaurantBooking;

USE RestaurantBooking;

-- Customers table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Contact VARCHAR(15) NOT NULL
);

-- GuestTables table
CREATE TABLE GuestTables (
    TableNo INT PRIMARY KEY,
    TableCapacity INT NOT NULL,
    TableStatus VARCHAR(20) NOT NULL
);

-- Bookings table
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    BookingDate DATE NOT NULL,
    BookingTime TIME NOT NULL,
    Guests INT NOT NULL,
    TableNo INT NOT NULL,
    BookingNumber VARCHAR(10),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TableNo) REFERENCES GuestTables(TableNo)
);



-- INSERT INTO Customers (CustomerName, Contact) VALUES
-- ('John Doe', '123456'),
-- ('Grace Smith', '789012'),
-- ('Jasper Worlf', '719012'),
-- ('Mary Robertson', '786012'),
-- ('Gray Foster', '782012'),
-- ('Alice Johnson', '344678');

-- INSERT INTO GuestTables(TableNo, TableCapacity, TableStatus) VALUES
-- (1, 4, 'Available'),
-- (2, 2, 'Booked'),
-- (3, 6, 'Available'),
-- (4, 4, 'Available'),
-- (5, 2, 'Booked'),
-- (6, 6, 'Booked'),
-- (7, 4, 'Available'),
-- (8, 4, 'Available'),
-- (9, 8, 'Booked');


-- To create a booking
-- Get the lastest booking number
-- add 1 to create a new booking number
-- Check for an available table
-- If table is available, create a new booking


-- Create the trigger to generate BookingNumber
-- A trigger is a block of code that is executed automatically when DML operations like INSERT, UPDATE or DELETE are executed
DELIMITER //

CREATE TRIGGER before_insert_bookings
BEFORE INSERT ON Bookings
FOR EACH ROW
BEGIN
	-- Return the first non-null value in a list:
    SET NEW.BookingNumber = CONCAT('BK', COALESCE((SELECT MAX(BookingID) + 1 FROM Bookings), 1)); 
    
END //

DELIMITER ;

INSERT INTO Bookings (CustomerID, BookingDate, BookingTime, Guests, TableNo)
VALUES (1, '2024-06-11', '19:00', 4, 1),
(2, '2024-06-10', '19:00', 6, 1),
(3, '2024-06-12', '20:00', 2, 2);





-- To create a booking
-- Get the lastest booking number
-- add 1 to create a new booking number ------
-- Check for an available table
-- If table is available, create a new booking


DELIMITER //
CREATE PROCEDURE MakeBooking (
    IN p_CustomerID INT,
    IN p_BookingDate DATE,
    IN p_BookingTime TIME,
    IN p_Guests INT
)
BEGIN
    DECLARE v_TableNo INT;
	SET autocommit = 0;
    -- Start transaction
    START TRANSACTION;
    
    -- Create new customer [for demo only]
     INSERT INTO Customers (CustomerName, Contact) VALUES
 	('John Doeeee', '124456');
    
    SELECT * FROM Customers;
    
    -- TO DO: Add a new customer for every new booking

    -- Check for an available table with the same capacity as the guests
    SELECT TableNo INTO v_TableNo
    FROM GuestTables
    WHERE TableCapacity >= p_Guests AND TableStatus = 'Available'
    LIMIT 1;
    
    -- If an available table is found, proceed with the booking
    IF v_TableNo IS NULL THEN
		-- If no available table is found, rollback and indicate no table is available
		SELECT 'No available table with the required capacity.';
		ROLLBACK;
        SELECT * FROM Customers;
    ELSE
		-- Insert the booking record
        INSERT INTO Bookings (CustomerID, BookingDate, BookingTime, Guests, TableNo)
        VALUES (p_CustomerID, p_BookingDate, p_BookingTime, p_Guests, v_TableNo);

        -- Update the table status to 'Booked'
        UPDATE GuestTables
        SET TableStatus = 'Booked'
        WHERE TableNo = v_TableNo;
        
        SELECT CONCAT('Table No ',v_TableNo);


        -- Commit the transaction
         COMMIT;

    END IF;
END//

DELIMITER ;

 CALL MakeBooking(1, '2024-06-12', '18:00', 22);


DELIMITER $$

CREATE FUNCTION CountEmptyTables(p_DesiredGuests INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE emptyTableCount INT;
    
    SELECT COUNT(*) INTO emptyTableCount
    FROM GuestTables
    WHERE TableStatus = 'Available' AND TableCapacity >= p_DesiredGuests;
    
    RETURN emptyTableCount;
END$$

DELIMITER ;


SELECT CountEmptyTables(4);


-- JOINS

-- Retrieving Customer Names and Booking Dates for a Specific Date
SELECT CustomerName, BookingDate, BookingTime
FROM Customers
INNER JOIN Bookings ON Customers.CustomerID = Bookings.CustomerID
WHERE BookingDate = '2024-06-11';

--  List all bookings along with customer names and table capacities.
SELECT b.BookingID, c.CustomerName, b.BookingDate, b.BookingTime, t.TableCapacity
FROM Bookings b
INNER JOIN Customers c ON b.CustomerID = c.CustomerID
INNER JOIN GuestTables t ON b.TableNo = t.TableNo;

-- List all bookings and include customer names and table capacities, even if the customer or table info is missing.
-- left join = inner join + other values in left table
SELECT b.BookingID, c.CustomerName, b.BookingDate, b.BookingTime, t.TableCapacity
FROM Bookings b LEFT JOIN Customers c ON b.CustomerID = c.CustomerID
LEFT JOIN GuestTables t ON b.TableNo = t.TableNo;

-- List all customers and their bookings, including customers who have no bookings.
-- right join = inner join + other values in right table
SELECT c.CustomerID, c.CustomerName, b.BookingID, b.BookingDate, b.BookingTime
FROM Bookings b
RIGHT JOIN Customers c ON b.CustomerID = c.CustomerID;

-- LIst all the table and show their bookings
SELECT 
    t.TableNo, b.BookingID, b.BookingDate, b.BookingTime
FROM
    GuestTables t
        LEFT JOIN
    Bookings b ON t.TableNo = b.TableNo;


--  The queries involved in a UNION must have the same number of columns, and the data types of corresponding columns must be compatible.


-- SELECT get_Availabletables(4);

-- Select to see the results
SELECT * FROM Bookings;

