# Homework4 - Letter Recognition

rm(list = ls())
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)

# 1.  Predicting B or not B

letters <- read.csv("letters_ABPR.csv")
letters$isB <-  as.factor(letters$letter == "B")
set.seed(1000)
spl <- sample.split(letters$isB, SplitRatio = 0.5)
train <- subset(letters, spl == T)
test <- subset(letters, spl == F)
table(train$isB)
1175/(1175+383)
CARTb = rpart(isB ~ . - letter, data=train, method="class")
prp(CARTb)
Predictb <- predict(CARTb, newdata = test, type="class")
table(test$isB, Predictb)
(1118+340)/(1118+340+57+43)
set.seed(1000)
RandomForest <- randomForest(isB ~. -letter, data = train, method= "class")
Predictb2 <- predict(RandomForest, newdata = test)
table(test$isB, Predictb2)
(1165+374)/(1165+374+10+9)

# 2.  Predicting the letters A, B, P, R

letters$letter = as.factor( letters$letter )
set.seed(2000)
spln <- sample.split(letters$letter, SplitRatio = 0.5)
trainn <- subset(letters, spln == T)
testn <- subset(letters, spln == F)
RandomForest2 <- randomForest(letter ~., data = trainn)
Predictb3 <- predict(RandomForest2, newdata = testn, type="class")
table(testn$letter, Predictb3)

CARTn <- rpart(letter ~. - isB, data =  trainn, method = "class") 
Predictn <- predict(CARTn, newdata = testn, type = "class")
tabCART <- table(testn$letter, Predictn)
tabCART
acuCART <- (tabCART[1,1]+tabCART[2,2]+tabCART[3,3]+tabCART[4,4])/sum(tabCART)
acuCART
RandomForestn <- randomForest(letter ~. -isB, data = trainn, method= "class")
Predictn2 <- predict(RandomForestn, newdata = testn, type = "class")
tabForest <- table(testn$letter, Predictn2)
acuForest <- (tabForest[1,1]+tabForest[2,2]+tabForest[3,3]+tabForest[4,4])/sum(tabForest)
acuForest
