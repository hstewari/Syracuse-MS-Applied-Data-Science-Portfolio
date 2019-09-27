select * from customer
select * from customer_address
select * from registration_status
select * from customer_registration
select * from order_status
select * from order_source
select * from order_destination
select * from product
select * from product_details
select * from payment_type
select * from payment_transaction
select * from payment_method

delete from payment_transaction where payment_transaction_ID = 39


update payment_transaction set auth_date = '06-22-2018' where payment_transaction_ID = 5


select COUNT(*) from payment_transaction where auth_date in ('%2017-%')

select DATEPART(yyyy,auth_date) as Year from payment_transaction 

alter table payment_transaction
add auth_year int

select sum(payment_method.order_payment_amount)
	 from payment_method
join payment_transaction
on payment_method.payment_transaction_ID = payment_transaction.payment_transaction_ID
where  auth_date between '2017-01-01' and '2017-12-31'


select sum(payment_method.order_payment_amount),
	 from payment_method
join payment_transaction
on payment_method.payment_transaction_ID = payment_transaction.payment_transaction_ID
where  auth_date between '2018-01-01' and '2018-12-31'

select payment_method.order_payment_amount

	 from payment_method
join payment_transaction
on payment_method.payment_transaction_ID = payment_transaction.payment_transaction_ID

-- SQL query to compare between guest and registered customer
select * from customer_registration_details order by registration_status desc


-- Use the database to compare the sale of current year to last year
go
-- Create a view to compare sales between years
create view amount_year as(
select YEAR(auth_date) as auth_year, auth_amount from payment_transaction
)
-- Run the view
select SUM(auth_amount) as yearly_sales, auth_year as sales_year from amount_year group by auth_year

-- Use the database to find out the most popular product
select * from product_sold_details order by product_cost desc