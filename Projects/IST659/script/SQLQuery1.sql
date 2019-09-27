-- Creating customer table
create table customer(
		customer_ID int identity
		,first_name varchar(30) not null
		, last_name varchar(30) not null
		, phone_number varchar(15) not null
		, email_address varchar(50) not null
-- Constraint on the customer table
constraint PK_customer primary key (customer_ID),
constraint U1_customer unique (first_name),
constraint U2_customer unique (last_name),
constraint U3_customer unique (email_address)
)
-- End creating customer table

-- Creating customer address table
create table customer_address(
-- Columns for customer address table
		customer_address_ID int identity
		,street_address varchar(50) not null
		, city varchar(30) not null
		, state varchar(30) not null
		, zip_code varchar(10) not null
		, customer_ID int not null
-- Constraints on the customer address table
constraint PK_customer_address primary key (customer_address_ID),
constraint FK1_customer_address foreign key (customer_ID) references customer(customer_ID)
)
-- End creating customer address table

-- Creating registration status table
create table registration_status(
-- Columns for registration status table
			registration_status_ID int identity
			, registration_status bit
-- Constraints on registration status table
constraint PK_registration_status primary key (registration_status_ID),
constraint U1_registration_status unique (registration_status)
)
-- End creating registration_status table

-- Creating customer registration table
create table customer_registration(
-- Columns for customer registration table
			customer_registration_ID int identity
			, customer_ID int not null
			, registration_status_ID int not null
-- Constraints on customer registration table
constraint PK_customer_registration primary key (customer_registration_ID),
constraint FK1_customer_registration foreign key (customer_ID) 
references customer(customer_ID),
constraint FK2_customer_registration foreign key (registration_status_ID) 
references registration_status(registration_status_ID)
)
-- End creating customer registration table

-- Creating order source table
create table order_source(
		order_source_ID int identity
		, source_type varchar(30) not null
--constraints on order_source table
constraint PK_order_source primary key (order_source_ID),
constraint U1_order_source unique (source_type)
)
-- End creating order source table

-- Creating order status table
create table order_status(
		order_status_ID int identity
		, order_status_type varchar(30) not null
--constraints on order status table
constraint PK_order_status primary key (order_status_ID),
constraint U1_order_status unique (order_status_type)
)
-- End creating order status table

-- Creating order destination table
create table order_destination(
		order_destination_ID int identity
		, destination_type varchar(30) not null
--constraints on order destination table
constraint PK_order_destination primary key (order_destination_ID),
constraint U1_order_destination unique (destination_type)
)
-- End creating order destination table

-- Creating order ready table
create table order_ready(
		order_ready_ID int identity
		, order_ready_date datetime
		, order_ready_time time
--constraints on order ready table
constraint PK_order_ready primary key (order_ready_ID),
constraint U1_order_ready unique (order_ready_date)
)
-- End creating order ready table

-- Creating order placed table
create table order_placed(
		order_placed_ID int identity
		, order_placed_date datetime
		, order_placed_time time
--constraints on order placed table
constraint PK_order_placed primary key (order_placed_ID),
constraint U1_order_placed unique (order_placed_date)
)
-- End creating order placed table

-- Creating product table
create table product(
		product_ID int identity
		, product_name varchar(50) not null
		, product_type varchar(30) not null
		, item_cost money
--constraints on product table
constraint PK_product primary key (product_ID),
)
-- End creating product table

-- Creating product details table
create table product_details(
		product_details_ID int identity
		, quantity int not null
		, product_cost money
		, product_ID int
--constraints on product details table
constraint PK_product_details primary key (product_details_ID),
constraint FK_product_details foreign key (product_ID) references product(product_ID)
)
-- End creating product details table

-- Creating payment type table
create table payment_type(
		payment_type_ID int identity
		, payment_type varchar(15) not null
		, payment_name varchar(15) not null
--constraints on payment type table
constraint PK_payment_type primary key (payment_type_ID),
)
-- End creating payment type table

-- Creating payment transaction table
create table payment_transaction(
		payment_transaction_ID int identity
		, auth_code varchar(15)
		, auth_description varchar(50)
		, auth_amount money
		, auth_date datetime
		, auth_time time
		, payment_type_ID int
--constraints on payment transaction table
constraint PK_payment_transaction primary key (payment_transaction_ID),
constraint U1_payment_transaction unique (auth_code),
constraint FK_payment_transaction foreign key (payment_type_ID) references payment_type(payment_type_ID)
)
-- End creating payment transaction table

