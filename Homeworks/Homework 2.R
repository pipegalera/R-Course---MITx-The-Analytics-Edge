#Homework 2 

#Climate change

rm(list = ls())

climate_change <- read.csv("climate_change.csv")
names(climate_change)
training_set <- subset(climate_change, climate_change$Year <= 2006)
test_set <- subset(climate_change, climate_change$Year > 2006)
Tempmodel <- lm(Temp ~ MEI+CO2+CH4+N2O+CFC.11+CFC.12+TSI+Aerosols, data=training_set)

summary(Tempmodel)$r.squared
summary(Tempmodel)

cor(training_set$N2O,training_set)
cor(training_set$CFC.11,training_set)
Tempmodel2 <- lm(Temp ~ N2O+MEI+TSI+Aerosols, data=training_set)
summary(Tempmodel2)

step(Tempmodel)
AICmodel <- lm(formula = Temp ~ MEI + CO2 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data = training_set)
summary(AICmodel)
Predictmodel <- predict(AICmodel, newdata = test_set)
summary(Predictmodel)
SEE <- sum((Predictmodel - test_set$Temp)^2)
STT <- sum((mean(training_set$Temp) - test_set$Temp)^2)
R <- 1 - SEE/STT
R

####Reading Test Scores####

rm(list = ls())

pisaTrain <- read.csv("pisa2009train.csv")
pisaTest <- read.csv("pisa2009test.csv")
nrow(pisaTrain)

#what is the average reading test score of males?

tapply(pisaTrain$readingScore, pisaTrain$male, mean, na.rm=T)

#Which variables are missing data in at least one observation in the training set?

summary(pisaTrain)       

#Removing missing values
pisaTrain = na.omit(pisaTrain)
pisaTest = na.omit(pisaTest)

#Check unordered and ordered levels

levels(pisaTrain$grade)
levels(pisaTrain$male)
levels(pisaTrain$raceeth)

#Relevel not to the first but to the most common level

pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White")
pisaTest$raceeth = relevel(pisaTest$raceeth, "White")

#Linear Regression

lmScore <- lm(readingScore ~ ., data = pisaTrain)
summary(lmScore)
SEE <- sum(lmScore$residuals^2)
RMSE <- sqrt(SEE/ nrow(pisaTrain))
RMSE
29.542707*2

#Predict

predTest <- predict(lmScore,newdata = pisaTest)
summary(predTest)
range(predTest)
637.6914 - 353.2231


#SEE and RMSE in the Test set
SEE <- sum((predTest - pisaTest$readingScore)^2)
RMSE <- sqrt(SEE/nrow(pisaTest))
SEE
RMSE

#Baseline prediction and test-set SSE

Baseline <- mean(pisaTrain$readingScore)
Baseline
SST <- sum((pisaTest$readingScore - mean(pisaTrain$readingScore))^2)
SST
summary(lmScore)

#What is the test-set R-squared value of lmScore?

1 - SEE/SST

####Detecting Flu Epidemics via Search Engine Query Data####

rm(list = ls())
FluTrain <- read.csv("FluTrain.csv")
str(FluTrain)
subset(FluTrain, ILI == max(ILI))
subset(FluTrain, Queries == max(Queries))
hist(FluTrain$ILI)
plot(FluTrain$Queries,log(FluTrain$ILI))
FluTrend1 <- lm(log(ILI) ~ Queries, data = FluTrain)
summary(FluTrend1)
cor(log(FluTrain$ILI), FluTrain$Queries)^2
log(1/cor(log(FluTrain$ILI), FluTrain$Queries))
exp(-0.5*cor(log(FluTrain$ILI), FluTrain$Queries))
FluTest <- read.csv("FluTest.csv")
PredTest1 <- exp(predict(FluTrend1, newdata=FluTest))
which(FluTest$Week=="2012-03-11 - 2012-03-17")
PredTest1[11]
(2.293422-2.187383)/2.293422
SSE <- sum((PredTest1 - FluTest$ILI)^2)
RMSE <- sqrt(SSE / nrow(FluTest))
SSE
RMSE

install.packages("zoo")
library(zoo)
ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE)
FluTrain$ILILag2 = coredata(ILILag2)
sum(is.na(FluTrain$ILILag2))
plot(log(FluTrain$ILILag2),log(FluTrain$ILI))
FluTrend2<-lm(log(ILI) ~ Queries + log(ILILag2), data = FluTrain)
summary(FluTrend2)

ILILag2 <- lag(zoo(FluTest$ILI), -2, na.pad=TRUE)
FluTest$ILILag2 <- coredata(ILILag2)
summary(FluTest$ILILag2)

nrow(FluTrain)
PredTest2 <- exp(predict(FluTrend2, newdata=FluTest))
SSE <- sum((PredTest2 - FluTest$ILI)^2)
RMSE <- sqrt(SSE / nrow(FluTest))
RMSE
