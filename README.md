# Проект «Аналитика продаж»

В рамках проекта была проанализирована работа отдела продаж.
SQL-запросы сформированы для PostgeSQL, с помощью редактора [DBeaver](https://dbeaver.io/download/). 


Написанные в рамках проекта запросы лежат в этом [файле](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/queries.sql).


Для подключения к БД:
1. Установить DBeaver
2. Выбрать PostgreSQL
3. Создать новое подключение, используя данные:
   * Host: 65.108.223.44 
   * Database: salesdb 
   * Username: student 
   * Password: student 
   * Port: 5432


Excel-таблицы для первой задачи:
  *[Таблица товаров](https://docs.google.com/spreadsheets/d/1NGwLlnzN4jIaoraJe-JS4i_jK8jDRUJumkNOBVI-t7w/copy?usp=sharing)
  *[Таблица продаж](https://docs.google.com/spreadsheets/u/1/d/1Y_gzrFfOAJfTZo2u-PfU4selSic11dqM50bS3RlLA8M/copy?usp=sharing&pli=1)


### Задачи:
1. Создать сводную таблицу excel с 10 товарами, которые продались на наибольшую сумму. [Результат](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/top_10_profitable_products.csv)
2. Напишисать SQL-запрос, который считает общее количество покупателей. [Результат](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/customers_count.csv)
3. Проанализировать данные о продавцах с помощью SQL-запросов (используется join, concat, подзапросы, группировка и сортировка). Подготовлен [отчет](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/top_10_total_income.csv) о продавцах, у которых наибольшая выручка,
[отчет](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/lowest_average_income.csv) о продавцах, чья выручка ниже средней, [отчет](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/day_of_the_week_income.csv) с данными о выручке по каждому продавцу и дню недели
4. Проанализировать данные о покупателях и покупкахс помощью SQL-запросов (используется case и оконные функции). Собрана [таблица](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/age_groups.csv) с возрастными группами покупателей, [таблица](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/customers_by_month.csv) с количеством покупателей и выручкой по месяцам, [таблица](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/special_offer.csv) с покупателями первая покупка которых пришлась на время проведения специальных акций
5. Создать [дашборд с визуализацией полученных данных](https://a06e77b6.us1a.app.preset.io/superset/dashboard/SalesProject/) с помощью Apache Superset
6. По результатм анализа подготовить [презентация в Google Slides с итоговыми графиками и выводами](https://github.com/katpvlv/SQL-Sales-Analytics-Project/blob/main/presentation.pdf)
