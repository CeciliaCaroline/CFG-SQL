-- Create the database
CREATE DATABASE People;

-- Use the database
USE People;

-- Create the table
CREATE TABLE person (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    age INT,
    telephone VARCHAR(15),
    email VARCHAR(100)
);

-- Populate the table with data
INSERT INTO person (name, surname, age, telephone, email) VALUES
('Alice', 'Smith', 25, '123-456-7890', 'alice.smith@example.com'),
('Bob', 'Smith', 28, '123-456-7891', 'bob.smith@example.com'),
('Charlie', 'Johnson', 27, '123-456-7892', 'charlie.johnson@example.com'),
('David', 'Brown', 30, '123-456-7893', 'david.brown@example.com'),
('Eva', 'Davis', 26, '123-456-7894', 'eva.davis@example.com'),
('Frank', 'Miller', 29, '123-456-7895', 'frank.miller@example.com'),
('Grace', 'Wilson', 24, '123-456-7896', 'grace.wilson@example.com'),
('Hannah', 'Smith', 27, '123-456-7897', 'hannah.smith@example.com'),
('Ian', 'Johnson', 31, '123-456-7898', 'ian.johnson@example.com'),
('Jane', 'Brown', 28, '123-456-7899', 'jane.brown@example.com');

-- GROUP BY
SELECT surname, age
FROM person
GROUP BY surname, age HAVING age>25  
ORDER BY surname; 

SELECT surname, COUNT(*) AS count_people FROM person
 GROUP BY surname
 ORDER BY surname;