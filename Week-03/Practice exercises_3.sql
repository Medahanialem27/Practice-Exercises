USE sakila;

SELECT COUNT(*)
FROM film f 
JOIN film_category fc on f. film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';

SELECT COUNT(DISTINCT name) 
FROM category;

SELECT SUM(amount) 
FROM payment;

SELECT customer_id, SUM(amount) 
FROM payment
GROUP BY customer_id;

SELECT AVG(amount), SUM(amount) 
FROM payment;

SELECT AVG(length) 
FROM film;

SELECT ROUND(AVG(amount), 2) 
FROM payment;

SELECT customer_id, AVG(amount) 
FROM payment
GROUP BY customer_id;

SELECT MIN(release_year) 
FROM film;

SELECT MAX(amount) 
FROM payment;

SELECT customer_id, MAX(amount) 
FROM payment
GROUP BY customer_id;

SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id; 

-- Using multiple columns in GROUP BY
SELECT r.customer_id, i.film_id, COUNT(*) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY r.customer_id, i.film_id;

-- Filtering grouped data with HAVING

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > 100;   

-- Multiple conditions in the having clause

SELECT r.customer_id, COUNT(*) AS rental_count, SUM(p.amount) AS total_spent
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY r.customer_id
HAVING rental_count > 5 AND total_spent > 100;