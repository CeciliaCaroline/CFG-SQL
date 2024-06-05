CREATE DATABASE Bakery;

USE Bakery;

CREATE TABLE Sweet (
    id INT NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    price FLOAT(2)
);

CREATE TABLE Savoury (
    id INT NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    price FLOAT(2),
    main_ingredient VARCHAR(50)
);

-- Populate the Sweet table
INSERT INTO Sweet
(id, item_name, price)
VALUES
(1, 'doughnut', 0.50),
(2, 'croissant', 0.75),
(3, 'painauchocolat', 0.55),
(4, 'cinnamon twirl', 0.45),
(5, 'cannoli', 0.88),
(6, 'apple tart', 1.12);

INSERT INTO Savoury
(id, item_name, price, main_ingredient)
VALUES
(1, 'meat pie', 1.25, 'pork'),
(2, 'sausage roll', 1.00, null),
(3, 'pasty', 2.45, 'beef');

-- 5/6/24

-- Find all savoury items that have either pork or beef filling
SELECT item_name, main_ingredient FROM Savoury WHERE main_ingredient = 'pork' OR main_ingredient = 'beef';

-- Find all sweet items that cost 50 cents or cheaper
select item_name, price from Sweet where price <= 0.5;



-- Find all sweet items and their price, except for cannoli 
select item_name, price from Sweet where item_name != "cannoli";

-- IN
SELECT item_name FROM SWEET WHERE item_name IN ('cannoli', 'apple tart');



-- Find all sweet items that start with the letter ‘c’
SELECT item_name FROM Sweet WHERE item_name LIKE 'c%';

-- Find all savoury items that cost more than £1, but less than £3
select item_name, price from Savoury where price < 3 AND price > 1;

-- ORDER

SELECT Sweet.item_name, Sweet.price FROM Sweet
WHERE Sweet.price > 0.5
ORDER BY Sweet.item_name DESC;
--  -------
SELECT 
    Sweet.item_name, Sweet.price
FROM
    Sweet
WHERE
    Sweet.price > 0.5
ORDER BY Sweet.price ASC;

-- Order items in the Savoury table according to price and item name

-- SUM COUNT MAX
SELECT SUM(price) FROM Sweet;

-- SELECT COUNT(item_name) FROM Sweet;

SELECT MAX(price) FROM Savoury; 

-- GROUP





-- Add column to the Savoury table 
-- ALTER TABLE Savoury ADD quantity INT;
-- UPDATE Savoury
-- SET quantity = 
--     CASE 
--         WHEN item_name = 'meat pie' THEN 4
--         WHEN item_name = 'pasty' THEN 5
--         WHEN item_name = 'sausage roll' THEN 7
--         
--     END
-- WHERE item_name IN ('meat pie', 'pasty','sausage roll');