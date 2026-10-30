USE sakila;

SELECT AVG(rental_rate)
FROM film;

SELECT title, rental_rate,
ROUND(rental_rate) AS rounded_rate
FROM film;

SELECT rental_id,
 rental_date,
 CAST(rental_date AS DATE) AS rental_day,
 CAST(rental_date AS TIME) AS rental_time
FROM rental
LIMIT 10;

SELECT title,
   CONVERT(rental_rate, CHAR) AS rate_as_text,
    CAST(rental_duration AS DECIMAL(5,2)) AS duration_decimal,
    CAST(rental_rate AS SIGNED) AS rate_as_integer
FROM film
LIMIT 10;

SELECT film_id,
  CONV(film_id, 10, 2)  AS binary_id,
  CONV(film_id, 10, 16) AS hex_id
FROM film
WHERE film_id IN (10, 255);


SELECT customer_id,
  CONCAT_WS(' ', first_name, last_name)  AS full_name,
  CONCAT_WS(', ', last_name, first_name) AS directory_name,
  LOWER(email) AS clean_email
FROM customer
LIMIT 10;

SELECT title,
 SUBSTRING(title, 1, 3)  AS first_three,
LOWER(title)            AS lower_title,
REPLACE(title, ' ', '_') AS file_name,
REVERSE(title)          AS backwards
FROM film
LIMIT 10;

SELECT TRIM('   Sakila   ')                      AS trimmed,
 INSERT('ACADEMY DINOSAUR', 1, 7, 'MUSEUM') AS inserted,
 STRCMP('ALIEN', 'ZORRO')                   AS compare_1,
STRCMP('ACE', 'ACE')                       AS compare_2,FORMAT(1234567.891, 2)                     AS formatted;


SELECT first_name,
CONCAT(UPPER(SUBSTRING(first_name, 1, 1)),
LOWER(SUBSTRING(first_name, 2))) AS proper_first
FROM customer
LIMIT 10;

SELECT rental_id,
 rental_date,
 DATE(rental_date)      AS rental_day,
 DAYNAME(rental_date)   AS weekday,
 DAYOFWEEK(rental_date) AS weekday_number,
 DAYOFYEAR(rental_date) AS day_of_year,
 QUARTER(rental_date)   AS quarter
FROM rental
LIMIT 10;

SELECT payment_id,
payment_date,
DATE_FORMAT(payment_date, '%M %d, %Y')         AS report_date,
DATE_FORMAT(payment_date, '%m/%d/%Y %h:%i %p') AS us_format,
DATE_SUB(payment_date, INTERVAL 1 MONTH)       AS one_month_earlier
FROM payment
LIMIT 10;

SELECT CURDATE(), CURTIME(), CURRENT_TIMESTAMP;

SELECT rental_id,
rental_date,
IFNULL(return_date, 'Not returned') AS return_status
FROM rental
WHERE return_date IS NULL;

SELECT COUNT(*) AS total_rentals,
SUM(ISNULL(return_date)) AS not_returned
FROM rental;

SELECT COUNT(*) AS all_films,
COUNT(NULLIF(rental_rate, 0.99)) AS films_not_099
FROM film;

SELECT payment_id,
IFNULL(rental_id, 'No rental linked') AS rental_status
FROM payment 
WHERE rental_id IS NULL;

SELECT title,
replacement_cost,
rental_rate,
replacement_cost / rental_rate               AS raw_ratio,
ROUND(replacement_cost / rental_rate, 2)     AS rounded,
CEILING(replacement_cost / rental_rate)      AS rentals_to_break_even,
FLOOR(replacement_cost / rental_rate)        AS floored,
TRUNCATE(replacement_cost / rental_rate, 1)  AS truncated
FROM film
LIMIT 10;

SELECT title,
replacement_cost,
rental_rate,
CEILING(replacement_cost / rental_rate) AS rentals_to_break_even
FROM film
WHERE title = 'ACADEMY DINOSAUR';

SELECT LEAST(4.99, 2.99, 0.99), POW(2, 10), SQRT(144), ROUND(PI(), 4);
-- No, RAND() did not return the same five filmes both times.
SELECT title
FROM film ORDER BY RAND() LIMIT 5;

