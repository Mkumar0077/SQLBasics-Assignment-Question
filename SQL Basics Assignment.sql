          -- SQL Basics
		-- Assignment Questions


/*Q1. Create a table called employees with the following structure?
#: emp_id (integer, should not be NULL and should be a primary key)Q
#: emp_name (text, should not be NULL)Q
#: age (integer, should have a check constraint to ensure the age is at least 18)Q
#: email (text, should be unique for each employee)Q
#: salary (decimal, with a default value of 30,000).

#Write the SQL query to create the above table with all constraints */

-- Ans1. Create employees table with constraints
create database employees_data;
use employees_data;

CREATE TABLE employees (
emp_id INT,
emp_name VARCHAR(30),
age INT,
email VARCHAR(50),
salary DECIMAL(10,2) NOT NULL DEFAULT 30000.00,
CONSTRAINT pk_employees PRIMARY KEY (emp_id),
CONSTRAINT chk_age CHECK (age >= 18)
);

/*Q2.. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
examples of common types of constraints.*/

/* Ans2.) Purpose of constraints + common types

NOT NULL: disallows missing values; ensures required fields (e.g., emp_name).

UNIQUE: prevents duplicates in a column or column set (e.g., email).

PRIMARY KEY: uniquely identifies each row, implicitly NOT NULL + UNIQUE.

FOREIGN KEY: enforces referential integrity between parent/child tables (e.g., rental.customer_id → customer.customer_id).

CHECK: enforces a boolean expression (e.g., age >= 18).

DEFAULT: supplies a value when none provided (e.g., salary default 30000).

INDEX: not a constraint per se, but supports fast lookups; unique indexes can enforce uniqueness.

Constraints maintain data integrity by preventing invalid, inconsistent, or orphaned data.*/

/* Q3..Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify 
your answer.*/
/*Ans3.Apply NOT NULL when a column is mandatory for business logic (e.g., names, amounts).

A primary key cannot contain NULLs. It must uniquely and fully identify each row;
 NULL represents “unknown/missing,” which breaks identity and indexing.*/

/*Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
example for both adding and removing a constraint.*/

-- Ans4. To add constraints in table we use alter
ALTER TABLE employees
ADD CONSTRAINT chk_salary_min CHECK (salary >= 10000);

-- to constraints in table we drop
ALTER TABLE employees
DROP CONSTRAINT chk_salary_min;

/* Q5.Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
Provide an example of an error message that might occur when violating a constraint.*/

/* Ans5.Consequences of violating constraints

Inserts/updates/deletes that violate constraints fail and roll back.

Example errors (MySQL):

ERROR 3819 (HY000): Check constraint 'chk_age' is violated.

ERROR 1062 (23000): Duplicate entry 'a@b.com' for key 'uq_employees_email'.

ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails ... */

/* Q6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
    
    Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00 */
-- Ans6.

ALTER TABLE products
ADD CONSTRAINT pk_products PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00; -- MySQL 8.0 syntax
-- or: ALTER TABLE products MODIFY price DECIMAL(10,2) NOT NULL DEFAULT 50.00;

-- Q7.  You have two tables:
create database Students_data;
use Students_data;
-- Create Classes table first (since Students references it)
CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL
);

-- Insert data into Classes
INSERT INTO Classes (class_id, class_name) VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'History');

-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- Insert data into Students
INSERT INTO Students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

-- Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

-- Ans7.INNER JOIN Students & Classes:
SELECT student_name, class_name
FROM Students
INNER JOIN Classes ON Students.class_id = Classes.class_id;


-- Q8. Consider the following three tables:

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);

-- Insert data into Customers
INSERT INTO Customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert data into Orders
INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert data into Products
INSERT INTO Products (product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);

/*Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN)*/

-- Ans8. 

SELECT 
    p.product_id,
    o.order_id,
    c.customer_name,
    p.product_name
FROM Products p
LEFT JOIN Orders o ON p.order_id = o.order_id
LEFT JOIN Customers c ON o.customer_id = c.customer_id;

-- Q9.Given the following tables:
-- Table is in question sheet.
-- Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

