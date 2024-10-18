#### Sports Complex Booking System

#### Project Overview
The Sports Complex Booking System is a database management project designed to manage the booking process of a sports complex. The system allows registered users to make bookings, cancel bookings, and update their information.

#### Database Design
The database consists of four tables:
Tables
members: stores member information (id, password, email, member_since, payment_due)
pending_terminations: stores member information pending termination (id, email, request_date, payment_due)
rooms: stores room information (id, room_type, price)
bookings: stores booking information (id, room_id, booked_date, booked_time, member_id, datetime_of_booking, payment_status)

#### Views
member_bookings: displays member booking information
Stored Procedures
insert_new_member: inserts new member information
delete_member: deletes member information
update_member_password: updates member password
update_member_email: updates member email
make_booking: creates a new booking
update_payment: updates payment information
view_bookings: displays booking information
search_room: searches for available rooms
cancel_booking: cancels a booking

#### Triggers
payment_check: checks payment status before canceling a booking
Stored Functions
check_cancellation: checks consecutive cancellations and imposes fines

#### System Requirements
MySQL database management system
MySQL Workbench (optional)
Project Implementation
Create database and tables
Insert sample data
Create views, stored procedures, triggers, and stored functions
Test system functionality

#### Conclusion
The Sports Complex Booking System demonstrates a comprehensive database management system for managing bookings, member information, and payment processes. The project showcases various MySQL features.
Future Enhancements
Implement user authentication and authorization
Integrate payment gateway
Develop user interface (web or mobile application)
Add reporting and analytics features

#### Author
Farhan Ashraf
