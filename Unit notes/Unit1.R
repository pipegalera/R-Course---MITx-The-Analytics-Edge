#Borrar Global Environment
rm(list = ls())

#WINE: Videos and Quizes
wine <- read.csv("wine.csv")
str(wine)
summary(wine)

model1 <- lm(Price ~ AGST, data = wine)
summary(model1)
model1$residuals
SEE <- sum(model1$residuals^2)
SEE

model2 <- lm(Price ~ AGST + HarvestRain, data = wine)
summary(model2)
SEE2 <- sum(model2$residuals^2)

model3 <- lm(Price ~ AGST + HarvestRain + Age + FrancePop, data = wine)
summary(model3)
SEE3 <- sum(model3$residuals^2)
SEE3

model4 <- lm(Price ~ HarvestRain + WinterRain, data = wine)
summary(model4)

cor(wine$WinterRain, wine$Price)
cor(wine$Age, wine$FrancePop)
cor(wine)

wineTest = read.csv("wine_test.csv")
str(wineTest)
predictTest <- predict(model4, newdata = wineTest)
predictTest
SEETest <- sum((wineTest$Price - predictTest)^2)
SSTTest <- sum((wineTest$Price - mean(wine$Price))^2)
Rsquared <- 1 - SEETest/SSTTest
Rsquared

#MONEYBALL: Videos and Quizes

baseball <- read.csv("baseball.csv")
str(baseball)
moneyball <- subset(baseball, Year < 2002)
moneyball$RD <- moneyball$RS - moneyball$RA
plot(moneyball$RD, moneyball$W)
WinsReg <- lm(W ~ RD, data =moneyball)
summary(WinsReg)

lm(W ~ RD, data = moneyball)
80.8814 + 0.1058*(713-614)

RunsReg <- lm(RS ~ OBP + SLG + BA, data=moneyball)
summary(RunsReg)
RunsRegNoMulty <- lm(RS ~ OBP + SLG, data=moneyball)
summary(RunsRegNoMulty)
-804.63 + 2737.77*0.311 + 1584.91*0.405
-837.38 + 2913.60*0.297 + 1514.29*0.370

teamRank <- c(1,2,3,3,4,4,4,4,5,5)
wins2012 <- c(94,88,95,88,93,94,98,97,93,94)
wins2013 <- c(97,97,92,93,92,96,94,96,92,90)
cor(teamRank, wins2012)
cor(teamRank, wins2013)

#NBA: Videos and Quizes
rm(list = ls())
NBA <- read.csv("NBA_train.csv")
str(NBA)
table(NBA$W, NBA$Playoffs)
NBA$PTSdiff <- NBA$PTS - NBA$oppPTS
plot(NBA$PTSdiff, NBA$W)
WinsReg <- lm(W ~ PTSdiff, data=NBA)
summary(WinsReg)
PointsReg <- lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + TOV + STL + BLK, data=NBA)
summary(PointsReg)
SEE <- sum(PointsReg$residuals^2)
RMSE <- sqrt(SEE/nrow(NBA))
RMSE
mean(NBA$PTS)
summary(PointsReg)
PointsReg2 <- lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + STL + BLK, data=NBA)
summary(PointsReg2)
PointsReg3 <- lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL + BLK, data=NBA)
summary(PointsReg3)
PointsReg4 <- lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL, data=NBA)
summary(PointsReg4)
SEE_4 <- sum(PointsReg4$residuals^2)
RMSE <- sqrt(SEE_4/nrow(NBA))
NBA_Test <- read.csv("NBA_test.csv")
PointsPredictions <- predict(PointsReg4, newdata = NBA_Test)
SEE <- sum((PointsPredictions-NBA_Test$PTS)^2)
SST <- sum(mean(NBA$PTS) - NBA_Test$PTS)^2
R <- 1 - SEE/SST
R
RMSE <- sqrt(SEE/nrow(NBA_Test))
RMSE