-- Ans9.
SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM Sales s
INNER JOIN Products p 
    ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Q10. You are given three tables:
-- table Is in question sheet.
/* Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
customer using an INNER JOIN between all three tables*/

-- Ans10.
SELECT 
    o.order_id,
    c.customer_name,
    od.product_id,
    od.quantity
FROM Orders o
INNER JOIN Customers c 
    ON o.customer_id = c.customer_id
INNER JOIN Order_Details od 
    ON o.order_id = od.order_id;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  SQL Commands

-- Q1.Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
-- Ans1.
use mavenmovies;
-- 2
SELECT * FROM actor;

-- 3
SELECT * FROM customer;

-- 4
SELECT DISTINCT country FROM country;

-- 5
SELECT * FROM customer WHERE active = 1;

-- 6
SELECT rental_id FROM rental WHERE customer_id = 1;

-- 7
SELECT * FROM film WHERE rental_duration > 5;

-- 8
SELECT COUNT(*) FROM film WHERE replacement_cost BETWEEN 15 AND 20;

-- 9
SELECT COUNT(DISTINCT first_name) FROM actor;

-- 10
SELECT * FROM customer LIMIT 10;

-- 11
SELECT * FROM customer WHERE first_name LIKE 'B%' LIMIT 3;

-- 12
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

-- 13
SELECT * FROM customer WHERE first_name LIKE 'A%';

-- 14
SELECT * FROM customer WHERE first_name LIKE '%a';

-- 15
SELECT city FROM city WHERE city LIKE 'A%A' LIMIT 4;

-- 16
SELECT * FROM customer WHERE first_name LIKE '%NI%';

-- 17
SELECT * FROM customer WHERE first_name LIKE '_r%';

-- 18
SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

-- 19
SELECT * FROM customer WHERE first_name LIKE 'A%o';

-- 20
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

-- 21
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

-- 22
SELECT * FROM actor LIMIT 50;

-- 23
SELECT DISTINCT film_id FROM inventory;

-- Q2. List all details of actors.

-- Ans2.
SELECT * FROM actor;

-- Q3.List all customer information from DB.

-- Ans3.
SELECT * FROM customer;

-- Q4. List different countries.

-- Ans4.
SELECT DISTINCT country FROM country ORDER BY country;

-- Q5.Display all active customers.

-- Ans5.
SELECT * FROM customer WHERE active = 1;

-- Q6.List of all rental IDs for customer with ID 1.

-- Ans6.
SELECT rental_id FROM rental WHERE customer_id = 1 ORDER BY rental_id;

-- Q7.Display all the films whose rental duration is greater than 5.

-- Ans7.
SELECT * FROM film WHERE rental_duration > 5;

-- Q8. List the total number of films whose replacement cost is greater than $15 and less than $20.

-- Ans8.

SELECT COUNT(*) AS film_count
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

-- Q9.Display the count of unique first names of actors.

-- Ans9.

SELECT COUNT(DISTINCT first_name) AS unique_first_names FROM actor;


-- Q10.Display the first 10 records from the customer table .

-- Ans10.

SELECT * FROM customer ORDER BY customer_id LIMIT 10;

-- Q11. Display the first 3 records from the customer table whose first name starts with ‘b’.

-- Ans11.
SELECT *
FROM customer
WHERE first_name LIKE 'B%'
ORDER BY customer_id
LIMIT 3;

-- Q12.Display the names of the first 5 movies which are rated as ‘G’.

-- Ans12.

SELECT title FROM film WHERE rating = 'G' ORDER BY title LIMIT 5;

-- Q13.Find all customers whose first name starts with "a".

-- Ans13.

SELECT * FROM customer WHERE first_name LIKE 'a%' OR first_name LIKE 'A%';

-- Q14. Find all customers whose first name ends with "a".

-- Ans14.

SELECT * FROM customer WHERE first_name LIKE '%a';

-- Q15.Display the list of first 4 cities which start and end with ‘a’ .

-- Ans15.
SELECT city
FROM city
WHERE city LIKE 'a%a' OR city LIKE 'A%a' OR city LIKE 'a%A' OR city LIKE 'A%A'
ORDER BY city
LIMIT 4;