-- Creating payment method table
create table payment_method(
		payment_method_ID int identity
		, order_payment_amount money
		, payment_transaction_ID int
		, payment_type_ID int
--constraints on payment method table
constraint PK_payment_method primary key (payment_method_ID),
constraint FK1_payment_method foreign key (payment_transaction_ID)
references payment_transaction(payment_transaction_ID),
constraint FK2_payment_method foreign key (payment_type_ID) 
references payment_type(payment_type_ID)
)
-- End creating payment method table

-- Creating customer account table
create table customer_account(
		customer_account_ID int identity
		, customer_ID int
		, customer_address_ID int
		, payment_type_ID int
--constraints on customer account table
constraint PK_customer_account primary key (customer_account_ID),
constraint FK1_customer_account foreign key (customer_ID)
references customer(customer_ID),
constraint FK2_customer_account foreign key (customer_address_ID)
references customer_address(customer_address_ID),
constraint FK3_customer_account foreign key (payment_type_ID) 
references payment_type(payment_type_ID)
)
-- End creating customer account table

-- Creating customer account to payment type table
create table customer_account_to_payment_type(
		customer_account_to_payment_type_ID int identity
		, payment_type_ID int
		, customer_account_ID int
--constraints on customer account to payment type table
constraint PK_customer_account_to_payment_type primary key (customer_account_to_payment_type_ID),
constraint FK1_customer_account_to_payment_type foreign key (customer_account_ID)
references customer_account(customer_account_ID),
constraint FK2_customer_account_to_payment_type foreign key (payment_type_ID) 
references payment_type(payment_type_ID)
)
-- End creating customer account to payment type table

-- Creating order detail table
create table order_detail(
		order_detail_ID int identity
		, order_confirmation_number varchar(10) not null
		, order_ready_ID int
		, customer_ID int
		, product_details_ID int
		, order_source_ID int
		, order_destination_ID int
		, order_placed_ID int
		, coupon_ID int
		, payment_method_ID int
--constraints on order detail table
constraint PK_order_detail primary key (order_detail_ID),
constraint U1_order_detail unique (order_confirmation_number),
constraint FK1_order_detail foreign key (order_ready_ID)
references order_ready(order_ready_ID),
constraint FK2_order_detail foreign key (customer_ID) 
references customer(customer_ID),
constraint FK3_order_detail foreign key (product_details_ID)
references product_details(product_details_ID),
constraint FK4_order_detail foreign key (order_source_ID)
references order_source(order_source_ID),
constraint FK5_order_detail foreign key (order_destination_ID)
references order_destination(order_destination_ID),
constraint FK6_order_detail foreign key (order_placed_ID)
references order_placed(order_placed_ID),
constraint FK7_order_detail foreign key (coupon_ID)
references coupon(coupon_ID),
constraint FK8_order_detail foreign key (payment_method_ID)
references payment_method(payment_method_ID)
)
-- End creating order detail table

-- Creating coupon detail table
create table coupon_detail(
		coupon_detail_ID int identity
		, coupon_type_ID int
		, discounted_item_ID int
		, coupon_start_date datetime
		, coupon_type_details varchar(30) not null
		, coupon_expiry_date datetime
		, coupon_application_days varchar(15)
		, coupon_amount money
		, coupon_applied bit
		, exclusive_coupon bit
		, discounted_product_quantity int
		, coupon_discount_percent decimal(5,2)
		, product_ID int
--constraints on coupon detail table
constraint PK1_coupon_detail primary key (coupon_detail_ID),
constraint FK1_coupon_detail foreign key (product_ID)
references product(product_ID),
)
-- End creating coupon detail table

-- Creating coupon detail table
create table coupon_detail(
		coupon_detail_ID int identity
		, coupon_type_ID int
		, discounted_item_ID int
		, coupon_start_date datetime
		, coupon_type_details varchar(30) not null
		, coupon_expiry_date datetime
		, coupon_application_days varchar(15)
		, coupon_amount money
		, coupon_applied bit
		, exclusive_coupon bit
		, discounted_product_quantity int
		, coupon_discount_percent decimal(5,2)
		, product_ID int
--constraints on coupon detail table
constraint PK1_coupon_detail primary key (coupon_detail_ID),
constraint FK1_coupon_detail foreign key (product_ID)
references product(product_ID),
)
-- End creating coupon detail table

-- Creating coupon table
create table coupon(
		coupon_ID int identity
		, coupon_name varchar(30) not null
		, coupon_description varchar(50) not null
		, coupon_detail_ID int
--constraints on coupon table
constraint PK_coupon primary key (coupon_ID),
constraint FK1_coupon foreign key (coupon_detail_ID)
references coupon_detail(coupon_detail_ID),
)
-- End creating coupon table
go
-- Stored Procedure to create new customer
create procedure new_customer(
				@firstname varchar(30), 
				@lastname varchar(30), 
				@phonenumber varchar(15),
				@emailaddress varchar(50)
) as
begin

	declare @customerID int
