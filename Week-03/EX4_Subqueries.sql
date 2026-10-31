USE sakila;
-- Warm-up: Count all filma
SELECT COUNT(*) AS total_films
FROM film;

-- Warm up calculate the average rental.
SELECT AVG(rental_rate) AS average_rental_rate
FROM film;
-- Films with an above-average rental rate 
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
SELECT AVG(rental_rate)
FROM film
);

-- This finds the customer IDs for payments over $10
-- Example 2: Inner query
SELECT customer_id
FROM payment
WHERE amount > 10;

-- Customer with a payment over %10
SELECT first_name , last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
WHERE amount > 10
);

-- Compare join versus subquery
SELECT c.first_name, c.last_name
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
WHERE p.amount > 10;

 -- Customers who made a payment over $10
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM payment
WHERE amount > 10
);
-- G1 Film below the average rental rate
SELECT title, rental_rate FROM film
WHERE rental_rate < (SELECT AVG(rental_rate) FROM film);

-- G2 Sort above avarege films
SELECT title, rental_rate FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC, title;

-- G3 Films with an above-average replacement cost
SELECT title, replacement_cost
 FROM film
WHERE replacement_cost >
(SELECT AVG(replacement_cost) FROM film);

-- G4 Customer with no payments over $10
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN
(SELECT customer_id FROM payment WHERE amount > 10);

-- G5 Qualifying customer sorted by store
SELECT store_id, first_name, last_name FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment WHERE amount > 10)
ORDER BY store_id;
-- G5 Count qualifying customer oer store
-- G5: Count qualifying customers per store
SELECT store_id, COUNT(*) AS total_customers
FROM customer
WHERE customer_id IN (
SELECT customer_id
FROM payment
WHERE amount > 10
)
GROUP BY store_id
ORDER BY store_id;

-- P1  Films longer then avarege
SELECT title, length
 FROM film
WHERE length > 
(SELECT AVG(length) FROM film);

-- P2 PG-13 films with an above avarege rental RELEASE SAVEPOINT
SELECT title, rental_rate 
FROM film
WHERE rating = 'PG-13'
AND rental_rate >
(SELECT AVG(rental_rate) FROM film);
-- P3 Largest single payment
SELECT first_name, last_name FROM customer
WHERE customer_id IN (
SELECT customer_id FROM payment
WHERE amount = (SELECT MAX(amount) FROM payment)
);

-- p4 Bbove average Action filmes
SELECT title, rental_rate FROM film
WHERE rental_rate > 
(SELECT AVG(rental_rate)
 FROM film)
  AND film_id IN (
SELECT film_id 
FROM film_category
WHERE category_id = (
SELECT category_id 
FROM category 
WHERE name = 'Action')
  );

  -- P5 Filmes have a replacemen cost below average

SELECT title, replacement_cost 
FROM film
WHERE replacement_cost <(
SELECT AVG(replacement_cost)
FROM film
);



























