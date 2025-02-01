with discount_10001 as (select rate_pct*0.01 as discount_3 from pora-academy-cohort3.jubilee_groceries.promotion
where promo_code = 10001)
select * from discount_10001