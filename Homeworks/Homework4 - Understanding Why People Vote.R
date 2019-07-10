# Homework 4 - Understanding Why People Vote

rm(list = ls())

# 1. Exploration and Logistic Regression

gerber <- read.csv("gerber.csv")
str(gerber)
prop.table(table(gerber$voting))
cor(gerber$voting, gerber$civicduty)
cor(gerber$voting, gerber$hawthorne)
cor(gerber$voting, gerber$self)
cor(gerber$voting, gerber$neighbors)

Logit <- glm(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, family = binomial)
summary(Logit)
PredictLogit <- predict(Logit, data = gerber, type = "response")
table(gerber$voting, as.numeric(PredictLogit >= 0.3))
(134513+51966)/(134513+51966+100875+56730)
table(gerber$voting, as.numeric(PredictLogit >= 0.5))
235388/(108696+235388)

library(ROCR)
ROCRpred <- prediction(PredictLogit, gerber$voting)
as.numeric(performance(ROCRpred, "auc")@y.values)

# 2. Trees

library(caTools)
library(rpart)
library(rpart.plot)
CARTmodel <- rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
prp(CARTmodel)
CARTmodel2 <- rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel2)
CARTmodel3 <- rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, data=gerber, cp=0.0)
prp(CARTmodel3)

# 3. Interaction Terms

CARTmodel4 <- rpart(voting ~ control, data = gerber, cp = 0.0)
CARTmodel5 <- rpart(voting ~ control + sex, data = gerber, cp = 0.0)
prp(CARTmodel4, digit = 6)
abs(0.296638-0.34)
prp(CARTmodel5, digit = 6)
(0.290456-0.334176)
(0.302795-0.345818)
Logit2 <- glm(voting ~ sex + control, data = gerber, family = binomial)
summary(Logit2)
Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
predict(Logit2, newdata=Possibilities, type="response")
abs(0.2908065-0.290456)
Logit3 <- glm(voting ~ sex + control + sex:control, data=gerber, family="binomial")
summary(Logit3)
predict(Logit3, newdata=Possibilities, type="response")
abs(0.2904558-0.290456)
