use companyhr;

Select * from bookings;

Delimiter $$
Create procedure search_room( In p_room_type varchar(255), 
In p_booked_date Date, In p_booked_time Time)
Begin 
     Select * from rooms where id not in( select room_id from
     bookings where booked_date = p_booked_date and booked_time =
     p_booked_time and payment_status != 'Cancelled') ANd 
     room_type = p_room_type;
End $$

Delimiter $$
Create Procedure cancel_booking ( In p_booking_id INt,
out p_message varchar(255))
Begin
     Declare v_cancellation int;
     Declare v_member_id varchar(255);
     Declare v_payment_status varchar(255);
     Declare v_booked_date date;
     Declare v_price Decimal(6, 2);
     Declare v_payment_due varchar(255);
     Set v_cancellation = 0;
     Select member_id, booked_date, price, payment_status into
	v_member_id, v_booked_date, v_price, v_payment_status from
    member_bookings where id = p_booking_id;
    Select payment_due Into v_payment_due from members where id =
    v_member_id;
    if curdate() >= v_booked_date then
      Select 'Cancellation cannot be done on/after the booked date'
       into p_message;
	    elseif v_payment_status = 'Cancelled' or v_payment_status=
        'Paid' then
            Select 'Booking has already been cancelled or paid'
            into p_message;
	Else
         Update booking set payment_status = 'Cancelled' where
         id = p_booking_id;
                 Set v_payment_due = v_payment_due - v_price;
                 
                 Set v_cancellation = check_cancellation(p_booking_id);
                 
		If v_cancellation >=2 then set v_payment_due =
        v_payment_due + 10;
            End if;
            update members set payment_due = v_payment_due
            where id = v_member_id;
		Select ' Booking canceleld' into p_message;
        End If;
	End $$
    
use companyhr;

-- *************** CREATE TRIGGER *********

Delimiter $$
CREATE TRIGGER payment_check BEFORE DELETE ON members FOR EACH
 ROW
 BEGIN
 DECLARE v_payment_due DECIMAL(6, 2);
 SELECT payment_due INTO v_payment_due FROM members WHERE id
 = OLD.id;
 IF v_payment_due > 0 THEN
 INSERT INTO pending_terminations (id, email,
 payment_due) VALUES (OLD.id, OLD.email, OLD.payment_due);
 END IF;   
END $$

-- ******** Create Function *********
Delimiter $$
CREATE FUNCTION check_cancellation (p_booking_id INT) RETURNS INT
 DETERMINISTIC
 BEGIN      
DECLARE v_done INT;
 DECLARE v_cancellation INT;
 DECLARE v_current_payment_status VARCHAR(255);   
DECLARE cur CURSOR FOR
 SELECT payment_status FROM bookings WHERE member_id =
 (SELECT member_id FROM bookings WHERE id = p_booking_id) ORDER BY
 datetime_of_booking DESC;
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;      
SET v_done = 0;
 SET v_cancellation = 0;   
OPEN cur;   
cancellation_loop : LOOP
 FETCH cur INTO v_current_payment_status;
 IF v_current_payment_status != 'Cancelled' OR v_done =
 1 THEN LEAVE cancellation_loop;
 ELSE SET v_cancellation =  v_cancellation + 1;
 END IF;
 END LOOP;  
CLOSE cur;         
RETURN v_cancellation;
 END $$
