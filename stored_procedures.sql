DELIMITER //
CREATE PROCEDURE remove_orders()
BEGIN
	DECLARE cutoff_date DATE;
    SET cutoff_date = DATE_ADD(NOW(), INTERVAL -1 MONTH); -- Set cutoff date to 1 month ago
    DELETE FROM orders
    WHERE order_date < cutoff_date
    and order_status = 'pending';
END//
DELIMITER ;

CALL remove_orders();

DELIMITER //
CREATE PROCEDURE apply_discount(discount_percentage decimal(3,1), month_number bigint)
BEGIN
UPDATE comic_book_details cbd
JOIN 
(
	select product_id, price, price*(1-discount_percentage) as discounted from comic_book_details
	WHERE MONTH(NOW()) = month_number
    AND YEAR(NOW()) = 2023
    group by 1,2,3
)ref ON cbd.product_id = ref.product_id
set cbd.price = ref.discounted;
END//
DELIMITER ;

-- Apply 20% discount for the month of May in 2023
CALL apply_discount(0.2, 5);

DELIMITER //
CREATE TRIGGER decrease_quantity_available
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE inventory 
    SET quantity_available = quantity_available - 1 
    WHERE product_id = NEW.product_id;
END//
DELIMITER ;

drop trigger trg_insert_condition_lkp

DELIMITER //
CREATE TRIGGER trg_insert_condition_lkp
BEFORE INSERT ON comic_condition
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insertions into condition_lkp table are not allowed';
END//
DELIMITER ;

INSERT INTO `comic_condition` (condition_id, condition_description, condition_value)
VALUES 
  (50, 'So Good(SG)', 0.1);
  
-- Error Code: 1644. Insertions into condition_lkp table are not allowed
