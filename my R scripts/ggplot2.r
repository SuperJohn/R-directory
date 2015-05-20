
### Adding objects to a ggplot object
library(ggplot2)
p <- qplot(x = wt, y= mpg, colour = hp, data = mtcars)
p
p + coord_cartesian(ylim = c(0, 40))
p + scale_colour_continuous(breaks = c(100, 300))
p + guides(colour = "colourbar")
# Use a different data frame
m <- mtcars[1:10, ]
p %+% m

### Adding objects to a theme object
# Compare these results of adding theme objects to other theme objects
add_el <- theme_grey() + theme(text = element_text(family = "Times"))
rep_el <- theme_grey() %+replace% theme(text = element_text(family = "Times"))
add_el$text
rep_el$text
class(add_el)
str(add_el)

## Creating a plot using random numbers!!! COOOLL!!!!
qplot(1:20, rnorm(20), colour = runif(20))
qplot(1:10, letters[1:10])

## Creating a plot using modeling data
mod <- lm(mpg ~ wt, data=mtcars)
qplot(resid(mod), fitted(mod))
qplot(resid(mod), fitted(mod), facets = . ~ vs)

## PLotting with a function!!!!
f <- function() {
  a <- 1:10
  b <- a ^ -3
  qplot(a, b)
}
f()

# qplot will attempt to guess what geom you want depending on the input
# both x and y supplied = scatterplot
qplot(mpg, wt, data = mtcars)
# just x supplied = histogram

qplot(mpg, data = mtcars)
hist(mtcars$mpg, breaks = 20)
# just y supplied = scatterplot, with x = seq_along(y)
qplot(y = mpg, data = mtcars)

# Use different geoms
qplot(mpg, wt, data = mtcars, colour = hp, geom="path")
qplot(factor(cyl), wt, data = mtcars,colour = hp, geom=c("boxplot", "jitter"))
qplot(factor(cyl), wt, data = mtcars,colour = hp, geom="jitter")
qplot(mpg, data = mtcars, geom = "dotplot")


aes(x = mpg, y = wt)
aes(x = mpg ^ 2, y = wt / cyl)
## aes_all Given a character vector, create a set of identity mappings
library(ggplot2)
aes_all(names(mtcars))
aes_all(c("x", "y", "col", "pch"))

## aes_auto Automatic aesthetic mapping
df <- data.frame(x = 1, y = 1, colour = 1, label = 1, pch = 1)
aes_auto(df)
aes_auto(names(df))
df <- data.frame(xp = 1, y = 1, colour = 1, txt = 1, foo = 1)
aes_auto(df, x = xp, label = txt)
aes_auto(names(df), x = xp, label = txt)
df <- data.frame(foo = 1:3)
aes_auto(df, x = xp, y = yp)
aes_auto(df)

## aes_colour_fill_alpha Colour related aesthetics: colour, fill and alpha
# Bar chart example
c <- ggplot(mtcars, aes(factor(cyl)))
# Default plotting
c + geom_bar()
# To change the interior colouring use fill aesthetic
c + geom_bar(fill = "red")
# Compare with the colour aesthetic which changes just the bar outline
c + geom_bar(colour = "red")
# Combining both, you can see the changes more clearly
c + geom_bar(fill = "white", colour = "red")
# The aesthetic fill also takes different colouring scales
# setting fill equal to a factor varible uses a discrete colour scale
k <- ggplot(mtcars, aes(factor(cyl), fill = factor(vs)))
k + geom_bar()
# Fill aesthetic can also be used with a continuous variable
m <- ggplot(movies, aes(x = rating))
library(base)
head(movies)
m + geom_histogram()
m + geom_histogram(aes(fill = ..count..))
# Some geoms don't use both aesthetics (i.e. geom_point or geom_line)
b <- ggplot(economics, aes(x = date, y = unemploy))
b + geom_line()
b + geom_line(colour = "green")
b + geom_point()
b + geom_point(colour = "red")
# For large datasets with overplotting the alpha
# aesthetic will make the points more transparent
df <- data.frame(x = rnorm(5000), y = rnorm(5000))
h <- ggplot(df, aes(x,y))
h + geom_point()
h + geom_point(alpha = 0.5)
h + geom_point(alpha = 1/10)