-- Get the customer ID from the customer table and store it in @customerID
	select @customerID = customer_ID from customer
	where customer_ID = @customerID
-- Insert new customer record in customer table
	insert into customer(first_name, last_name, phone_number,email_address)
	values (@firstname, @lastname, @phonenumber, @emailaddress) 
-- increment customerID using @@identity
	return @@identity
end

exec new_customer 'Katrina','Adams','7876650091','kadams@syr.edu'

go
-- Stored Procedure to create customer address
alter procedure customeraddress(
				@streetaddress varchar(50), 
				@city varchar(30), 
				@state varchar(30),
				@zipcode varchar(10),
				@customerID int
) as
begin

	declare @customeraddressID int
/*
	Get the customeraddress ID from the customer adress table 
	by joining the customerID of customer 
	table with customer address table
	and store it in @customerID
*/
	select @customeraddressID = customer_address_ID 
	from customer_address
	join customer 
	on customer.customer_ID = customer_address.customer_ID
	
-- Insert new customer adress
	insert into customer_address(street_address, city, state,zip_code, customer_ID)
	values (@streetaddress, @city, @state, @zipcode, @customerID) 
-- increment customerID using @@identity
	return @@identity
end

exec customeraddress '450 Westport Rd.', 'Orlando', 'FL', '32801 ', 10

--Insert status in registration status table
insert into registration_status(registration_status)
values (1)

-- Insert record in customer registation table
insert into customer_registration (customer_ID, registration_status_ID)
values(1, 2)
insert into customer_registration (customer_ID, registration_status_ID)
values(2, 2)
insert into customer_registration (customer_ID, registration_status_ID)
values(3, 2)
insert into customer_registration (customer_ID, registration_status_ID)
values(4, 1)
insert into customer_registration (customer_ID, registration_status_ID)
values(5, 2)
insert into customer_registration (customer_ID, registration_status_ID)
values(6, 1)
insert into customer_registration (customer_ID, registration_status_ID)
values(7, 2)
insert into customer_registration (customer_ID, registration_status_ID)
values(8, 2)
insert into customer_registration (customer_ID, registration_status_ID)
values(9, 1)
insert into customer_registration (customer_ID, registration_status_ID)
values(10, 2)

-- Insert record in order status table
insert into order_status (order_status_type)
values ('In Progress')
insert into order_status (order_status_type)
values ('In Oven')
insert into order_status (order_status_type)
values ('Ready')insert into order_status (order_status_type)
values ('Completed')

-- Insert order source table
insert into order_source (source_type)
values ('Online')

-- Insert records in order destination table
insert into order_destination(destination_type)
values('Delivery')
insert into order_destination(destination_type)
values('Carryout')

-- Insert data in product table
insert into product (product_name, product_type, item_cost)
values ('Medium Pizza', 'Pizza', $15.43)
insert into product (product_name, product_type, item_cost)
values ('Small Pizza', 'Pizza', $12.43)
insert into product (product_name, product_type, item_cost)
values ('Large Pizza', 'Pizza', $17.43)
insert into product (product_name, product_type, item_cost)
values ('Extra Large Pizza', 'Pizza', $20.43)
insert into product (product_name, product_type, item_cost)
values ('6 pcs Chicken Nuggets', 'Chicken', $6.99)
insert into product (product_name, product_type, item_cost)
values ('10 pcs Chicken Nuggets', 'Chicken', $8.99)
insert into product (product_name, product_type, item_cost)
values ('12 pcs Chicken Nuggets', 'Chicken', $10.99)
insert into product (product_name, product_type, item_cost)
values ('Tomato', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Chicken', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Jalapeno', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Black Olives', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Green Olives', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Cheese', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Pepperoni', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Italian sausage', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Bacon', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Pineapple', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Peppers', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Beef', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Mushrooms', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Onions', 'Sides', $0.99)
insert into product (product_name, product_type, item_cost)
values ('Green bell peppers', 'Sides', $0.99)


go
-- Create function to multiply quantity with product price

create function product_price(@quantity int, @itemcost money)
returns money as
begin
	declare @returnvalue money

	set @returnvalue = @quantity * @itemcost

	return @returnvalue
end
go

-- Inserting data in product details table
insert into product_details (quantity, product_cost, product_ID)
values (3, dbo.product_price(3,12.43) , 2)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (4, dbo.product_price(4,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (2, dbo.product_price(2,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,10.99), 7)
insert into product_details (quantity, product_cost, product_ID)
values (2, dbo.product_price(2,6.99), 5)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (2, dbo.product_price(2,20.43), 4)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,12.43), 2)
insert into product_details (quantity, product_cost, product_ID)
values (2, dbo.product_price(2,15.43), 1)
insert into product_details (quantity, product_cost, product_ID)
values (3, dbo.product_price(3,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,12.43), 2)
insert into product_details (quantity, product_cost, product_ID)
values (3, dbo.product_price(3,10.99), 7)
insert into product_details (quantity, product_cost, product_ID)
values (5, dbo.product_price(5,12.43), 2)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,17.43), 3)
insert into product_details (quantity, product_cost, product_ID)
values (1, dbo.product_price(1,17.43), 3)

