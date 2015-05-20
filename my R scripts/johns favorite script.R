.svexpandables_data = read.csv("expandables_data.csv")
View(expandables_data)
 hist(expandables_data$cpm)
> hist(log(expandables_data$cpm)
       + )
> summary(log(expandables_data$cpm))
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
-Inf       3       3    -Inf       4      11 
> summary(expandables_data$cpm)
Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
0.00    14.28    30.00    84.32    71.00 74700.00 

mean<-mean(expandables_data$cpm)
stdev<-sd(expandables_data$cpm)


range(expandables_data$cpm)
expandables_data$z<- (expandables_data$cpm - mean)/stdev
View(expandables_data)
hist(expandables_data$z)
View(expandables_data,expandables_data$cpm<0)