#If a geom uses both fill and colour, alpha will only modify the fill colour
c + geom_bar(fill = "dark grey", colour = "black")
c + geom_bar(fill = "dark grey", colour = "black", alpha = 1/3)

# Alpha can also be used to add shading
j <- b + geom_line()
j
yrng <- range(economics$unemploy)
j <- j + geom_rect(aes(NULL, NULL, xmin = start, xmax = end, fill = party),
                   ymin = yrng[1], ymax = yrng[2], data = presidential)
j
library(scales) # to access the alpha function
j + scale_fill_manual(values = alpha(c("blue", "red"), .3))


## aes_group_order Aesthetics: group, order
# By default, the group is set to the interaction of all discrete variables in the
# plot. This often partitions the data correctly, but when it does not, or when
# no discrete variable is used in the plot, you will need to explicitly define the
# grouping structure, by mapping group to a variable that has a different value
# for each group.
# For most applications you can simply specify the grouping with
# various aesthetics (colour, shape, fill, linetype) or with facets.
p <- ggplot(mtcars, aes(wt, mpg))
# A basic scatter plot
p + geom_point(size = 4)
# The colour aesthetic
p + geom_point(aes(colour = factor(cyl)), size = 4)
# Or you can use shape to distinguish the data
p + geom_point(aes(shape = factor(cyl)), size = 4)
# Using fill
a <- ggplot(mtcars, aes(factor(cyl)))
a + geom_bar()
a + geom_bar(aes(fill = factor(cyl)))
a + geom_bar(aes(fill = factor(vs)))
# Using linetypes
library(reshape2) # for melt
library(plyr) # for colwise
rescale01 <- function(x) (x - min(x)) / diff(range(x))
group aesthetic maps a different line for each subject
h + geom_line(aes(group = Subject))
# Different groups on different layers
h <- h + geom_line(aes(group = Subject))
# Using the group aesthetic with both geom_line() and geom_smooth()
# groups the data the same way for both layers
h + geom_smooth(aes(group = Subject), method = "lm", se = FALSE)
# Changing the group aesthetic for the smoother layer
# fits a single line of best fit across all boys
h + geom_smooth(aes(group = 1), size = 2, method = "lm", se = FALSE)
# Overriding the default grouping
# The plot has a discrete scale but you want to draw lines that connect across
# groups. This is the strategy used in interaction plots, profile plots, and parallel
# coordinate plots, among others. For example, we draw boxplots of height at
# each measurement occasion
boysbox <- ggplot(Oxboys, aes(Occasion, height))
boysbox + geom_boxplot()
# There is no need to specify the group aesthetic here; the default grouping
# works because occasion is a discrete variable. To overlay individual trajectories
# we again need to override the default grouping for that layer with aes(group = Subject)
boysbox <- boysbox + geom_boxplot()
boysbox + geom_line(aes(group = Subject), colour = "blue")
# Use the order aesthetic to change stacking order of bar charts
w <- ggplot(diamonds, aes(clarity, fill = cut))
w + geom_bar()
w + geom_bar(aes(order = desc(cut)))
# Can also be used to change plot order of scatter plots
d <- ggplot(diamonds, aes(carat, price, colour = cut))
d + geom_point()
d + geom_point(aes(order = sample(seq_along(carat))))


## Some cool examples
View(diamonds)
d <- ggplot(diamonds,
            aes(x=carat, y=price))
d + geom_point()
d + geom_point(aes(colour = carat))
d + geom_point(aes(colour = carat))
+ scale_colour_brewer()
ggplot(diamonds,aes(x=price)) +
  geom_histogram()

## COOOL COLORS!! 
qplot(carat, data=diamonds,
      +       geom="histogram", fill=clarity)

qplot(carat, data=diamonds,  geom="histogram", fill=color)
View(diamonds)

diamonds_1ct <- sqldf("select * from diamonds where carat >= 1 and carat <= 1.12")
qplot( y= price, data = diamonds_1ct, colour = color)
?seq_along()
