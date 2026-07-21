CREATE TABLE sales (
    ordernumber INT,
    quantityordered INT,
    priceeach NUMERIC(10,2),
    orderlinenumber INT,
    sales NUMERIC(10,2),
    orderdate VARCHAR(20),
    status VARCHAR(20),
    qtr_id INT,
    month_id INT,
    year_id INT,
    productline VARCHAR(50),
    msrp INT,
    productcode VARCHAR(20),
    customername VARCHAR(100),
    phone VARCHAR(30),
    addressline1 VARCHAR(100),
    addressline2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    postalcode VARCHAR(20),
    country VARCHAR(50),
    territory VARCHAR(50),
    contactlastname VARCHAR(50),
    contactfirstname VARCHAR(50),
    dealsize VARCHAR(20)
);

SELECT * FROM sales LIMIT 10;


SELECT productline, 
       SUM(sales) AS total_revenue
FROM sales
GROUP BY productline
ORDER BY total_revenue DESC;


SELECT year_id, month_id, 
       SUM(sales) AS total_revenue
FROM sales
GROUP BY year_id, month_id
ORDER BY year_id, month_id;

SELECT customername,
       SUM(sales) AS total_spent,
       COUNT(DISTINCT ordernumber) AS number_of_orders
FROM sales
GROUP BY customername
ORDER BY total_spent DESC
LIMIT 10;


