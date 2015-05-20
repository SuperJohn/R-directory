train.data = read.csv("data/train.csv", na.strings=c("NA", ""))
str(train.data)
train.data$Survived = factor(train.data$Survived)
train.data$Pclass = factor(train.data$Pclass)