-- with base as(select *
-- from super_store
-- where str_to_date(Order_Date ,'%d/%m/%Y') is not null)
-- select 
-- count(*)
-- from base;
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
	timestampdiff(month, f.First_order_date, str_to_date(s.order_date, '%m/%d/%Y')) as cohort_index
from super_store as s
left join first_orders as f
on s.customer_id = f.customer_id
)
select 
	cohort_month,
	count(distinct case when cohort_index = 0 then customer_id else null end) as Month_0,
	count(distinct case when cohort_index = 1 then customer_id else null end) as Month_1,
	count(distinct case when cohort_index = 2 then customer_id else null end) as Month_2,
	count(distinct case when cohort_index = 3 then customer_id else null end) as Month_3,
	count(distinct case when cohort_index = 4 then customer_id else null end) as Month_4,
	count(distinct case when cohort_index = 5 then customer_id else null end) as Month_5,
	count(distinct case when cohort_index = 6 then customer_id else null end) as Month_6,
	count(distinct case when cohort_index = 7 then customer_id else null end) as Month_7,
	count(distinct case when cohort_index = 8 then customer_id else null end) as Month_8,
	count(distinct case when cohort_index = 9 then customer_id else null end) as Month_9,
	count(distinct case when cohort_index = 10 then customer_id else null end) as Month_10,
	count(distinct case when cohort_index = 11 then customer_id else null end) as Month_11
from cohort_orders
group by cohort_month;

