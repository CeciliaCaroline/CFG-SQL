-- Let's create a very simple sample bank account database
create database bank;
use bank;

CREATE TABLE accounts (
  account_number int(11) DEFAULT NULL,
  account_holder_name varchar(50) DEFAULT NULL,
  account_holder_surname varchar(50) DEFAULT NULL,
  balance float DEFAULT NULL,
  overdraft_allowed tinyint(1) DEFAULT NULL
);

insert into accounts
(account_number, account_holder_name, account_holder_surname, balance, overdraft_allowed)
VALUES
(111112, 'Julie', 'Smith', 150, true),
(111113, 'James', 'Andrews', 20, false),
(111114, 'Jack', 'Oakes', -70, true),
(111115, 'Jasper', 'Wolf', 200, true);


 SET AUTOCOMMIT = 0;
-- 1. start a new transaction
START TRANSACTION;

SELECT 
    @moneyAvailable:=IF(balance > 50, balance, 0) AS MONEY
FROM
    bank.accounts
WHERE
    account_number = 111112
        AND account_holder_surname = 'Smith';
        
-- ------
SET @TransferAmount = 50;


-- ------
UPDATE accounts 
SET 
    balance = balance - @TransferAmount
WHERE
    account_number = 111112
        AND account_holder_surname = 'Smith';
        
-- ------
UPDATE accounts 
SET 
    balance = balance + @TransferAmount
WHERE
    account_number = 111113
        AND account_holder_surname = 'Andrews';

-- ------
select *
from accounts;

-- DELETE from accounts;


-- 2. (optional) Try Rollback to see how it works
-- ROLLBACK;

-- 3. commit changes 
COMMIT;
-- select *
-- from accounts;


