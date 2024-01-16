CREATE OR REPLACE VIEW store_sales_view AS
WITH total_sales_cte AS (
    SELECT
        store_type,
        SUM(o.product_quantity * p.sale_price) AS total_sales
    FROM
        orders o
    JOIN
        dim_product p ON o.product_code = p.product_code
    JOIN
        dim_store s ON o.store_code = s.store_code
    GROUP BY
        s.store_type)
        
SELECT
    s.store_type,
    ts.total_sales,
    100 * (ts.total_sales) / SUM(ts.total_sales) OVER () AS percentage_of_total_sales,
    COUNT(o.order_date) AS order_count
FROM
    orders o
JOIN
    dim_product p ON o.product_code = p.product_code
JOIN
    dim_store s ON o.store_code = s.store_code
JOIN
    total_sales_cte ts ON s.store_type = ts.store_type
GROUP BY
    s.store_type, ts.total_sales;

SELECT * FROM store_sales_view