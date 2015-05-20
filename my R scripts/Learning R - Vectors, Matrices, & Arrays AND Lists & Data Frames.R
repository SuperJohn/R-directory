# Vectors, Matrices, and Arrays


seq.int(3, 12, 2)
seq.int(0.1, 0.01, -0.01)

n <- 0
1:n        #not what you might expect!
seq_len(n)


pp <- c("Peter", "Piper", "picked", "a", "peck", "of", "pickled", "peppers")
for(i in seq_along(pp)) print(pp[i])

## Lengths
length(1:5)
length(c(TRUE, FALSE, NA))
sn <- c("Sheena", "leads", "Sheila", "needs")
length(sn)
nchar(sn)

poincare <- c(1, 0, 0, 0, 2, 0, 2, 0)  #See http://oeis.org/A051629
length(poincare) <- 3
poincare
length(poincare) <- 8
poincare


#NAMES
c(apple = 1, banana = 2, "kiwi fruit" = 3, 4)
x <- 1:4
names(x) <- c("apple", "bananas", "kiwi fruit", "")
x
names(x)
names(1:4)

#Indexing Vectors
x <- (1:5) ^ 2
x
x[c(1, 3, 5)]
x[c(-2, -4)]
x[c(TRUE, FALSE, TRUE, FALSE, TRUE)]
names(x) <- c("one", "four", "nine", "sixteen", "twenty five")
x[c("one", "nine", "twenty five")]
x[c(1, NA, 5)]
x[c(TRUE, FALSE, NA, FALSE, TRUE)]
x[c(-2, NA)]     #This doesn't make sense either!
x[6]
x[1.9]   #1.9 rounded to 1

x[c(1, -1)]      #This doesn't make sense!

## Lists and Data Frames

# Creating Lists
(a_list <- list(
  c(1, 1, 2, 5, 14, 42),    #See http://oeis.org/A000108
  month.abb,
  matrix(c(3, -8, 1, -3), nrow = 2),
  asin
))

names(a_list) <- c("catalan", "months", "involutary", "arcsin")
a_list

the_same_list <- list(
  catalan    = c(1, 1, 2, 5, 14, 42),
  months     = month.abb,
  involutary = matrix(c(3, -8, 1, -3), nrow = 2),
  arcsin     = asin
))

(main_list <- list(
  middle_list          = list(
    element_in_middle_list = diag(3),
    inner_list             = list(
      element_in_inner_list         = pi ^ 1:4,
      another_element_in_inner_list = "a"
    )
  ),
  element_in_main_list = log10(1:10)
))

# Atomic and Recursive Variables
# * Vectors, matrices, and arrays, by contrast, are atomic. * 
is.atomic(list())
is.recursive(list())
is.atomic(numeric())
is.recursive(numeric())

# List Dimensions and Arithmetic

#Indexing LIsts
l <- list(
  first  = 1,
  second = 2,
  third  = list(
    alpha = 3.1,
    beta  = 3.2
  )
)
class(l)
l[1]
l[[1]]
is.list(l[1])
is.list(l[[1]])
class(l[1])
class(l[[1]])
l
l$first
l$f     #partial matching interprets "f" as "first"

l[["third"]]["beta"]
class(l[["third"]]["beta"])
l[["third"]][["beta"]]
class(l[["third"]][["beta"]])
l[[c("third", "beta")]]
class(l[[c("third", "beta")]])

# Converting Between Vectors and Lists
busy_beaver <- c(1, 6, 21, 107)  #See http://oeis.org/A060843
busy_beaver
as.list(busy_beaver)

(prime_factors <- list(
  two   = 2,
  three = 3,
  four  = c(2, 2),
  five  = 5,
  six   = c(2, 3),
  seven = 7,
  eight = c(2, 2, 2),
  nine  = c(3, 3),
  ten   = c(2, 5)
))
prime_factors[1]
prime_factors[3]
prime_factors[3][[1]]
# This sort of list can be converted to a vector using the function unlist
unlist(prime_factors)
prime_factors1<-unlist(prime_factors)
as.list(prime_factors1)

#Combining Lists

## Creating repeated sequences
rep(1:5, 3)
as.list(rep(1:5, 3))
rep(1:5, each = 3)
rep(1:5, times = 1:5)
?rep()
rep(1:5, length.out = 7)
rep.int(1:5, 3)  #the same as rep(1:5, 3)
rep_len(1:5, 13)
?rep_len()
rep(c(1,3), times = 4, length.out = 7)

# Creating Arrays and Matrices
three_d_array <- array(
  1:48,
  dim = c(4, 3, 4),
  dimnames = list(
    c("revenue", "ticket sales", "banjos", "costs"),
    c("your mom", "ponies", "broccoli"),
    c("AWESOME DATA", "SUCK THESE NUMBERS", "i MADE THIS SHIT UP", "ROI DATA")
  )
)
three_d_array
nrow(three_d_array)
ncol(three_d_array)

array(1:24
      , dim = c(4,6,2)
      )
class(three_d_array)
(two_d_array <- array(
  1:12,
  dim = c(4, 3),
  dimnames = list(
    c("one", "two", "three", "four"),
    c("ein", "zwei", "drei")
  )
))

(a_matrix <- matrix(
  1:12,
  nrow = 4,            #ncol = 3 works the same
  dimnames = list(
    c("one", "two", "three", "four"),
    c("ein", "zwei", "drei")
  )
))
?matrix()
a_matrix

identical(two_d_array, a_matrix)

(matrix2<-matrix(
  1:12,
  nrow = 4,
  byrow = TRUE,
  dimnames = list(
    c("one", "two", "three", "four"),
    c("ein", "zwei", "drei")
  )
) 
)
matrix2
a_matrix

(matrix3<-matrix(
  rep(1:4, 3),
  nrow = 4,
  byrow = TRUE,
  dimnames = list(
    c("one", "two", "three", "four"),
    c("john", "sarah", "doggy")
  )
) 
)

dim(matrix2)
dim(matrix3)

nrow(a_matrix)
ncol(a_matrix)

nrow(three_d_array)
ncol(three_d_array)

a_matrix
three_d_array

length(a_matrix)
length(three_d_array)

identical(nrow(a_matrix), NROW(a_matrix))
identical(ncol(a_matrix), NCOL(a_matrix))

# NROW and NCOL pretend vectors are matrices with a single column

recaman <- c(0, 1, 3, 6, 2, 7, 13, 20)
nrow(recaman)
## NULL
NROW(recaman)
## [1] 8
ncol(recaman)
## NULL
NCOL(recaman)
## [1] 1
dim(recaman)

# Row, Column, and Dimension Names
rownames(a_matrix)
colnames(a_matrix)
dimnames(a_matrix)

rownames(three_d_array)
colnames(three_d_array)
dimnames(three_d_array)

#Indexing Arrays
a_matrix[1, c("zwei", "drei")] #elements in 1st row, 2nd and 3rd columns
a_matrix[a_matrix$ein>1, ]  
a_matrix[, c("zwei", "drei")]  #all of the second and third columns

# Combining Matrices
(another_matrix <- matrix(
  seq.int(2, 24, 2),
  nrow = 4,
  dimnames = list(
    c("five", "six", "seven", "eight")
  )
))

c(a_matrix, another_matrix)
cbind(a_matrix, another_matrix)
?cbind()
