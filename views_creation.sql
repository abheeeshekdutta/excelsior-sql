
CREATE VIEW top_customers AS
SELECT c.customer_id, c.customer_name, COUNT(*) AS number_of_orders, SUM(cbd.price) AS total_amount_spent
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN comic_book_details cbd ON o.product_id = cbd.product_id
GROUP BY c.customer_id
ORDER BY number_of_orders DESC, total_amount_spent DESC;


CREATE VIEW consolidated_comic_books AS
select cbd.product_id, cbd.comic_book_name, 
cc.condition_description,
cc.condition_value,
cbd.price,
cbd.genre,
cbd.publisher,
cc1.character_name as main_character1,
cc2.character_name as main_character2,
w.writer_name,
cbd.year
 from comic_book_details cbd
 left join comic_condition cc
 on cbd.condition_id = cc.condition_id
 left join writers w
 on cbd.writer_id = w.writer_id
 left join comic_characters cc1
 on cbd.main_character1_id = cc1.character_id
 left join comic_characters cc2
 on cbd.main_character2_id = cc2.character_id;


CREATE VIEW stock_check AS
select 
cbd.genre, cbd.publisher, cc.character_name, sum(i.quantity_available) as total_quantity_available
 from comic_book_details cbd
left join comic_characters cc on cc.character_id IN (cbd.main_character1_id, cbd.main_character2_id)
left join inventory i on cbd.product_id = i.product_id
group by 1,2,3;


CREATE VIEW ongoing_orders AS
select c.*, o.order_date, o.order_status, o.order_id from orders o
left join customers c on o.customer_id = c.customer_id
where order_status <> 'delivered';