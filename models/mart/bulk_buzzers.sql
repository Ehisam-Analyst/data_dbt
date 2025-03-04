with Bulk_buzzers AS 
(SELECT 
     c.id AS customer_id,
    '1001' AS promo_code
FROM 
    pora-academy-cohort3.jubilee_groceries.customer c
join
    {{ ref('august_average') }} aa
on c.id = aa.id
join
    {{ ref('september_average') }} sa
on aa.id = sa.id
WHERE 
    c.is_in_force = 1 AND 
    sa.september_average > aa.august_average)
select * from Bulk_buzzers