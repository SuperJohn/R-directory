libraray(ISLR)
View(head(Wage))
library(ggplot2)
ggplot(Wage, aes(x = age, y = wage)) + geom_point()+ stat_quantile(method = "rqss")
ggplot(Wage, aes(x = year, y = wage)) + geom_point() + stat_quantile(method = "rqss")
ggplot(Wage, aes(x = education, y = wage)) + geom_jitter() + geom_boxplot()


## Stock Market Classification Problem
## Will the S&P be 'up' or 'down' tomorrow? 
libraray(ISLR)
View(head(Smarket))
library(ggplot2)
ggplot(Smarket,aes(x=Direction,y=Today, factor = Direction, colour=Direction)) + geom_jitter() + geom_boxplot()
ggplot(Smarket,aes(x=Direction,y=Lag2, factor = Direction, colour=Direction)) + geom_jitter() + geom_boxplot()
ggplot(Smarket,aes(x=Direction,y=Lag3, factor = Direction, colour=Direction)) + geom_jitter() + geom_boxplot()
