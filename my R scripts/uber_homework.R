# Load Data
uber_data <- read.csv("uber_data.csv")
View(uber_data)
# Exploratory Analysis
summary(uber_data)
hist(subset(uber_data, trips_in_first_30_days <25)$trips_in_first_30_days, 30)

#cleaning  
uber_data$signup_date <- as.yearmon("Mar 2012", "%b %Y") #make signup_date date class
uber_data$signup_month <- month(as.POSIXlt(uber_data$signup_date, format="%d/%m/%Y")) # create new column, month of signup
class(uber_data$signup_date)

# Multiple Linear Regression
fit <- lm(trips_in_first_30_days ~ avg_surge + phone + avg_dist, data = uber_data)
summary(fit)

# Other useful functions 
coefficients(fit) # model coefficients
confint(fit, level=0.95) # CIs for model parameters 
fitted(fit) # predicted values
residuals(fit) # residuals
anova(fit) # anova table 
vcov(fit) # covariance matrix for model parameters 
influence(fit) # regression diagnostics

# Assessing Outliers
outlierTest(fit) # Bonferonni p-value for most extreme obs
qqPlot(fit, main="QQ Plot")

# diagnostic plots
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page
plot(fit) #print graphs

# Creating a Graph
attach(uber_data)
plot(trips_in_first_30_days, signup_date) 
abline(lm(mpg~wt))
title("Regression of MPG on Weight")

library(lubridate)
some_date <- c("01/02/1979", "03/04/1980")
month(as.POSIXlt(some_date, format="%d/%m/%Y"))
View("some_date")
