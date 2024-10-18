-- Create a databse of Sports_booking

Create database sports_booking;

use sports_booking;


/* Now i have to create four tables 
members
pending_terminations
rooms 
booking
*/

Create table members(id varchar(255) primary key,
 password varchar(255) not null, email varchar(255) not null,
 member_since timestamp default now() not null, 
 payment_due decimal(6,2) not null default 0
);

Create table pending_terminations (id varchar(255) primary key,
email varchar(255) not null,
request_date timestamp default now() not null,
payment_due decimal(6,2) not null default 0
);


Create table rooms ( id varchar(255) primary key,
room_type varchar(255) not null,
price decimal(6,2) not null
);


 CREATE TABLE bookings (
 id INT AUTO_INCREMENT PRIMARY KEY,
 room_id VARCHAR(255) NOT NULL,
 booked_date DATE NOT NULL,
 booked_time TIME NOT NULL,
 member_id VARCHAR(255) NOT NULL,
 datetime_of_booking TIMESTAMP DEFAULT NOW() NOT NULL,
 payment_status VARCHAR(255) NOT NULL DEFAULT 'Unpaid',   
CONSTRAINT uc1 UNIQUE (room_id, booked_date, booked_time)
 );
 
 ALTER TABLE bookings
ADD CONSTRAINT fk1 FOREIGN KEY (member_id) REFERENCES members(id)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk2 FOREIGN KEY (room_id) REFERENCES rooms(id)
ON DELETE CASCADE ON UPDATE CASCADE;
 
 INSERT INTO members (id, password, email, member_since, payment_due)
VALUES 
  ('afeil', 'feil1988<3', 'Abdul.Feil@hotmail.com', '2017-04-15 12:10:13', 0),
  ('amely_18', 'loseweightin18', 'Amely.Bauch91@yahoo.com', '2018-02-06 16:48:43', 0),
  ('bbahringer', 'iambeau17', 'Beaulah_Bahringer@yahoo.com', '2017-12-28 05:36:50', 0),
  ('little31', 'whocares31', 'Anthony_Little31@gmail.com', '2017-06-01 21:12:11', 10),
  ('macejkovic73', 'jadajeda12', 'Jada.Macejkovic73@gmail.com', '2017-05-30 17:30:22', 0),
  ('marvin1', 'if0909mar', 'Marvin_Schulist@gmail.com', '2017-09-09 02:30:49', 10),
  ('nitzsche77', 'bret77@#', 'Bret_Nitzsche77@gmail.com', '2018-01-09 17:36:49', 0),
  ('noah51', '18Oct1976#51', 'Noah51@gmail.com', '2017-12-16 22:59:46', 0),
  ('oreillys', 'reallycool#1', 'Martine_OReilly@yahoo.com', '2017-10-12 05:39:20', 0),
  ('wyattgreat', 'wyatt111', 'Wyatt_Wisozk2@gmail.com', '2017-07-18 16:28:35', 0);
  
Select * from members;

Insert into rooms(id, room_type, price) values
('AR', 'Archery Range', 120),
 ('B1', 'Badminton Court', 8),
 ('B2', 'Badminton Court', 8),
 ('MPF1', 'Multi Purpose Field', 50),
 ('MPF2', 'Multi Purpose Field', 60),
 ('T1', 'Tennis Court', 10),
 ('T2', 'Tennis Court', 10);
 
 insert into bookings (id, room_id, booked_date, booked_time,
 member_id, datetime_of_booking, payment_status) values
 (1, 'AR', '2017-12-26', '13:00:00', 'oreillys', '2017-12-20
 20:31:27', 'Paid'),
 (2, 'MPF1', '2017-12-30', '17:00:00', 'noah51', '2017-12-22
05:22:10', 'Paid'),
 (3, 'T2', '2017-12-31', '16:00:00', 'macejkovic73', '2017-12-28
 18:14:23', 'Paid'),
 (4, 'T1', '2018-03-05', '08:00:00', 'little31', '2018-02-22
 20:19:17', 'Unpaid'),
 (5, 'MPF2', '2018-03-02', '11:00:00', 'marvin1', '2018-03-01
 16:13:45', 'Paid'),
 (6, 'B1', '2018-03-28', '16:00:00', 'marvin1', '2018-03-23
 22:46:36', 'Paid'),
 (7, 'B1', '2018-04-15', '14:00:00', 'macejkovic73', '2018-04-12
 22:23:20', 'Cancelled'),
 (8, 'T2', '2018-04-23', '13:00:00', 'macejkovic73', '2018-04-19
 10:49:00', 'Cancelled'),
 (9, 'T1', '2018-05-25', '10:00:00', 'marvin1', '2018-05-21
 11:20:46', 'Unpaid'),
 (10, 'B2', '2018-06-12', '15:00:00', 'bbahringer', '2018-05-30
 14:40:23', 'Paid');
 
-- ********* Create View **********

Create view member_booking as 
select bookings.id, room_id, room_type, booked_date, booked_time,
member_id, datetime_of_booking, price, payment_status from bookings
join rooms
on
bookings.room_id = rooms.id
order by
bookings.id;

select * from member_booking;

-- **********************Stored Procedures******************

select * from members;

Delimiter $$
Create procedure insert_new_member( In p_id varchar(255),
 In p_password varchar(255), 
In p_email varchar(255))
Begin
Insert into members(id, password, email) values(p_id, p_password,
p_email);
End $$

DELIMITER $$
 CREATE PROCEDURE insert_new_member (IN p_id VARCHAR(255), IN
 p_password VARCHAR(255), IN p_email VARCHAR(255))
 BEGIN
 INSERT INTO members (id, password, email) VALUES (p_id,
 p_password, p_email);
 END $$
 
 Show procedure status
 
 Delimiter $$
 Create Procedure delete_member(In p_id varchar(25))
 Begin
 Delete from members where id = p_id;
 End$$
 
 Delimiter $$
 Create procedure update_member_password (IN p_id varchar(255),
 in p_password varchar(255))
 Begin
      update members set password = p_password where id = p_id;
End $$

Delimiter $$
Create procedure update_member_email( In p_id varchar(255),
In p_email varchar(255))
Begin
     update members set email = p-email where id = p_id;
End $$

Delimiter $$
Create procedure make_booking( in p_room_id varchar(255), 
In p_booked_date Date, In p_booked_time time, In p_member_id
varchar(255))
Begin
     Declare v_price Decimal(6,2);
     Declare v_payment_due Decimal(6,2);
     Select price Into v_price from rooms where id = p_room_id;
     Update members set payment_due = v_payment_due + v_price 
     where id = p_member_id;
End $$

CALL make_booking('room123', '2023-12-31', '14:00:00', 'member456');
 
Delimiter $$
create Procedure update_payment( In p_id int)
Begin
    Declare v_member_id varchar(255);
    Declare v_payment_due decimal(6,2);
    Declare v_price Decimal(6,2);
    Update bookings set payment_status = 'Paid' where id=p_id;
    Select member_id,price into v_member_id, v_price from 
    member_bookings where id = p_id;
    Select payment_due into v_payment_due from members where
    id = v_member_id;
    Update members set payment_due = v_payment_due - price
     where id = v_member_id;
End $$

Delimiter $$
Create procedure view_bookings (In p_id varchar(255))
Begin
     Select * from member_bookings where id = p_id;
End $$

Delimiter $$


 
 
 