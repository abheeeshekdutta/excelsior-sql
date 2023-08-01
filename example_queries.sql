select * from consolidated_comic_books
where condition_value > 8
and price < 7000
and genre = 'Superhero';

select * from ongoing_orders
where order_status = 'shipped'
and customer_city = 'Dublin';


select customer_city, sum(tc.number_of_orders) as total_orders, avg(tc.total_amount_spent) as average_amount from top_customers tc
inner join customers c
on tc.customer_id = c.customer_id
group by 1
order by total_orders desc, average_amount desc;


select condition_description, count(distinct order_id) as number_of_orders from consolidated_comic_books ccb
inner join orders o
on ccb.product_id = o.product_id
group by 1
order by number_of_orders desc;