SELECT CONCAT(
 UPPER(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name, 2)),
 UPPER(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name, 2))
) AS full_name,
LOWER(email) AS email
FROM customer
ORDER BY last_name;


SELECT DATE_FORMAT(rental_date, '%M') AS month_name, COUNT(*) AS total_rentals 
FROM rental 
GROUP BY month_name 
ORDER BY total_rentals DESC
LIMIT 1;

SELECT r.rental_id, r.rental_date,
DATE_ADD(r.rental_date, INTERVAL f.rental_duration DAY) AS due_date,
r.return_date
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE r.rental_id = 1;

SELECT rental_id, IFNULL(return_date, 'Not returned') AS return_status
FROM rental;

SELECT title, CEILING(replacement_cost / rental_rate) AS rentals_to_break_even
FROM film
WHERE Title = 'ACADEMY DINOSAAUR';

SELECT COUNT(*) AS late_returns
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE DATEDIFF(r.return_date, r.rental_date) > f.rental_duration;

SELECT DAYNAME(rental_date) AS weekday, COUNT(*) AS rentals
FROM rental
GROUP BY weekday
ORDER BY rentals DESC;

SELECT rental_id, IFNULL(return_date, 'Not returned') AS return_status
FROM rental;

SELECT title, CEILING(replacement_cost / rental_rate) AS rentals_to_break_even
FROM film;

-- Independent practice.

-- P1. That customer is the answer to 'Who is first on the list'
SELECT CONCAT_WS(' ',
 CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2))),
 CONCAT(UPPER(SUBSTRING(last_name, 1, 1)),  LOWER(SUBSTRING(last_name, 2)))
 ) AS full_name,
 LOWER(email) AS clean_email
FROM customer
ORDER BY last_name, first_name;

-- P2. rental has  the rental dates, and the joins connect each rental to its filmand rental duration.
SELECT COUNT(*) AS late_returns
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE DATEDIFF(r.return_date, r.rental_date) > f.rental_duration;

-- P3 The first row shows the busiest weekday and its rental count.
SELECT DAYNAME(rental_date) AS weekday, COUNT(*) AS rentals
FROM rental
GROUP BY weekday
ORDER BY rentals DESC;

-- P4 
SELECT YEAR(payment_date) AS yr, QUARTER(payment_date) AS qtr,
FORMAT(SUM(amount), 2) AS revenue
FROM payment
GROUP BY YEAR(payment_date), QUARTER(payment_date)
ORDER BY yr, qtr;

-- P5 This calculates each film's break event reantal count, round it up to a whole rental, and then find the average.
SELECT AVG(CEILING(replacement_cost / rental_rate)) AS average_rentals_to_break_even
FROM film;

-- Calculates the average, outside query counts films above it.
SELECT COUNT(*) AS films_above_average
FROM film
WHERE CEILING(replacement_cost / rental_rate) >
(SELECT AVG(CEILING(replacement_cost / rental_rate))
FROM film);

-- P6 the reslut gives 
SELECT COUNT(*) AS outstanding_rentals,
MAX(DATEDIFF('2006-02-14', rental_date)) AS longest_days_out
FROM rental
WHERE return_date IS NULL;

-- P7 takes the first three letters UPPER case.
SELECT CONCAT_WS('-', UPPER(LEFT(title, 3)), rental_rate, film_id) AS product_code,
    title,
    rental_rate,
    film_id
FROM film;

-- P8 The number of unique customers. The subquery finds their customer ID's the output query count them.
SELECT COUNT(*) AS q3_big_spenders
FROM customer
WHERE customer_id IN (
SELECT customer_id FROM payment
WHERE YEAR(payment_date) = 2005
AND QUARTER(payment_date) = 3
AND amount > 10
);

-- P9 We will use it in a subquery to count the rantal kept longr then average.
SELECT COUNT(*) AS kept_longer_than_avg
FROM rental
WHERE DATEDIFF(return_date, rental_date) >
(SELECT AVG(DATEDIFF(return_date, rental_date)) FROM rental);

SELECT COUNT(*) AS rentals_longer_than_average
FROM rental
WHERE return_date IS NOT NULL
AND DATEDIFF(return_date, rental_date) >
(SELECT AVG(DATEDIFF(return_date, rental_date))
FROM rental
WHERE return_date IS NOT NULL);
























