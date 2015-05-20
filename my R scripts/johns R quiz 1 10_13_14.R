> View(hw1_data.csv[x=47])
Error in View : object 'hw1_data.csv' not found
> View(superjohn1[x=47])
Warning in View :
  named arguments other than 'drop' are discouraged
Error in View : undefined columns selected
> View(superjohn1,[x=47])
Error: unexpected '[' in "View(superjohn1,["
> View(superjohn1[47])
Error in View : undefined columns selected
> superjohn1[x>150]
data frame with 0 columns and 153 rows
> superjohn1= read.csv("hw1_data.csv")
> superjohn1[x=47]
Error in `[.data.frame`(superjohn1, x = 47) : undefined columns selected
In addition: Warning message:
  In `[.data.frame`(superjohn1, x = 47) :
  named arguments other than 'drop' are discouraged
> View(superjohn1)
> a<-superjohn1$Ozone
> b<-which(is.na(a))
> length(b)
[1] 37
> mean(superjohn1$Ozone)
[1] NA
> View(superjohn1$Ozone[1:4])
> View(superjohn1$Ozone)
> View(which(is.na(superjohn1$Ozone)))
> nrow((which(is.na(superjohn1$Ozone)))
       + )
NULL
> nrow(which(is.na(superjohn1$Ozone)))
NULL
> a<-which(is.na(superjohn1$Ozone))
> nrow(a)
NULL
> a<-which(!is.na(superjohn1$Ozone))
> nrow(a)
NULL
> View(which(!is.na(superjohn1$Ozone)))
> mean(which(!is.na(superjohn1$Ozone)))
[1] 82.98276
> median(which(!is.na(superjohn1$Ozone)))
[1] 89.5

View(superjohn1$Ozone)
superjohn1 = read.csv("hw1_data.csv")
