
## WHILE 

z <- 5

while (z >=3 && z<=10){
  print(z)
  coin <- rbinom(1,1,0.5)
  
  if(coin == 1) { ## random walk
      z <- z + 1
  } else {
      z <- z - 1 
  }
}

## REPEAT

x0 <- 1 
tol <- le-8 ## = 10^-8

repeat {
        x1 <- computeEstimate() ## no function here, so won't run
        
        if(abs(x1-x0) < tol) {
          
          break
        
          } else {
            x0 <- x1 
        }
}

## NEXT & RETURN

for (i in 1:100) {
    if(i <= 20) {
        ## Skip the first 20 iterations
      next
    }
    ## do something here
}

## FUNCTIONS() 1

columnmean <- function(y, removeNA = TRUE) {
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc){
      means[i] <- mean(y[, i], na.rm = removeNA)
  }
  means
}

hwk1data <- read.csv("hw1_data.csv")

columnmean(hwk1data)

## ARGUMENT MATCHING
mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm  = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)

## LAPPLY

## example 1

x <- list(a = 1:5, b = rnorm(10))

lapply(x,mean)

## example 2

x <- list(a = 1:4, b= rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
lapply(x,mean)

## example 3

x <- 1:4
lapply(x,runif)

# example 4
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6,3,2))
x

# TAPPLY

x <- c(rnorm(10), runif(10), rnorm(10,1))
f<- gl(3,10)


## SPLIT

x <- c(rnorm(10), runif(10), rnorm(10,1))
f<- gl(3,10, labels = c("level 1", "level 2", "level 3"))
split(x,f)
x
lapply(split(x,f),mean))

# excercise 2

s <- split(airquality, airquality$Month)
lappy(s, function)
