--TOTAL_INSTALLMENT_PAYMENT

With 
total_installment_payment AS(
     Select id, instalment_id, customer_id, mode_of_payment, 
instalment_1_amount_paid, instalment_2_amount_paid, instalment_3_amount_paid,
SUM(IFNULL (instalment_1_amount_paid, 0) + IFNULL (instalment_2_amount_paid, 0)
 + IFNULL(instalment_3_amount_paid, 0)) as Total_amount_paid_by_customer
from pora-academy-cohort3.jubilee_groceries.parent_invoice
group by id, customer_id, instalment_id,  mode_of_payment, 
instalment_1_amount_paid, instalment_2_amount_paid, instalment_3_amount_paid)


Select  pi.customer_id, pi.id as parent_invoice_id,
 pi.mode_of_payment,
 pi.instalment_id, 
pi.instalment_1_amount_paid, 
pi.instalment_2_amount_paid, 
pi.instalment_3_amount_paid, 
(ROUND(fad.final_amount_due,2)) AS final_amount_due,
(ROUND(SUM(tip.Total_amount_paid_by_customer), 2)) as Total_amount_paid,
(ROUND(SUM(tip.Total_amount_paid_by_customer) - (fad.final_amount_due),2)) As Overpayment
 from pora-academy-cohort3.jubilee_groceries.parent_invoice pi
join
total_installment_payment tip on pi.id = tip.id
join
pora-academy-cohort3.jubilee_groceries.final_amount_due fad on pi.id=fad.id
Where {{ref('final_amount_due')}} < Total_amount_paid_by_customer
Group by pi.customer_id, pi.id, pi.mode_of_payment, pi.instalment_id,
fad.final_amount_due, fad.Original_amount_due,
pi.instalment_1_amount_paid, pi.instalment_2_amount_paid, pi.instalment_3_amount_paid
order by overpayment ASC