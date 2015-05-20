# Load Data
uber_data_clean_jh <- read.csv("uber_data_clean_jh.csv")
View(uber_data_clean_jh)
# Exploratory Analysis
summary(uber_data_clean_jh)
hist(subset(uber_data_clean_jh, trips_in_first_30_days <25)$trips_in_first_30_days, 30)
sapply(uber_data_clean_jh, class)

#cleaning  
uber_data_clean_jh[complete.cases(uber_data_clean_jh),]

# Multiple Linear Regression
fit <- lm(is_active ~ city + trips_in_first_30_days + avg_rating_of_driver+ avg_surge + d_iphone + d_android + avg_dist + is_uber_black_user + weekday_pct + avg_dist + avg_rating_by_driver, data = uber_data_clean_jh)
summary(fit)

# Logistic Regression
# where F is a binary factor and 
# x1-x3 are continuous predictors 
fit <- glm(is_active ~ city + trips_in_first_30_days + avg_rating_of_driver+ avg_surge + d_iphone + d_android + avg_dist + is_uber_black_user + weekday_pct + avg_dist + avg_rating_by_driver, data = uber_data_clean_jh,family=binomial)
# d_kings_landing + d_astapor + d_winterfell
summary(fit) # display results
confint(fit) # 95% CI for the coefficients
exp(coef(fit)) # exponentiated coefficients
exp(confint(fit)) # 95% CI for exponentiated coefficients
predict(fit, type="response") # predicted values
residuals(fit, type="deviance") # residuals

# Hoslem test for logistic predictive power
library(ResourceSelection)
hl <- hoslem.test(fit$is_active, fitted(fit), g=10)

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
attach(uber_data_clean_jh)
plot(uber_data_clean_jh$is_active, uber_data_clean_jh$avg_rating_of_driver) 
abline(lm(uber_data_clean_jh$is_active ~ uber_data_clean_jh$avg_rating_of_driver))
title("Regression of MPG on Weight")


