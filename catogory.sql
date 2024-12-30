SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_name LIKE 'B%';-- // start with
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_name LIKE '%t';-- // ends with
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_name LIKE 'B%t';-- // starts with b and t
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_name LIKE '%eak%';-- // contains


SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_id IN (1 , 2, 3);
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_name IN ('Lunch' , 'Meal');


-- // Between values are in given range // gives rechord from 1 to 5
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_id BETWEEN 1 AND 5;
-- // Apart from 1 to 5
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    NOT c.cat_id BETWEEN 1 AND 5;
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_id BETWEEN 1 AND 5
        AND cat_name IN ('Lunch' , 'Meal');
-- // same result
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    cat_name BETWEEN 'Lunch' AND 'Meal';


-- // Alias with AS and without as
SELECT 
    *
FROM
    hotel.category c
WHERE
    c.cat_name = 'Meal';
SELECT 
    *
FROM
    hotel.category AS c
WHERE
    c.cat_name = 'Meal';
-- // cannot give this space name for table we can give it for column
SELECT 
    c.cat_description AS 'my sweet home'
FROM
    hotel.category AS c
WHERE
    c.cat_name = 'Meal';


-- // concatinate two fields and combine into single one
SELECT 
    CONCAT(c.cat_description, ',', c.cat_name) AS Details
FROM
    hotel.category c;


-- // create table
CREATE TABLE Practice.Customers (
    CustomerID INT NOT NULL UNIQUE AUTO_INCREMENT,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Country VARCHAR(255),
    PRIMARY KEY (CustomerID)
);


CREATE TABLE Practice.Products (
    ProductID INT NOT NULL UNIQUE AUTO_INCREMENT,
    ProductName VARCHAR(255),
    CategoryID INT,
    Price INT,
    PRIMARY KEY (ProductID)
);


CREATE TABLE Practice.Categories (
    CategoryID INT NOT NULL UNIQUE AUTO_INCREMENT,
    CategoryName VARCHAR(255),
    Description VARCHAR(300),
    PRIMARY KEY (CategoryID)
);

-- // ALter ADD, DROP, RENAME old-column name to new column name
alter table Practice.Products ADD COLUMN story varchar(255);

-- // added fk to catId in table produts
ALTER table Practice.Products
ADD FOREIGN KEY (CategoryID) REFERENCES Practice.Categories(CategoryID);

-- // learn joins now
-- // without join also called as self join	
SELECT 
    *
FROM
    Practice.Products p,
    Practice.Categories c
WHERE
    p.categoryID = c.categoryID;
SELECT 
    p.productName, c.CategoryName, c.Description, c.categoryId
FROM
    Practice.Products p,
    Practice.Categories c
WHERE
    p.categoryID = c.categoryID;

-- // with join both query return same result
SELECT 
    *
FROM
    Practice.Products p
        JOIN
    Practice.Categories c ON p.categoryID = c.categoryID;
SELECT 
    p.productName, c.CategoryName, c.Description, c.categoryId
FROM
    Practice.Products p
        JOIN
    Practice.Categories c ON p.categoryID = c.categoryID;

-- // join is same as inner join (gives maching result from both the tables)
SELECT 
    *
FROM
    Practice.Products p
        INNER JOIN
    Practice.Categories c ON p.categoryID = c.categoryID;


-- // left outer join category left table and product is right table
-- // return left table data if there is or no match is there still data is going to be return 
SELECT 
    *
FROM
    Practice.Categories;
SELECT 
    *
FROM
    Practice.Products;
SELECT 
    p.productName, c.CategoryName, c.Description, c.categoryId
FROM
    Practice.Categories c
        LEFT JOIN
    Practice.Products p ON c.categoryID = p.categoryID;
-- // here we are getting all cat because category we will place to left and product will place to right

SELECT 
    *
FROM
    Practice.Products p
        RIGHT JOIN
    Practice.Categories c ON p.categoryID = c.categoryID;

