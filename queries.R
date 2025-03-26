# Using only SQL queries and commands, let's answer the below questions

# How much total revenue was generated?
total_revenue <- "SELECT SUM(Revenue) AS TotalRevenue 
  FROM data2010"

sum_revenue <- dbGetQuery(conn, total_revenue)

print(sum_revenue)
#8348209

# Which product generated the highest revenue?
highest_revenue_product <- dbGetQuery(conn, "
  SELECT StockCode, Description, 
         ROUND(SUM(Revenue), 2) AS TotalRevenue
  FROM data2010
  GROUP BY StockCode, Description
  ORDER BY TotalRevenue DESC
  LIMIT 5
")
print("Top 5 Products by Revenue:")
print(highest_revenue_product)

# Which countries had the highest total sales?
highest_sales_countries <- dbGetQuery(conn, "
  SELECT Country, 
         ROUND(SUM(Revenue), 2) AS TotalSales,
         COUNT(DISTINCT Invoice) AS NumberOfInvoices
  FROM data2010
  GROUP BY Country
  ORDER BY TotalSales DESC
  LIMIT 10
")
print("Top 10 Countries by Sales:")
print(highest_sales_countries)

# What are the total sales per month?


# Which customer placed the most orders?
top_customers <- dbGetQuery(conn, "
  SELECT 
    `Customer ID`, 
    COUNT(DISTINCT Invoice) AS NumberOfOrders,
    ROUND(SUM(Revenue), 2) AS TotalPurchases
  FROM data2010
  GROUP BY `CustomerID`
  ORDER BY NumberOfOrders DESC
  LIMIT 10
")
print("Top 10 Customers by Number of Orders:")
print(top_customers)

# Additional insights
additional_insights <- dbGetQuery(conn, "
  SELECT 
    COUNT(DISTINCT StockCode) AS UniqueProducts,
    COUNT(DISTINCT Invoice) AS TotalInvoices,
    ROUND(SUM(Revenue), 2) AS TotalRevenue,
    ROUND(AVG(Revenue), 2) AS AverageOrderValue
  FROM data2010
")
print("Overall Dataset Insights:")
print(additional_insights)