-- identifying product naming issue
SELECT
	PRODUCT_NAME_CLEANED,
	GROUP_CONCAT(DISTINCT PRODUCT_ID ORDER BY PRODUCT_ID) AS product_ids,
	COUNT(DISTINCT PRODUCT_ID) AS id_count,
	count(*) AS total_orders
FROM
	orders
GROUP BY
	PRODUCT_NAME_CLEANED
HAVING
	COUNT(DISTINCT PRODUCT_ID) > 1
ORDER BY
	COUNT(DISTINCT PRODUCT_ID) DESC

-- Create a product standardization reference table
CREATE TABLE product_standardization (original_product_id VARCHAR (50), standardized_product_id VARCHAR (50), standardized_product_name VARCHAR (100), notes VARCHAR (255));
INSERT INTO product_standardization
VALUES
('e682', 'e682', 'Nintendo Switch', 'Primary product ID'),
('03ca', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('0d23', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('24c1', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('604c', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('6b8d', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('7d63', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('8d0d', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('8e5d', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('97c6', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('b5f7', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('da12', 'e682', 'Nintendo Switch', 'Alternative product ID'),
('f443', 'f443', '27in 4K gaming monitor', 'Primary product ID'),
('e7e6', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('afbf', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('ab5d', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('891b', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('8364,', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('7f86', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('7599', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('2a50', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('1238', 'f443', '27in 4K gaming monitor', 'Alternative product ID'),
('f81e', 'f81e', 'Dell Gaming Mouse', 'Primary product ID'),
('b0ee', 'f81e', 'Dell Gaming Mouse', 'Alternative product ID'),
('8d4f', 'f81e', 'Dell Gaming Mouse', 'Alternative product ID'),
('7416', 'f81e', 'Dell Gaming Mouse', 'Alternative product ID'),
('640d', 'f81e', 'Dell Gaming Mouse', 'Alternative product ID'),
('5142', 'f81e', 'Dell Gaming Mouse', 'Alternative product ID'),
('0c5a', 'f81e', 'Dell Gaming Mouse', 'Alternative product ID'),
('f5ca', 'f5ca', 'JBL Quantum 100 Gaming Headset', 'Primary product ID'),
('ab0f', 'f5ca', 'JBL Quantum 100 Gaming Headset', 'Alternative product ID'),
('8315', 'f5ca', 'JBL Quantum 100 Gaming Headset', 'Alternative product ID'),
('7388', 'f5ca', 'JBL Quantum 100 Gaming Headset', 'Alternative product ID'),
('4db1', 'f5ca', 'JBL Quantum 100 Gaming Headset', 'Alternative product ID'),
('4c58', 'f5ca', 'JBL Quantum 100 Gaming Headset', 'Alternative product ID'),
('2997', 'f5ca', 'JBL Quantum 100 Gaming Headset', 'Alternative product ID'),
('e22d', 'e22d', 'Sony PlayStation 5 Bundle', 'Primary product ID'),
('df85', 'e22d', 'Sony PlayStation 5 Bundle', 'Alternative product ID'),
('54ed', 'e22d', 'Sony PlayStation 5 Bundle', 'Alternative product ID'),
('12b1', 'e22d', 'Sony PlayStation 5 Bundle', 'Alternative product ID'),
('ae96', 'ae96', 'Lenovo IdeaPad Gaming 3', 'Primary product ID'),
('9ef0', 'ae96', 'Lenovo IdeaPad Gaming 3', 'Alternative product ID'),
('04ac', 'ae96', 'Lenovo IdeaPad Gaming 3', 'Alternative product ID'),
('a6be', 'a6be', 'Razer Pro Gaming Headset', 'Primary product ID'),
('4f26', 'a6be', 'Razer Pro Gaming Headset', 'Alternative product ID');

-- verify standardization
SELECT
	product_name,
	MIN(USD_PRICE) AS min_price,
	MAX(USD_PRICE) AS max_price,
	AVG(USD_PRICE) AS avg_price,
	count(DISTINCT product_id) AS variant_count
FROM
	orders_cleaned
GROUP BY
	product_name
ORDER BY
	count(DISTINCT product_id) DESC

-- create a view
SELECT
	`o`.`USER_ID` AS `USER_ID`,
	`o`.`ORDER_ID` AS `ORDER_ID`,
	`o`.`PURCHASE_TS_CLEANED` AS `purchase_ts`,
	`o`.`SHIP_TS` AS `SHIP_TS`,
	`o`.`PURCHASE_YEAR` AS `PURCHASE_YEAR`,
	`o`.`PRUCHASE_MONTH` AS `PURCHASE_MONTH`,
	`o`.`TIME_TO_SHIP` AS `TIME_TO_SHIP`,
	`ps`.`standardized_product_name` AS `product_name`,
	`ps`.`standardized_product_id` AS `product_id`,
	`o`.`USD_PRICE` AS `USD_PRICE`,
	`o`.`PURCHASE_PLATFORM` AS `PURCHASE_PLATFORM`,
	`o`.`MARKETING_CHANNEL_CLEANED` AS `marketing_channel`,
	`o`.`ACCOUNT_CREATION_METHOD_CLEANED` AS `account_creation_method`,
	`o`.`COUNTRY_CODE` AS `COUNTRY_CODE`,
	`r`.`REGION_CLEANED` AS `region`,
	`o`.`DATE_CHECK` AS `DATE_CHECK`
FROM
	(
		(`orders` `o` JOIN `product_standardization` `ps` ON ((`o`.`PRODUCT_ID` = `ps`.`original_product_id`)))
		JOIN `region` `r` ON ((`o`.`COUNTRY_CODE` = `r`.`COUNTRY_CODE`))
	)

--revenue of products with standardized product id
  SELECT
	ps.standardized_product_id,
	ps.standardized_product_name,
	COUNT(DISTINCT o.ORDER_ID) AS order_count,
	SUM(o.USD_PRICE) AS total_revenue,
	AVG(o.USD_PRICE) AS avg_price
FROM
	orders o
	JOIN product_standardization ps ON o.PRODUCT_ID = ps.original_product_id
GROUP BY
	ps.standardized_product_id,
	ps.standardized_product_name
ORDER BY
	SUM(o.USD_PRICE) DESC
  
--calculate AOV by year
SELECT
	PURCHASE_YEAR AS 'Year',
	COUNT(DISTINCT ORDER_ID) AS order_count,
	SUM(USD_PRICE) AS total_sales,
	round(SUM(USD_PRICE) / COUNT(DISTINCT ORDER_ID), 2) AS 'AOV',
	round(
		(COUNT(DISTINCT ORDER_ID) - LAG(COUNT(DISTINCT ORDER_ID)) OVER (ORDER BY PURCHASE_YEAR)) / LAG(COUNT(DISTINCT ORDER_ID)) OVER (ORDER BY PURCHASE_YEAR) * 100,
		2
	) AS order_count_growth,
	round(
		(SUM(USD_PRICE) - LAG(SUM(USD_PRICE)) OVER (ORDER BY PURCHASE_YEAR)) / LAG(SUM(USD_PRICE)) OVER (ORDER BY PURCHASE_YEAR) * 100,
		2
	) AS total_sales_growth,
	 ROUND(
        ((SUM(USD_PRICE) / COUNT(DISTINCT ORDER_ID)) - 
        LAG(SUM(USD_PRICE) / COUNT(DISTINCT ORDER_ID)) OVER (ORDER BY PURCHASE_YEAR)) / 
        LAG(SUM(USD_PRICE) / COUNT(DISTINCT ORDER_ID)) OVER (ORDER BY PURCHASE_YEAR) * 100,
        2
    ) AS AOV_growth
FROM
	orders_cleaned
WHERE
	PURCHASE_YEAR IS NOT NULL
GROUP BY
	PURCHASE_YEAR
ORDER BY
	PURCHASE_YEAR

--yoy growth percentage
WITH yearly_sales AS (
	SELECT
		PURCHASE_YEAR AS YEAR,
		product_name,
		SUM(USD_PRICE) AS total_sales,
		COUNT(DISTINCT ORDER_ID) AS order_count
	FROM
		orders_cleaned
	WHERE
		PURCHASE_YEAR IS NOT NULL
	GROUP BY
		PURCHASE_YEAR,
		product_name
	ORDER BY
		PURCHASE_YEAR
),
sales_with_prev_year AS (
	SELECT
		product_name,
		YEAR,
		total_sales,
		order_count,
		LAG(total_sales) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR) AS prev_year_sales,
		LAG(YEAR) OVER (PARTITION BY PRODUCT_NAME ORDER BY YEAR) AS prev_year
	FROM
		yearly_sales
) SELECT
	product_name,
	YEAR AS current_year,
	total_sales,
	prev_year_sales,
	round((total_sales - prev_year_sales) / prev_year_sales * 100, 2) AS yoy_growth_percentage,
	order_count
FROM
	sales_with_prev_year
WHERE
	prev_year IS NOT NULL
ORDER BY
	product_name,
	YEAR

--sales by marketing platforms
SELECT
	MARKETING_CHANNEL,
	SUM(USD_PRICE) AS sales,
	ROUND(SUM(USD_PRICE) / COUNT(DISTINCT ORDER_ID), 2) AS AOV,
	COUNT(DISTINCT ORDER_ID) AS order_count
FROM
	orders_cleaned
GROUP BY
	MARKETING_CHANNEL
ORDER BY
	SUM(USD_PRICE) DESC

--sales by purchase platform
SELECT
	PURCHASE_PLATFORM,
	SUM(USD_PRICE) AS sales,
	ROUND(SUM(USD_PRICE) / COUNT(DISTINCT ORDER_ID), 2) AS AOV,
	COUNT(DISTINCT ORDER_ID) AS order_count
FROM
	orders_cleaned
GROUP BY
	PURCHASE_PLATFORM
ORDER BY
	SUM(USD_PRICE) DESC

--repeat customers percentage
SELECT
	COUNT(DISTINCT CASE WHEN purchase_count > 1 THEN USER_ID END) AS repeat_customer,
	COUNT(DISTINCT USER_ID) AS total_customer,
	ROUND(COUNT(DISTINCT CASE WHEN purchase_count > 1 THEN USER_ID END) / COUNT(DISTINCT USER_ID) * 100, 2) AS repeat_customer_percentage
FROM
	(SELECT USER_ID, COUNT(DISTINCT ORDER_ID) AS purchase_count FROM orders_cleaned GROUP BY USER_ID) AS customer_purchases

--repeat customers by year
WITH customer_yearly_order AS (SELECT USER_ID, COUNT(DISTINCT ORDER_ID) AS order_count, PURCHASE_YEAR FROM orders_cleaned GROUP BY USER_ID, PURCHASE_YEAR) SELECT
	PURCHASE_YEAR,
	count(DISTINCT USER_ID) AS total_customers,
	count(DISTINCT CASE WHEN order_count > 1 THEN USER_ID END) AS repeat_customers,
	ROUND(count(DISTINCT CASE WHEN order_count > 1 THEN USER_ID END) / count(DISTINCT USER_ID) * 100, 2) AS repeat_customer_percentage
FROM
	customer_yearly_order
GROUP BY
	PURCHASE_YEAR
HAVING
	PURCHASE_YEAR IS NOT NULL