-- Q16. Find all customers whose first name have "NI" in any position.

-- Ans16.
SELECT * FROM customer WHERE first_name LIKE '%NI%';

-- Q17. Find all customers whose first name have "r" in the second position.
 
-- Ans17.
SELECT * FROM customer WHERE first_name LIKE '_r%';

-- Q18. Find all customers whose first name starts with "a" and are at least 5 characters in length.

-- Ans18.
SELECT *
FROM customer
WHERE first_name LIKE 'a%'
AND CHAR_LENGTH(first_name) >= 5;

-- Q19. Find all customers whose first name starts with "a" and ends with "o".

-- Ans19.
SELECT * FROM customer WHERE first_name LIKE 'a%o';

-- Q20. Get the films with pg and pg-13 rating using IN operator.

-- Ans20.
SELECT * FROM film WHERE rating IN ('PG','PG-13');

-- Q21. Get the films with length between 50 to 100 using between operator.

-- Ans21.
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

-- Q22. Get the top 50 actors using limit operator.

-- Ans22.
SELECT * FROM actor ORDER BY actor_id LIMIT 50;

-- Q23.Get the distinct film ids from inventory table.

-- Ans23.
SELECT DISTINCT film_id FROM inventory ORDER BY film_id;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     # Functions

  # Basic Aggregate Functions:

/* Question 1:

Retrieve the total number of rentals made in the Sakila database.

Hint: Use the COUNT() function.*/

-- Ans1.
use sakila ;
SELECT COUNT(*) AS total_rentals FROM rental;

/*Question 2:

Find the average rental duration (in days) of movies rented from the Sakila database.

Hint: Utilize the AVG() function.*/

-- Ans2.
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_days
FROM rental
WHERE return_date IS NOT NULL;

/* String Functions:

Question 3:

Display the first name and last name of customers in uppercase.

Hint: Use the UPPER () function. */

-- Ans3.
SELECT UPPER(first_name) AS first_name_upper,
UPPER(last_name) AS last_name_upper
FROM customer;

/* Question 4:

Extract the month from the rental date and display it alongside the rental ID.

Hint: Employ the MONTH() function.*/

-- Ans4.
SELECT rental_id,
MONTH(rental_date) AS rental_month,
DATE_FORMAT(rental_date, '%Y-%m') AS rental_yyyy_mm
FROM rental;

/* GROUP BY:


Question 5:

Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

Hint: Use COUNT () in conjunction with GROUP BY.*/

-- Ans5.
SELECT customer_id, COUNT(*) AS rentals
FROM rental
GROUP BY customer_id
ORDER BY rentals DESC;

/* Question 6:

Find the total revenue generated by each store.

Hint: Combine SUM() and GROUP BY.*/

-- Ans6.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff s ON s.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;

/* Question 7:

Determine the total number of rentals for each category of movies.

Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.*/

-- Ans7.
SELECT c.category_id, c.name AS category_name, COUNT(*) AS rental_count
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.category_id, c.name
ORDER BY rental_count DESC;

/* Question 8:

Find the average rental rate of movies in each language.

Hint: JOIN film and language tables, then use AVG () and GROUP BY.*/

-- Ans8.
SELECT l.language_id, l.name AS language_name,
AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON l.language_id = f.language_id
GROUP BY l.language_id, l.name
ORDER BY l.name;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  # Joins
/*Questions 9 -

Display the title of the movie, customer s first name, and last name who rented it.

Hint: Use JOIN between the film, inventory, rental, and customer tables.*/

-- Ans9.
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
ORDER BY f.title, c.last_name, c.first_name;

/*Question 10:

Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

Hint: Use JOIN between the film actor, film, and actor tables.*/

-- Ans10.
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.title = 'Gone with the Wind'
ORDER BY a.last_name, a.first_name;

/*Question 11:

Retrieve the customer names along with the total amount they've spent on rentals.

Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.*/

-- Ans11.
SELECT c.customer_id, c.first_name, c.last_name,
SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

