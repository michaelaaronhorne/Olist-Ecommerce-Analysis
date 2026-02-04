-- Monthly Revenue View 

CREATE OR REPLACE VIEW ecommerce.v_monthly_revenue AS
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    SUM(oi.price + oi.freight_value) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM ecommerce.orders o
JOIN ecommerce.order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;


-- Top Product Categories View 

CREATE OR REPLACE VIEW ecommerce.v_top_categories AS
SELECT
    pct.product_category_name_english AS category,
    SUM(oi.price + oi.freight_value) AS revenue,
    COUNT(DISTINCT oi.order_id) AS number_of_orders
FROM ecommerce.order_items oi
JOIN ecommerce.orders o
    ON oi.order_id = o.order_id
JOIN ecommerce.products p
    ON oi.product_id = p.product_id
JOIN ecommerce.product_category_translation pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY revenue DESC;


-- Average Order Value View 

CREATE OR REPLACE VIEW ecommerce.v_average_order_value AS
WITH order_revenue AS (
    SELECT
        o.order_id,
        SUM(oi.price + oi.freight_value) AS order_total
    FROM ecommerce.orders o
    JOIN ecommerce.order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.order_id
)
SELECT
    AVG(order_total) AS average_order_value,
    MIN(order_total) AS smallest_order,
    MAX(order_total) AS largest_order,
    COUNT(*) AS number_of_orders
FROM order_revenue;


-- Payment Method Distribution View

CREATE OR REPLACE VIEW ecommerce.v_payment_distribution AS
SELECT
    op.payment_type,
    COUNT(DISTINCT op.order_id) AS number_of_orders,
    SUM(op.payment_value) AS total_payment_value,
    ROUND(100.0 * SUM(op.payment_value) / SUM(SUM(op.payment_value)) OVER (), 2) AS pct_of_total
FROM ecommerce.order_payments op
JOIN ecommerce.orders o
    ON op.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY op.payment_type
ORDER BY total_payment_value DESC;


-- Repeat vs. One-Time Customers View 

CREATE OR REPLACE VIEW ecommerce.v_customer_type AS
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS number_of_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM ecommerce.customers c
    JOIN ecommerce.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) t
GROUP BY customer_type
ORDER BY number_of_customers DESC;

