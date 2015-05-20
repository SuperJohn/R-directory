install.packages("devtools") # if not installed
devtools::install_github("tesseradata/datadr")
devtools::install_github("tesseradata/trelliscope")
devtools::install_github("hafen/housingData")

library(devtools)
install_github("tesseradata/datadr")
install_github("tesseradata/trelliscope")

# load packages
library(housingData)
library(datadr)
library(trelliscope)

# look at housing data
str(housing)
head(housing,20)

# connect to a "visualization database"
conn <- vdbConn("vdb", name = "tesseraTutorial")