/*Question 12:

List the titles of movies rented by each customer in a particular city (e.g., 'London').

Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.*/

-- Ans12.
SELECT 
    c.first_name,
    c.last_name,
    ci.city,
    f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, f.title, c.first_name, c.last_name, ci.city
ORDER BY c.last_name, c.first_name, f.title;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Advanced Joins and GROUP BY:

/*Question 13:

Display the top 5 rented movies along with the number of times they've been rented.

Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.*/

-- Ans13.
SELECT 
    f.title AS movie_title,
    COUNT(r.rental_id) AS times_rented
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title
ORDER BY 
    times_rented DESC
LIMIT 5;

/*Question 14:

Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.*/

-- Ans14.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT i.store_id) = 2;

-------------------------------------------------------------------------------------------------------------------------------------------------------------
# Windows Function:

-- Q1. Rank the customers based on the total amount they've spent on rentals.

-- Ans1.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS rank_position
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- Q2. Calculate the cumulative revenue generated by each film over time.

-- Ans2.
SELECT 
    f.film_id,
    f.title,
    p.payment_date,
    SUM(p.amount) OVER (
        PARTITION BY f.film_id 
        ORDER BY p.payment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;

-- Q3. Determine the average rental duration for each film, considering films with similar lengths.

-- Ans3.
SELECT 
    f.film_id,
    f.title,
    f.length,
    AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental_duration,
    AVG(AVG(DATEDIFF(r.return_date, r.rental_date))) 
        OVER (PARTITION BY f.length) AS avg_duration_by_length
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, f.length;

-- Q4. Identify the top 3 films in each category based on their rental counts.

-- Ans4.
SELECT *
FROM (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, c.name, f.title
) ranked
WHERE rank_in_category <= 3;

/* Q5. Calculate the difference in rental counts between each customer's total rentals and the average rentals
across all customers.*/

-- Ans5.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals,
    ROUND(AVG(COUNT(r.rental_id)) OVER (), 2) AS avg_rentals_all,
    COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER () AS diff_from_avg
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Q6. Find the monthly revenue trend for the entire rental store over time.

-- Ans6.SELECT 
   SELECT
   DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY month;

-- Q7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

-- Ans7.
SELECT *
FROM (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(p.amount) DESC) AS spending_percentile
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) ranked
WHERE spending_percentile = 1;

-- Q8. Calculate the running total of rentals per category, ordered by rental count.

-- Ans8.
SELECT 
    c.name AS category_name,
    COUNT(r.rental_id) AS rental_count,
    SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id)) AS running_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id
ORDER BY c.name, rental_count DESC;

-- Q9. Find the films that have been rented less than the average rental count for their respective categories.

-- Ans9.
SELECT 
    category_id,
    title,
    rental_count
FROM (
    SELECT 
        c.category_id,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) AS avg_rentals
    FROM 
        film f
    JOIN 
        film_category c ON f.film_id = c.film_id
    JOIN 
        inventory i ON f.film_id = i.film_id
    JOIN 
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY 
        c.category_id, f.title
) sub
WHERE 
    rental_count < avg_rentals;

-- Q10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

-- Ans10.
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY monthly_revenue DESC
LIMIT 5;

------------------------------------------------------------------------------------------------------------------------------------
    # Normalisation & CTE

/*Q1. First Normal Form (1NF):

 a. Identify a table in the Sakila database that violates 1NF. Explain how you

 would normalize it to achieve 1NF.*/
 
 -- Ans1.
use sakila;
CREATE TABLE feature (
    feature_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE
);
INSERT INTO feature (name)
VALUES ('Trailers'), ('Commentaries'), ('Deleted Scenes'), ('Behind the Scenes');

