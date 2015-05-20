install.packages("devtools") # if not installed
library(devtools)
install_github("tesseradata/datadr")
install_github("tesseradata/trelliscope")


# install package with housing data
devtools::install_github("hafen/housingData")
library(housingData)
library(datadr); library(trelliscope)

# look at housing data
head(housing)

# divide by county and state
byCounty <- divide(housing, 
                   by = c("county", "state"), update = TRUE)

# look at summaries
summary(byCounty)

# look at overall distribution of median list price
priceQ <- drQuantile(byCounty, 
                     var = "medListPriceSqft")
xyplot(q ~ fval, data = priceQ, 
       scales = list(y = list(log = 10)))

# slope of fitted line of list price for each county
lmCoef <- function(x)
  coef(lm(medListPriceSqft ~ time, data = x))[2]
# apply lmCoef to each subset
byCountySlope <- addTransform(byCounty, lmCoef)

# look at a subset of transformed data
byCountySlope[[1]]

# recombine all slopes into a single data frame
countySlopes <- recombine(byCountySlope, combRbind)
plot(sort(countySlopes$val))

# make a time series trelliscope display
vdbConn("housingjunk/vdb", autoYes = TRUE)

# make and test panel function
timePanel <- function(x)
  xyplot(medListPriceSqft + medSoldPriceSqft ~ time,
         data = x, auto.key = TRUE, ylab = "$ / Sq. Ft.")
timePanel(byCounty[[1]][[2]])

# make and test cognostics function
priceCog <- function(x) { list(
  slope = cog(lmCoef(x), desc = "list price slope"),
  meanList = cogMean(x$medListPriceSqft),
  listRange = cogRange(x$medListPriceSqft),
  nObs = cog(sum(!is.na(x$medListPriceSqft)), 
             desc = "number of non-NA list prices")
)}
priceCog(byCounty[[1]][[2]])

# add display panel and cog function to vdb
makeDisplay(byCounty,
            name = "list_sold_vs_time",
            desc = "List and sold price over time",
            panelFn = timePanel, cogFn = priceCog,
            width = 400, height = 400,
            lims = list(x = "same"))

# view the display
view()
