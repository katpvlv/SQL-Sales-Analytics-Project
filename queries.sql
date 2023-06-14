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