-- // full join If we have match found or not in an both table it will return all the data in mysql there 
-- // is not direct full outer join we can use by combining using left and right by UNION keyword
SELECT 
    *
FROM
    Practice.Categories c
        LEFT JOIN
    Practice.Products p ON c.categoryID = p.categoryID 
UNION SELECT 
    *
FROM
    Practice.Categories c
        RIGHT JOIN
    Practice.Products p ON c.categoryID = p.categoryID;


-- // This is syntax of full outer join no more use in sql
SELECT 
    *
FROM
    practice.categories,
    FULL
        JOIN
    practice.products ON practice.categories.CategoryID = practice.products.CategoryID;


-- // UNION gives distinct values 
SELECT 
    Categories.Description
FROM
    Categories 
UNION SELECT 
    Products.ProductName
FROM
    Products;
 -- // allow duplicates
SELECT 
    Categories.Description
FROM
    Categories 
UNION ALL SELECT 
    Products.ProductName
FROM
    Products;



-- // we can able to get it done from whether we will get which product from which category
SELECT 
    'category' AS type, Categories.Description
FROM
    Categories 
UNION SELECT 
    'Products' AS type, Products.ProductName
FROM
    Products;

-- // find number of prodctus in each category GROUP BY groups the same element
use practice;
SELECT 
    *
FROM
    products;


-- // on signle column group by 
SELECT 
    COUNT(CategoryID) categoryId, ProductName
FROM
    Products
GROUP BY ProductName;
-- // on multiple column
SELECT 
    COUNT(CategoryID) categoryId, price, ProductName
FROM
    Products
GROUP BY ProductName , price;



/*SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);
*/

SELECT 
    COUNT(CategoryID) categoryId, ProductName
FROM
    Products
GROUP BY ProductName
ORDER BY categoryId;

-- // The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.

SELECT 
    *
FROM
    practice.categories;
SELECT 
    *
FROM
    practice.products;

SELECT 
    p.productname, COUNT(c.categoryid), c.CategoryName
FROM
    (practice.products AS p
    JOIN practice.categories AS c ON p.CategoryID = c.CategoryID)
GROUP BY p.productname , c.CategoryName
HAVING COUNT(c.categoryid) > 0
ORDER BY p.productname , c.CategoryName;

-- // Exists
-- // return true if there is single or multiple rechords found in an subquery
SELECT 
    *
FROM
    practice.categories AS c
WHERE
    EXISTS( SELECT 
            *
        FROM
            practice.products AS p
        WHERE
            p.CategoryID = c.CategoryID);
-- / single rechord
SELECT 
    *
FROM
    practice.categories AS c
WHERE
    EXISTS( SELECT 
            *
        FROM
            practice.products AS p
        WHERE
            p.CategoryID = c.CategoryID
                AND p.ProductID = 1);
                
                
/*The ANY and ALL operators allow you to perform a comparison between a single column value and a range of other values. */

-- Lists the ProductName if it finds ANY records in the OrderDetails table has Quantity equal to 10 (this will return TRUE because the Quantity column has some values of 10):

SELECT  p.productname 
FROM practice.products as p
WHERE p.categoryId = ANY
  (SELECT c.categoryId
  FROM practice.categories as c
  WHERE c.CategoryID = 1);
  
--  this are the product name having cattegory is 1



/* returns a boolean value as a result
returns TRUE if ANY of the subquery values meet the condition
ANY means that the condition will be true if the operation is true for any of the values in the range.*/

/*
The ALL operator:

returns a boolean value as a result
returns TRUE if ALL of the subquery values meet the condition
is used with SELECT, WHERE and HAVING statements
ALL means that the condition will be true only if the operation is true for all values in the range.

SELECT ProductName
FROM Products
WHERE ProductID = ALL
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);

*/


-- The SELECT INTO statement copies data from one table into a new table.
select * INTO bkpCategory from practice.categories;
  