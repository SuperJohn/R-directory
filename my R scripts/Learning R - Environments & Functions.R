an_environment <- new.env()
an_environment[["pythag"]] <- c(12,15,20,21)
an_environment$root <- polyroot(c(6,-5,1))

# Assigning a value to a particular environment
assign(
    "moonday"
    , weekdays(as.Date("1969/07/20"))
    , an_environment
    )
an_environment[["pythag"]]
an_environment$root
get("moonday", an_environment)
ls(name = an_environment)


## Functions
hypotenuse <- function(x, y)
{
  sqrt(x ^ 2 + y ^ 2)
}
hypotenuse(3,2)

hypotenuse <- function(x, y) sqrt(x ^ 2 + y ^ 2)   #same as before

hypotenuse(1:6,2)

#default values
hypotenuse <- function(x = 5, y = 12)
{
  sqrt(x ^ 2 + y ^ 2)
}
hypotenuse() #equivalent to hypotenuse(5, 12)
formals(hypotenuse)
args(hypotenuse)
formalArgs(hypotenuse)
(body_of_hypotenuse <- body(hypotenuse))

## Normalize a vector of integers
normalize <- function(x, m = mean(x), s = sd(x))
{
  (x - m) / s
}
normalized <- normalize(c(1, 3, 6, 10, 15))
mean(normalized)        #almost 0!
sd(normalized)

## Converting Continuous Variables to Categorical
ages <- 16 + 50 * rbeta(10000, 2, 3)
grouped_ages <- cut(ages, seq.int(16, 66, 10))
head(grouped_ages)
