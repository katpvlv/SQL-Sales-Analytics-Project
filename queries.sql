/* 4 задание*/
select count(customer_id) as customers_count
from customers;
/* считает количество записей в столбце customer_id*/

/* 5 задание*/
with operation_tab as /* создает временную таблицу, к которой мы будем обращаться ниже*/
(
select
  s.sales_person_id as sales_id,
  (e.first_name || ' ' || e.last_name) as name, /* объединяет значение из столбца e.first_name со значением из e.last_name, размещая между ними пробел */
  count(s.sales_id) as operations /* считает количество s.sales_id*/
from employees e
join sales s /* объединяет две таблицы по указанному полю*/
  on e.employee_id = s.sales_person_id
group by s.sales_person_id, name 
), 
income_tab as
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
order by income desc /*cортирует в обратном порядке*/
limit 10 /* выдает только первые 10 значений*/
;

with income_tab as
(
select 
  s.sales_person_id as sales_id, 
  sum(p.price * s.quantity) as income, /* считает сумму выручки (выручка = цена * на количество проданных продуктов)*/
  count(s.sales_id) as operations_cnt
from sales s 
join products p 
  on s.product_id = p.product_id
group by s.sales_person_id
)
select
  (e.first_name || ' ' || e.last_name) as name,
  round(it.income/it.operations_cnt) as average_income /* считает среднюю выручку и округляет ее до целого значения*/
from income_tab it
join employees e
  on it.sales_id = e.employee_id
group by name, average_income
having round(it.income/it.operations_cnt) < (select avg(income/operations_cnt) from income_tab) /*фильтрует среднюю выручку каждого продавца и показывает ту, что меньше средней по всем (во вложенном запросе делит всю выручку на все операции) */
order by average_income
;

with weekday_income as
(
select
	s.sales_person_id as sales_id,
	to_char(s.sale_date, 'day') as weekday, /* присваивает каждой дате имя дня недели в этот день*/
	extract(dow from s.sale_date) as number_wd, /* присваивает каждой дате порядковый номер дня недели в этот день (нам понадобится это для сортировки)*/
	sum(p.price * s.quantity) as income
from sales s 
join products p 
  on s.product_id = p.product_id
group by s.sales_person_id, weekday, number_wd
)
select 
  (e.first_name || ' ' || e.last_name) as name,
  wi.weekday as weekday,
  round(wi.income) as income /* округляет выручку до целого числа*/
from weekday_income wi
join employees e
  on wi.sales_id = e.employee_id
order by number_wd, weekday, name
;

/* 6 задание*/

select
	case 
		when age between 16 and 25 then '16-25'
		when age between 26 and 40 then '26-40'
		when age >40 then '40+'
	end as age_category, /* присваивает каждому возрасту его категорию, например, 18 лет попадет в 16-25*/
	count(customer_id) as count
from customers
group by age_category
order by age_category
;

select
	date_trunc('MONTH', s.sale_date) as date, /* возвращает дату,усеченную до месяца*/
	count(distinct s.customer_id) as total_customers, /* считает уникальных покупателей без повторов*/
	sum(s.quantity * p.price) as income 
from sales s
join products p 
on s.product_id = p.product_id 
group by date
order by date
;

with tab as
(
select
	(c.first_name || ' ' || c.last_name) as customer,
	s.customer_id,
	first_value (s.sale_date) over (partition by s.customer_id) as sale_date, /* выбирает первое значение s.sale_date в разрезе id продавца */
	first_value (p.price) over (partition by s.customer_id order by s.sale_date, p.price) as first_purchase, /*выбирает первое значение p.price в разрезе id продавца и отсортированному по s.sale_date, p.price */
	first_value (e.first_name || ' ' || e.last_name) over (partition by s.customer_id order by s.sale_date, p.price) as seller /*выбирает первое значение имя продавца в разрезе id продавца и отсортированному по s.sale_date, p.price */
from sales s 
join customers c 
	on s.customer_id = c.customer_id 
join employees e 
	on e.employee_id = s.sales_person_id 
join products p
	on p.product_id = s.product_id
)
select 
	customer,
	sale_date,
	seller
from tab
where first_purchase = '0' /* фильтрует данные по first_purchase и оставляет только то, где first_purchase равен 0 */
group by customer, customer_id,  sale_date, seller
order by customer_id, sale_date
;