CREATE TABLE film_feature (
    film_id SMALLINT UNSIGNED,
    feature_id INT UNSIGNED,
    PRIMARY KEY (film_id, feature_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (feature_id) REFERENCES feature(feature_id)
);

/*Q2. Second Normal Form (2NF):

 a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 

 If it violates 2NF, explain the steps to normalize it.*/
 
 /*Ans2.Second Normal Form (2NF)

👉 Rule: No partial dependency (all non-key attributes must depend on the full primary key).

Candidate Table: film_actor

PK = (actor_id, film_id)

All attributes depend fully on both keys (only last_update exists). ✅ Already in 2NF.

Better Example of Violation: Suppose film_category(film_id, category_id, last_update) → here last_update depends on the film, not the composite key.

Fix: Move last_update to film table.*/

ALTER TABLE film_category DROP COLUMN last_update;

/*Q3. Third Normal Form (3NF):

 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 

 present and outline the steps to normalize the table to 3NF.*/
 
 /*Ans3. Third Normal Form (3NF)

👉 Rule: No transitive dependency (non-key → another non-key).

Violation Example: address

It stores city_id, and city table stores country_id.

So address → city_id → country_id (transitive).

Fix (3NF): Already normalized in Sakila (separate city and country). If country was stored in address, we’d remove it.*/

/*Q4. Normalization Process:

 a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 

 unnormalized form up to at least 2NF.*/
 
 /*Ans4. Normalization Process Example

Take actor_award from unnormalized → 1NF → 2NF:

UNF: actor_award(actor_id, first_name, last_name, awards) → awards like 'Emmy, Oscar'.

1NF: Split awards into separate rows (remove repeating groups).

2NF: Remove first_name, last_name (dependent only on actor, not award).

👉 Final:

actor(actor_id, first_name, last_name)

award(award_id, award_name)

actor_award_map(actor_id, award_id) */

/*Q5. CTE Basics:

 a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 

 have acted in from the actor and film_actor tables.*/

-- Ans5.
WITH ActorFilmCount AS (
    SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
           COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT * FROM ActorFilmCount;

/*Q6. CTE with Joins:

 a. Create a CTE that combines information from the film and language tables to display the film title, 

 language name, and rental rate.*/
 
 -- Ans6.
 WITH FilmLanguage AS (
    SELECT f.title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLanguage;

/*Qc\ CTE for Aggregation:

 a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 

 from the customer and payment tables.*/
 
 -- Ans7.
WITH CustomerRevenue AS (
    SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
           SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT * FROM CustomerRevenue;

/*Q8.CTE with Window Functions:

 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.*/
 
 -- Ans8.
WITH FilmRanking AS (
    SELECT film_id, title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT * FROM FilmRanking;

/*Q9.CTE and Filtering:

 a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 

 customer table to retrieve additional customer details.*/

-- Ans9.
WITH FrequentRenters AS (
    SELECT r.customer_id, COUNT(r.rental_id) AS rental_count
    FROM rental r
    GROUP BY r.customer_id
    HAVING COUNT(r.rental_id) > 2
)
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       c.email, c.active
FROM customer c
JOIN FrequentRenters fr ON c.customer_id = fr.customer_id;

/*Q10.CTE for Date Calculations:

 a. Write a query using a CTE to find the total number of rentals made each month, considering the 

 rental_date from the rental table.*/
 
 -- Ans10.
 WITH MonthlyRentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT * 
FROM MonthlyRentals
ORDER BY rental_month;

/*Q11.CTE and Self-Join:

 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 

 together, using the film_actor table.*/

-- Ans11.
WITH ActorPairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id 
       AND fa1.actor_id < fa2.actor_id   -- avoid duplicates & self-pairs
)
SELECT 
    f.title AS film_title,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM ActorPairs ap
JOIN film f ON ap.film_id = f.film_id
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY f.title, actor1, actor2;


/*Q12.CTE for Recursive Search:

 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 

 considering the reports_to column.*/
 
 -- Ans12. 
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    reports_to INT,
    FOREIGN KEY (reports_to) REFERENCES staff(staff_id)
);

WITH RECURSIVE StaffHierarchy AS (
    -- Anchor: start with the manager
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE staff_id = 1   -- 🔹 replace with manager's ID

    UNION ALL

    -- Recursive: find employees who report to the current staff
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    INNER JOIN StaffHierarchy sh ON s.reports_to = sh.staff_id
)
SELECT * 
FROM StaffHierarchy;



