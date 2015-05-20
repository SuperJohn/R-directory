## Learning R 

## GEtting Data
data("diamonds", package = "ggplot2")
head(kidney)
data()
data(package = .packages(TRUE))
?data

library(learningr)
deer_file <- system.file(
  "extdata",
  "RedDeerEndocranialVolume.dlm",
  package = "learningr"
)
deer_data <- read.table(deer_file, header = TRUE, fill = TRUE)
head(deer_data)
str(deer_data, vec.len = 1)      #vec.len alters the amount of output
summary(deer_data)

crab_file <- system.file(
  "extdata",
  "crabtag.csv",
  package = "learningr"
)
(crab_id_block <- read.csv(
  crab_file,
  header = FALSE,
  skip = 3,
  nrow = 2
))
head(crab_id_block)
str(crab_file)

(crab_tag_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 8,
  nrow = 5
))

(crab_lifetime_notebook <- read.csv(
  crab_file,
  header = FALSE,
  skip = 15,
  nrow = 3
))

write.csv(
  crab_lifetime_notebook,
  "crab lifetime data.csv",
  row.names    = FALSE,
  fileEncoding = "utf8"
)

text_file <- system.file(
  "extdata",
  "Shakespeare's The Tempest, from Project Gutenberg pg2235.txt",
  package = "learningr"
)
the_tempest <- readLines(text_file)
the_tempest[1926:1927]

library(RJSONIO)
library(rjson)
jamaican_city_file <- system.file(
  "extdata",
  "Jamaican Cities.json",
  package = "learningr"
)
(jamaican_cities_RJSONIO <- RJSONIO::fromJSON(jamaican_city_file))

## Connecting to MySQL

driver <- dbDriver("SQLite")
db_file <- system.file(
  "extdata",
  "crabtag.sqlite",
  package = "learningr"
)
conn <- dbConnect(driver, db_file)

## USing ODBC FOR MYSQL
library(RODBC)
conn <- odbcConnect("RFI_analytics")
query1 <- sqlQuery(conn, "select * from rfi_meta_data.campaign limit 1000") 
str(query1)
head(query1)
View(query1)
odbcClose(conn)


# World Development Indicators Data
install.packages("WDI")
library(WDI)
#list all available datasets
wdi_datasets <- WDIsearch()
head(wdi_datasets)
#retrieve one of them
wdi_trade_in_services <- WDI(
  indicator = "BG.GSR.NFSV.GD.ZS"
)

head(wdi_trade_in_services)
str(wdi_trade_in_services)

## Get Stock Ticker Data
library(quantmod)
#If you are using a version before 0.5.0 then set this option
#or pass auto.assign = FALSE to getSymbols.
options(getSymbols.auto.assign = FALSE)
microsoft <- getSymbols("MSFT")
microsoft

## Get data from a web page
library(RCurl)
time_url <- "http://tycho.usno.navy.mil/cgi-bin/timer.pl"
time_page <- getURL(time_url)
cat(time_page)
# Parse the HTML from that webpage
library(XML)
time_doc <- htmlParse(time_page)
pre <- xpathSApply(time_doc, "//pre")[[1]]
values <- strsplit(xmlValue(pre), "\n")[[1]][-1]
strsplit(values, "\t+")

# Get Stock Ticker Data from the internet and chart
library(quantmod)
FUEL <- getSymbols("FUEL",src="yahoo") 
 
barChart(FUEL) 
summary(FUEL)
# Add multi-coloring and change background to white 
candleChart(AAPL,multi.col=TRUE,theme="white") 
oanada <- getSymbols("XPT/USD",src="oanda") 
barChart(oanda) 

require(TTR) 
library(TTR)
getSymbols("AAPL") 
chartSeries(AAPL) 
addMACD() 
addBBands() 


## Chapter 14. Exploring and Visualizing
library('learningr')
data(obama_vs_mccain, package = "learningr")
obama <- obama_vs_mccain$Obama
mean(obama)
head(obama_vs_mccain)
str(obama_vs_mccain)
table(cut(obama, seq.int(0, 100, 10))) ### Awesome! Bucketing to see distrobution
table(cut(obama, seq.int(0, 100, 10)))
var(obama)
sd(obama)
with(obama_vs_mccain, pmin(Obama, McCain))
min(obama)
cummin(obama)
View(cumsum(obama))
cumprod(obama)
quantile(obama)
quantile(obama, type = 3) 
?quantile()
quantile(obama, c(0.9, 0.95, 0.99))
IQR(obama)
with(obama_vs_mccain, cor(Obama, McCain))
?with()
with(obama_vs_mccain, cancor(Obama, McCain))
?cancor()
with(obama_vs_mccain, cov(Obama, McCain))


