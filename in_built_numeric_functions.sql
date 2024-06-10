
-- RAND() - Return a random floating-point value
SELECT RAND() AS RandomValue; -- rabdom values btn 0-1(1 is exluded) 0.364859
SELECT CEILING(RAND()*888); -- rounds up to the nearest integer 0.364859*888 - 323.265  -> 324
SELECT LEFT(CEILING(RAND()*888),2) AS RandomValue; -- LEFT(322.265) -> 32

-- ABS() - Return the absolute value
SELECT ABS(5), ABS(-5);

-- CEILING() - Return the smallest integer value not less than the argument
SELECT CEILING(12.34), CEILING(-12.34);

-- DEGREES() - Convert radians to degrees
SELECT DEGREES(PI()), DEGREES(PI() / 2);

-- FLOOR() - Return the largest integer value not greater than the argument
SELECT FLOOR(12.54), FLOOR(-12.34); -- round down

-- PI() - Return the value of pi
SELECT PI();
-- SELECT PI()+ 0.000000000000000000; use this example to show how to show numbers with lots of decimals 

-- POW() - Return the argument raised to the specified power -  synonym for POWER(X,Y) 
SELECT POW(3,2);
SELECT POWER(8,-1);

-- SQRT() - Return the square root of the argument
SELECT SQRT(4);
SELECT SQRT(16);
SELECT SQRT(256);

-- Table Column
SELECT 	price, 
		ROUND(price) AS Price, 
		price-0.10, 
        cast(price-0.10 AS DECIMAL(3,2)), 
        ROUND(price-0.10, 2) AS R_Price 
FROM bakery.sweet;