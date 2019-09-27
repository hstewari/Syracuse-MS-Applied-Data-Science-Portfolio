# Ready RODBC for use in this script
require(RODBC)

#create a connection to SQL Server using 64-bit DSN
myconn <- odbcConnect("IST 659_Project")

#SQL statement to see customer address and registration status
sqlSelectStatement <-
  "select * 
    from customer_registration_details 
    order by registration_status desc
"

# Send the request to the server and store the result in a variable
sqlResult <- sqlQuery(myconn, sqlSelectStatement)
# SQL query to compare between guest and registered customer
sqlSelectStatement1 <-
"
select * 
from customer_registration_details
order by registration_status desc
"
# Send the request to the server and store the result in a variable
sqlResult1 <- sqlQuery(myconn, sqlSelectStatement1)

# Create a list of guest and registerd customer
customer <- c("guest customer", "registered customer")

#Plot a bar chart of comparison between guest and registered customer
registrationCount <- table(sqlResult1$registration_status)
barplot(registrationCount,
        main = "hstewari Comparison between Guest & Registered Customer",
        ylab = "Registration Status",
        xlab = "Number of Users",
        border = "blue",
        names.arg = customer
)

# SQL query to to find out the most popular product sold
sqlSelectStatement2 <-
  "
select 
     product.product_name
	   , product_details.quantity  
from product
join product_details on product.product_ID = product_details.product_ID
"
# Send the request to the server and store the result in a variable
sqlResult2 <- sqlQuery(myconn, sqlSelectStatement2)

# Create a list of products
products <- c("L Pizza", "S Pizza", "12 Nuggets", "6 Nuggets", 
              "XL Pizza")

#Plot a bar chart to find out the most popular product sold
productQty <- table(sqlResult2$quantity)
barplot(productQty,
        main = "hstewari Most popular product sold",
        ylab = "Product Quantity",
        xlab = "Product Name",
        border = "red",
        col = "light blue",
        names.arg = products
)




# Close all connections
odbcCloseAll()

#Fin

