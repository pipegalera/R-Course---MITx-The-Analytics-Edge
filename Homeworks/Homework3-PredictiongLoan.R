
# Homework 3 - Predicting Lon Repayment

rm(list = ls())
#1.1 What proportion of the loans in the dataset were not paid in full? Please input a number between 0 and 1.

loans <- read.csv("loans.csv")
summary(loans)
prop.table(table(loans$not.fully.paid))

#1.2 Missing data

missing <- subset(loans, is.na(log.annual.inc) | is.na(days.with.cr.line) | is.na(revol.util) | is.na(inq.last.6mths) | is.na(delinq.2yrs) | is.na(pub.rec))

# 1.3 Fill missing data

read.csv("loans_imputed.csv")
install.packages("mice")
library(mice)
set.seed(144)
vars.for.imputation = setdiff(names(loans), "not.fully.paid")
imputed = complete(mice(loans[vars.for.imputation]))
loans[vars.for.imputation] = imputed

# 2.1 Model1

set.seed(144)
library(caTools)
split <- sample.split(loans$not.fully.paid, SplitRatio = 0.7)
train <- subset(loans, split == TRUE)
test <- subset(loans, split == FALSE)

Model1 <- glm(not.fully.paid ~., data = train, family = binomial)
summary(Model1)

# 2.2

-9.406e-03*-10
exp(0.09406)

# 2.3 Predict risk

predicted.risk <- predict(Model1, type="response", newdata=test)
table(test$not.fully.paid, as.numeric(predicted.risk >= 0.5))

# Acuracy
(2400+3)/(2400+13+457+3)
# Accuracy of the baseline
table(test$not.fully.paid)

# 2.4 Use the ROCR package to compute the test set AUC.

library(ROCR)
ROCRpred <- prediction(predicted.risk, test$not.fully.paid)
as.numeric(performance(ROCRpred, "auc")@y.values)

# 3.1 uild a bivariate logistic regression model (aka a logistic regression model with a single independent variable) that predicts the dependent variable not.fully.paid using only the variable int.rate.

bivariate <- glm(not.fully.paid~ int.rate, data=train , family = binomial)
summary(bivariate)

# 3.2 Make test set predictions for the bivariate model. What is the highest predicted probability of a loan not being paid in full on the testing set?

bivPredict <- predict(bivariate, type = "response", newdata = test)
max(bivPredict)

# 3.3 What is the test set AUC of the bivariate model?

library(ROCR)
ROCRpred = prediction(bivPredict, test$not.fully.paid)
as.numeric(performance(ROCRpred, "auc")@y.values)

# 4.1 - Computing the Profitability of an Investment
10*exp(0.06*3)

# 5.1  A Simple Investment Strategy

test$profit = exp(test$int.rate*3) - 1
test$profit[test$not.fully.paid == 1] = -1
summary(test$profit)
0.8895*10

# 6.1 - An Investment Strategy Based on Risk

str(test)
highInterest<-subset( test , int.rate>=0.15)
str(highInterest)
mean(highInterest$profit)

# 6.2 - An Investment Strategy Based on Risk

cutoff = sort(highInterest$bivPredict, decreasing=FALSE)[100]
cutoff
selectedLoans <- subset(highInterest, bivPredict <= cutoff)
sum(selectedLoans$profit)
table(selectedLoans$not.fully.paid)

