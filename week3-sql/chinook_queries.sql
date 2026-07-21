SELECT * FROM customer LIMIT 10;

SELECT first_name, last_name, city, country
FROM customer
WHERE country = 'Brazil'
ORDER BY city;

SELECT country, COUNT(*) AS total_customers
FROM customer
GROUP BY country
HAVING COUNT(*) > 5
ORDER BY total_customers DESC;

SELECT customer_id, 
       SUM(total) AS total_spent, 
       AVG(total) AS average_order_value,
       COUNT(*) AS number_of_orders
FROM invoice
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

SELECT c.first_name, c.last_name, i.invoice_id, i.total
FROM customer c
INNER JOIN invoice i ON c.customer_id = i.customer_id
ORDER BY i.total DESC
LIMIT 10;

SELECT customer_id, SUM(total) AS total_spent
FROM invoice
GROUP BY customer_id
HAVING SUM(total) > (
    SELECT AVG(total) FROM invoice
)
ORDER BY total_spent DESC;


SELECT customer_id, invoice_id, total,
       RANK() OVER (ORDER BY total DESC) AS overall_rank
FROM invoice
LIMIT 10;

SELECT customer_id, invoice_id, total,
       RANK() OVER (PARTITION BY customer_id ORDER BY total DESC) AS customer_rank
FROM invoice
ORDER BY customer_id, customer_rank
LIMIT 20;


SELECT t.name AS track_name, 
       SUM(il.unit_price * il.quantity) AS total_revenue
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
GROUP BY t.name
ORDER BY total_revenue DESC
LIMIT 10;

SELECT DATE_TRUNC('year', invoice_date) AS year,
       SUM(total) AS total_revenue
FROM invoice
GROUP BY DATE_TRUNC('year', invoice_date)
ORDER BY year;

SELECT c.country,
       SUM(i.total) AS total_revenue,
       COUNT(DISTINCT c.customer_id) AS number_of_customers
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC
LIMIT 10;

-- Check how long a query takes WITHOUT an index
EXPLAIN ANALYZE
SELECT * FROM invoice WHERE customer_id = 5;

EXPLAIN ANALYZE
SELECT * FROM invoice WHERE billing_city = 'Paris';

CREATE INDEX idx_billing_city ON invoice(billing_city);