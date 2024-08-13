SELECT u.email, c.name
FROM [Users] u
INNER JOIN [company] c ON u.company_id = c.comp_id;

SELECT u.email, c.name
FROM [Users] u
LEFT OUTER JOIN [company] c ON u.company_id = c.comp_id;

--join more that 2 table

SELECT c.name, ct.email_address, g.value
FROM [company] AS c
INNER JOIN [contact] AS ct
    ON c.comp_id = ct.company_id
INNER JOIN [gender] AS g
    ON ct.gender_id = g.gender_id
ORDER BY c.name, ct.email_address;

--cross join

SELECT u.email, c.name
FROM [Users] u
CROSS JOIN [company] c;

-- rank() 

SELECT 
    u.email, 
    c.name AS CompanyName,
    ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY u.email) AS Rank
FROM [Users] u
INNER JOIN [company] c
    ON u.company_id = c.comp_id;

--to count distinct users

SELECT COUNT(DISTINCT user_id) AS UniqueUsers
FROM [Users];

--count

SELECT email,
       COUNT(*) AS UserCount
FROM [Users]
GROUP BY email
HAVING COUNT(*) > 1;

-- insert entries to company table

INSERT INTO Company (
    code,
    name,
    contact_no,
    email_address,
    address,
    license_num,
    logo_url,
    created_by,
    updated_by
) VALUES (
    '6785',
    'jittec',
    '9674456765',
    'jittec@gmail.com',
    'kudappanakunnu',
    'LIC123456',
    'dsfdfdsfdfdf',
    'admin',
    'admin'
);

--To return the most recently assigned IDENTITY value
SELECT SCOPE_IDENTITY();

--If you need the latest identity value in a specific table, you can use the IDENT_CURRENT function

SELECT IDENT_CURRENT('Users');

--sequence
CREATE SEQUENCE UserIDSequence AS INT
START WITH 1000 
INCREMENT BY 1;

--To retrieve the next available value from a sequence, use the NEXT VALUE FOR construct, like this:

INSERT INTO Users (user_id, email, password_hash, first_name, middle_name, last_name, contact_no, alt_contact_no, company_id, created_by, updated_by)
VALUES
(NEXT VALUE FOR dbo.UserIDSequence, 'aadsshi@gmail.com', 'password123', 'Adhi', 'S', 'S', '1234567890', '0987654321', 1, 'Admin', 'Admin');

--if identity insert is off
SET IDENTITY_INSERT Users ON;

--To select users
select * from Users;

--Delete

DELETE FROM Users
WHERE user_id = 3;

--truncate

TRUNCATE TABLE tax;

--nullif
SELECT 
    user_id,
    email,
    password_hash,
    NULLIF(contact_no, '') AS ContactNumber,
    NULLIF(alt_contact_no, '') AS AlternativeContactNumber
FROM Users;