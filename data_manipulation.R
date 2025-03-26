library(rio)
library(DBI)
library(RSQLite)
library(dplyr)
library(lubridate)

# Data
data2010 <- import("data/online_retail_2010.csv")

data2010 <- data2010 |>
  as_tibble() |>
  rename(CustomerID = `Customer ID`) |>
  filter(!is.na(CustomerID)) |>
  mutate(
    Country = as.factor(Country),
    StockCode = as.factor(StockCode),
    Description = factor(Description, levels = unique(Description[order(StockCode)])),
    InvoiceDate = as.Date(dmy_hm(InvoiceDate)),
    Revenue = Quantity * Price
  )

conn <- DBI::dbConnect(RSQLite::SQLite(), "data/retail_data.db")

dbWriteTable(conn, "data2010", data2010, overwrite = TRUE)

query_data2010 <- "SELECT * FROM data2010"
data2010db <- dbGetQuery(conn, query_data2010)

names(data2010db)
