with cost_of_items_purchased_with_promo_applied AS (
SELECT 
    pi.id,
    pi.customer_id,
    pr.promo_code AS promo_code,
    pr.rate_pct AS discount_rate,
    SUM(i.quantity * b.product_price) AS amount_due, 
    SUM(i.quantity * b.product_price) * pr.rate_pct/100 AS discounted_amount 
FROM 
    pora-academy-cohort3.jubilee_groceries.parent_invoice pi
LEFT JOIN 
    pora-academy-cohort3.jubilee_groceries.invoice i 
    ON pi.id = i.parent_invoice_id
LEFT JOIN 
    pora-academy-cohort3.jubilee_groceries.product_base_table b 
    ON i.product_id = b.product_id
LEFT JOIN 
    pora-academy-cohort3.jubilee_groceries.promotion pr 
    ON pi.promo_code = pr.promo_code
GROUP BY pi.id, pi.customer_id, pr.promo_code, pr.rate_pct)
select * from cost_of_items_purchased_with_promo_applied
