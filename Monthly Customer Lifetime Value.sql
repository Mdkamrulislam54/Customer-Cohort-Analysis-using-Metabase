
with first_orders as (
select
	customer_id, 
	Min(str_to_date(order_date, '%m/%d/%Y')) as First_order_date
from super_store
group by 1),
cohort_orders as(
select
	s.customer_id,
	date_format(f.First_order_date, '%Y-%m') as cohort_month,
	str_to_date(s.order_date, '%m/%d/%Y') as order_date,
    Round( s.Sales * s.quantity, 2) as Sale_value,
	timestampdiff(month, f.First_order_date, str_to_date(s.order_date, '%m/%d/%Y')) as cohort_index
from super_store as s
left join first_orders as f
on s.customer_id = f.customer_id
)
select 
	cohort_month,
	Round(Sum(case when cohort_index = 0 then Sale_value else 0 end),0) as Month_0,
	Round(Sum(case when cohort_index = 1 then Sale_value else 0 end),0) as Month_1,
    Round(Sum(case when cohort_index = 2 then Sale_value else 0 end),0) as Month_2,
    Round(Sum(case when cohort_index = 3 then Sale_value else 0 end),0) as Month_3,
    Round(Sum(case when cohort_index = 4 then Sale_value else 0 end),0) as Month_4,
    Round(Sum(case when cohort_index = 5 then Sale_value else 0 end),0) as Month_5,
    Round(Sum(case when cohort_index = 6 then Sale_value else 0 end),0) as Month_6,
    Round(Sum(case when cohort_index = 7 then Sale_value else 0 end),0) as Month_7,
    Round(Sum(case when cohort_index = 8 then Sale_value else 0 end),0) as Month_8,
    Round(Sum(case when cohort_index = 9 then Sale_value else 0 end),0) as Month_9,
    Round(Sum(case when cohort_index = 10 then Sale_value else 0 end),0) as Month_10,
    Round(Sum(case when cohort_index = 11 then Sale_value else 0 end),0) as Month_11
from cohort_orders
group by cohort_month
order by cohort_month;

