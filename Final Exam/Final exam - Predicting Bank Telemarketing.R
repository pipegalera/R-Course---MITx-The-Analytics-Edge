# Final Exam - PREDICTING BANK TELEMARKETING SUCCESS

rm(list = ls())

# Problem 1 - Loading the Data

bank <- read.csv("bank.csv")
str(bank)
mean(bank$age)

# Problem 2 - Call Durations by Job

# Build a boxplot that shows the call duration distributions over different jobs. Which three jobs have the longest average call durations? (if it's hard to see from the boxplot, use tapply function.)

table(bank$job)
tapply(bank$duration, bank$job, mean)

# Problem 3 - Multicolinearity


cor(bank[,unlist(lapply(bank, is.numeric))])

# Problem 4 - Splitting into a Training and Testing Set

set.seed(201)
library(caTools)
spl = sample.split(bank$y, 0.7)

# Problem 5 - Training a Logistic Regression Model
train <- subset(bank, spl == T)
test <-  subset(bank, spl == F)
glm <- glm(y ~ age + job + marital + education + default + housing + loan + contact + month + day_of_week + campaign + pdays + previous + poutcome + emp.var.rate + cons.price.idx + cons.conf.idx, data = train, family="binomial")
summary(glm)

# Problem 6 - Interpreting Model Coefficients

# When the month is March, the odds of subscribing to the product are 261.8% higher than an otherwise identical contact.
exp(1.286e+00) - 1

# Problem 7 - Obtaining Test Set Predictions

PredictTest <- predict(glm, newdata = test)
summary(PredictTest)
table(test$y, as.numeric(PredictTest >= 0.5))
which.max(table(train$y))

# Problem 8 - Computing Test-Set AUC

library(ROCR)
ROCRpred <- prediction(PredictTest, test$y)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Problem 9 - Interpreting AUC

# The proportion of the time the model can differentiate between a randomly selected month during which the federal funds were raised and a randomly selected month during which the federal funds were not raised 

# Problem 10 - ROC Curves

# Which logistic regression threshold is associated with the upper-right corner of the ROC plot (true positive rate 1 and false positive rate 1)?

# 0

# Problem 11 - ROC Curves

#Plot the colorized ROC curve for the logistic regression model's performance on the test set. At roughly which logistic regression cutoff does the model achieve a true positive rate of 60% and a false positive rate of 25%?

logicPerf <- performance(ROCRpred,"tpr","fpr")
plot(logicPerf, colorize=TRUE)
abline(v=0.25,h=0.6)
