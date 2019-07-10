# Homework 4 - Predicting Earnings from Census

rm(list = ls())
census <- read.csv("census.csv")
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)
library(ROCR)
library(caret)
library(e1071)

# 1. A Logistic Regression Model

Logit <- glm(over50k ~., data = census, family = "binomial")
set.seed(2000)
spl <- sample.split(census, SplitRatio = 0.6)
train <- subset(census, spl == T)
test <- subset(census, spl == F)
Logit2 <- glm(over50k ~., data = train, family = "binomial")
summary(Logit2)
Predict <- predict(Logit2, newdata = test, type = "response")
table(test$over50k, Predict > 0.5)
(10421+2123)/(10421+2123+777+1439)
table(test$over50k)
(11198)/(11198+3562)
ROCRpred <- prediction(Predict, test$over50k)
auc <- as.numeric(performance(ROCRpred, "auc")@y.values)
auc
# 2. A CART Model

CART <- rpart(over50k ~., data = train, method = "class")
prp(CART)
Predict2 <- predict(CART, newdata = test, type="class")
Tab <- table(test$over50k, Predict2)
Auc <- (Tab[1,1]+Tab[2,2])/sum(Tab)
Auc
ROCRpred2 <- prediction(Predict2, test$over50k)
auc2 <- as.numeric(performance(ROCRpred2, "auc")@y.values)
auc2

# 3. A Random Forest Model

set.seed(1)
trainSmall = train[sample(nrow(train), 2000), ]
set.seed(1)
RandomForest <- randomForest(over50k ~., data = trainSmall)
Predict3 <- predict(RandomForest, newdata = test)
Tab2 <- table(test$over50k, Predict3)
Auc2 <- (Tab[1,1]+Tab[2,2])/sum(Tab)
Auc2

vu = varUsed(RandomForest, count=TRUE)
vusorted = sort(vu, decreasing = FALSE, index.return = TRUE)
dotchart(vusorted$x, names(RandomForest$forest$xlevels[vusorted$ix]))
varImpPlot(RandomForest)

# 4. Selecting cp by Cross-Validation

set.seed(2)
cartGrid = expand.grid( .cp = seq(0.002,0.1,0.002))
numFolds <- trainControl(method = "cv", number = 10 )
CrossValidation <- train(over50k ~., data = train, trControl = numFolds, tuneGrid = cartGrid, method = "rpart")
CrossValidation
set.seed(2)
CART2 <- rpart(over50k ~., data = train, method = "class", cp = 0.002)
Predict4 <- predict(CART2, newdata = test, type = "class")
table(test$over50k, Predict4)
Tab3 <- table(test$over50k, Predict4)
Auc3 <- (Tab3[1,1]+Tab3[2,2])/sum(Tab3)
Auc3
prp(CART2)
