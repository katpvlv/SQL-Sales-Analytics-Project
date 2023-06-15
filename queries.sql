/* 1 задание*/
select count(customer_id) as customers_count
from customers;

/* 2 задание*/
with operation_tab as
(
select
  s.sales_person_id as sales_id,
  concat(e.first_name, ' ', e.last_name) as name,
  count(s.sales_id) as operations
from employees e
join sales s 
  on e.employee_id = s.sales_person_id
group by s.sales_person_id, name 
)
, income_tab as
(
select 
  s.sales_person_id as sales_id, 
  sum(p.price * s.quantity) as income
from sales s 
join products p 
  on s.product_id = p.product_id
group by s.sales_person_id
)
select 
  name,
  operations,
  income
from operation_tab ot
left join income_tab it
  on ot.sales_id = it.sales_id
order by income desc
;

with income_tab as
(
select 
  s.sales_person_id as sales_id, 
  sum(p.price * s.quantity) as income,
  count(s.sales_id) as operation
from sales s 
join products p 
  on s.product_id = p.product_id
group by s.sales_person_id
)
select
  concat(e.first_name, ' ', e.last_name) as name,
  round(it.income/it.operation) as average_income
from income_tab it
join employees e
  on it.sales_id = e.employee_id
group by name, average_income
having round(it.income/it.operation) < (select avg(income/operation) from income_tab)
order by average_income
;

with weekday_income as
(
select
	s.sales_person_id as sales_id,
	to_char(s.sale_date, 'day') as weekday,
	sum(p.price * s.quantity) as income
from sales s 
join products p 
  on s.product_id = p.product_id
group by s.sales_person_id, weekday
)
select 
  concat(e.first_name, ' ', e.last_name) as name,
  wi.weekday as weekday,
  round(wi.income) as income
from weekday_income wi
join employees e
  on wi.sales_id = e.employee_id
order by weekday, name
;

/* 3 задание*/

select
	case 
		when age >15 and age <26 then '16-25'
		when age >25 and age <41 then '26-40'
		when age >40 then '40+'
	end as age_category,
	count(customer_id) as count
from customers
group by age_category
order by age_category
;

select
	case 
		when s.sale_date between '1992-09-01' and '1992-09-30' then '1992-09'
		when s.sale_date between '1992-10-01' and '1992-10-31' then '1992-10'
		when s.sale_date between '1992-11-01' and '1992-11-30' then '1992-11'
		when s.sale_date between '1992-12-01' and '1992-12-31' then '1992-12'
	end as date,
	count(s.customer_id) as total_customers,
	sum(s.quantity * p.price) as income 
from sales s
join products p 
on s.product_id = p.product_id 
group by date
order by date
;
