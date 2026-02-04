-- Calculate Revenue by Month 

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    SUM(oi.price + oi.freight_value) AS total_revenue
FROM ecommerce.orders o
JOIN ecommerce.order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY order_month
ORDER BY order_month;


-- Calculate Top Product Categories by Revenue 

SELECT
    pct.product_category_name_english AS category,
    SUM(oi.price + oi.freight_value) AS revenue
FROM ecommerce.order_items oi
JOIN ecommerce.orders o
    ON oi.order_id = o.order_id
JOIN ecommerce.products p
    ON oi.product_id = p.product_id
JOIN ecommerce.product_category_translation pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;

-- Calculate Average Order Volume 

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
    AVG(order_total) AS average_order_value
FROM order_revenue;

-- Payment Method Distribution 

SELECT
    op.payment_type,
    COUNT(DISTINCT op.order_id) AS number_of_orders,
    SUM(op.payment_value) AS total_payment_value
FROM ecommerce.order_payments op
JOIN ecommerce.orders o
    ON op.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY op.payment_type
ORDER BY total_payment_value DESC;

-- Distinguish between repeat and one-time customers 

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM ecommerce.customers c
    JOIN ecommerce.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
) t
GROUP BY customer_type;