-- Inserting record in payment type table
insert into payment_type(payment_type, payment_name)
values ('Cash', 'Cash')
insert into payment_type(payment_type, payment_name)
values ('Card', 'MasterCard')
insert into payment_type(payment_type, payment_name)
values ('Card', 'Visa')
insert into payment_type(payment_type, payment_name)
values ('Card', 'Discover')
insert into payment_type(payment_type, payment_name)
values ('Card', 'American Express')

-- Insert data in payment_transaction table
	insert into payment_method(order_payment_amount, payment_transaction_ID, payment_type_ID)
	values ((select auth_amount from payment_transaction
			 where payment_transaction_ID = 13), 
			 (select payment_transaction_ID from payment_transaction
			  where payment_transaction_ID = 13),
			  (select payment_type_ID from payment_transaction
			   where payment_transaction_ID = 13)
			  )	
go
-- Stored Procedure to create new payment method
create procedure new_payment_method(@paymenttransactionID int) as
begin
	
	select @paymenttransactionID = payment_transaction_ID from payment_transaction
	where payment_transaction_ID = @paymenttransactionID
-- Insert new data in payment method table
insert into payment_method(order_payment_amount, payment_transaction_ID, payment_type_ID)
	values ((select auth_amount from payment_transaction
			 where payment_transaction_ID = @paymenttransactionID), 
			 (select payment_transaction_ID from payment_transaction
			  where payment_transaction_ID = @paymenttransactionID),
			  (select payment_type_ID from payment_transaction
			   where payment_transaction_ID = @paymenttransactionID)
			  )	

end

exec new_payment_method 54
		   
		   
		   		




insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01ABD', 'credit card transaction', 69.72, 09-20-2018, CURRENT_TIMESTAMP, 2)-- 5
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01AB2', 'credit card transaction', 37.29, 08-19-2018, CURRENT_TIMESTAMP, 3)-- 2
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values (null, null, 17.43, 01-01-2018, CURRENT_TIMESTAMP, 1)--1
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01BGF', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 4), 04-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 4))--4
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01B3F', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 6), 01-20-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID =2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('5BYI', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 7), 09-20-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3)) -- RUN THIS CODE
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01BGF1', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 8), 12-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type
where payment_type_ID = 3))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01BGJ', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 9), 03-20-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01BGFS', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 10), 02-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 4))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('98BYT', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 11), 06-20-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('4BER', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 12), 04-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01DKU', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 13), 04-23-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('04YTB', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 14), 04-05-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('01VGF', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 15), 01-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 4))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('4GTF3', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 16), 04-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))--RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('5BWER', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 17), 04-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 4)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('9LKI', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 18), 04-20-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('1NYE', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 19), 01-01-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('1TGE', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 20), 02-20-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('5NYR', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 21), 06-28-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('4BYH', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 22), 01-12-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('6NYC', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 23), 09-16-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 4))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('7UNO', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 24), 07-22-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('8GRT', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 25), 03-02-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 4))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('5BUM', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 26), 07-08-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('9NTH', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 27), 01-12-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('0LOK', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 29), 01-01-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('8MNY', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 30), 02-16-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('5BTG', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 31), 04-16-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('8NTM', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 32), 05-02-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('7BTE', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 33), 05-19-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('0L7M', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 34), 05-21-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 4)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('9MUN', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 35), 05-02-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 3))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('4BYUR', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 36), 03-03-2017, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('4BUUI', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 37), 04-20-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2)) -- RUN THIS
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('7MYT', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 38), 02-07-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))
insert into payment_transaction (auth_code, auth_description, auth_amount, auth_date,auth_time, payment_type_ID)
values ('7M6G', 'credit card transaction', (select product_cost from product_details 
where product_details_ID = 38), 06-17-2018, CURRENT_TIMESTAMP, (select payment_type_ID from payment_type 
where payment_type_ID = 2))





















