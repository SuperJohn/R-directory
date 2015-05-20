## Lists

## CReating Lists
(a_list <- list(
  c(1,1,2,5,14)
  , month.abb
  , matrix(c(3,-8,1,-3), nrow = 2)
  , asin
  ))

names(a_list) <-c("catalan", "months","involuntary", "arcsin")
a_list

(a_list <- list(
  catalan = c(1,1,2,5,14)
  , months = month.abb
  , involuntary = matrix(c(3,-8,1,-3), nrow = 2)
  , arcsin = asin
))
library(sqldf)
View(a<- sqldf("select distinct(last_trip_date)  from uber_data order by last_trip_date desc limit 10"))
View(head(uber_data))