## The Three Plotting Systems
obama_vs_mccain <- obama_vs_mccain[!is.na(obama_vs_mccain$Turnout), ]
with(obama_vs_mccain, plot(Income, Turnout))
with(rfi,plot(spend,adv_impressions,  col = "black", pch = 1,log = adv_impressions"x"))
?with()
with(obama_vs_mccain, plot(Income, Turnout, col = "black", pch = 1, log = Income"x"))
with(obama_vs_mccain, plot(Income, Turnout, log = "x"))

par(mar = c(3, 3, 0.5, 0.5), oma = rep.int(0, 4), mgp = c(2, 1, 0))
regions <- levels(obama_vs_mccain$Region)
plot_numbers <- seq_along(regions)
layout(matrix(plot_numbers, ncol = 5, byrow = TRUE))
for(region in regions)
{
  regional_data <- subset(obama_vs_mccain, Region == region)
  with(regional_data,  plot(Income, Turnout))
}
?seq_along()

# Lattice
library(lattice)
xyplot(Turnout ~ Income, obama_vs_mccain)
xyplot(Turnout ~ Income, obama_vs_mccain, col = "violet", pch = 20)
xyplot(
  Turnout ~ Income,
  obama_vs_mccain,
  scales = list(log = TRUE)            #both axes log scaled (Fig. 14-8)
)

xyplot(
  Turnout ~ Income,
  obama_vs_mccain,
  scales = list(y = list(log = TRUE))  #y-axis log scaled (Fig. 14-9)
)

xyplot(
  Turnout ~ Income | Region,
  obama_vs_mccain,
  scales = list(
    log         = TRUE,
    relation    = "same",
    alternating = FALSE
  ),
  layout = c(5, 2)
)

(lat1 <- xyplot(
  Turnout ~ Income | Region,
  obama_vs_mccain
))

(lat2 <- update(lat1, col = "violet", pch = 20))

## GGPLOT2

library(ggplot2)
ggplot(obama_vs_mccain, aes(Income, Turnout)) + geom_point(color = "black", shape = 21)
?ggplot2()
?geom_point()

ggplot(obama_vs_mccain, aes(Income, Turnout)) +
  geom_point() +
  scale_x_log10(breaks = seq(2e4, 4e4, 1e4)) +
  scale_y_log10(breaks = seq(50, 75, 5))

(gg1<-ggplot(obama_vs_mccain, aes(Income, Turnout)) 
+ geom_point()
+ scale_x_log10(breaks = seq(2e4, 4e4, 1e4))
+ scale_y_log10(breaks = seq(50, 75, 5)) 
+ facet_wrap(~ Region, ncol = 3)
+ theme(axis.text.x = element_text(angle = 30, hjust = 1))
)
## This doesn't seem to work 
(gg2<- gg1 
 + opts(legend.background = theme(fill="red", colour=NA))
)

theme_get()  ## <- WOWWW!!!

df <- data.frame(gp = factor(rep(letters[1:3], each = 10)),
                 y = rnorm(30))

ggplot(df, aes(x = gp, y = y)) +
   geom_point() +
   geom_point(data = ds, aes(y = mean),
              colour = 'red', size = 3)

(gg1 <- ggplot(obama_vs_mccain, aes(Income, Turnout)) +
  geom_point()
)
(gg2 <- gg1 +
  facet_wrap(~ Region, ncol = 5) +
  theme_bw(axis.text.x = element_text(angle = 30, hjust = 1))
)

## Drawing Lines in Base

data(crab_tag, package = "learningr")
with(
  crab_tag$daylog,
  plot(Date, -Max.Depth, type = "l", ylim = c(-max(Max.Depth), 0))
)
?plot()
with(
  crab_tag$daylog,
  lines(Date, -Min.Depth, col = "blue")
)


### Distributions - generating data from Distrobutions

sample(20:8,5)
?sample()
sample(x=20:1,size=5,replace=TRUE)
sample(7, 10, replace = TRUE)
sample(colors(), 5) #a great way to pick the color scheme for your house
sample(.leap.seconds, 4)
weights <- c(1, 1, 2, 3, 5, 8, 13, 21, 8, 3, 1, 1)
sample(month.abb, 1, prob = weights)
runif(5)         #5 uniform random numbers between 0 and 1
?runif()
runif(5, 1,10)   #5 uniform random numbers between 1 and 10
rnorm(5)         #5 normal random numbers with mean 0 and std dev 1
rnorm(5, 3, 7)   #5 normal random numbers with mean 3 and std dev 7
RNGkind()

?"+"                   #opens the help page for addition
a_vector <- c(1, 3, 6, 10)
apropos("vector")

