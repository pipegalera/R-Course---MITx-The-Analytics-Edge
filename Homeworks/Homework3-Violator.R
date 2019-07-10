rm(list = ls())

# 1.1 Load
parolees <- read.csv("parole.csv")

# 1.2 How many of the parolees in the dataset violated the terms of their parole?
nrow(parolees[parolees$violator == 1, ])

# 2.1 Which variables in this dataset are unordered factors with at least three levels? Select all that apply.
sapply(parolees, class)
# 2.3 How does the output of summary() change for a factor variable as compared to a numerical variable?

parolees$state <- as.factor(parolees$state)
parolees$crime <- as.factor(parolees$crime)
summary(parolees)
# 3.1 

set.seed(144)
library(caTools)
split = sample.split(parolees$violator, SplitRatio = 0.7)
train = subset(parolees, split == TRUE)
test = subset(parolees, split == FALSE)
202/675

# 4.1 Model 

Model1 <- glm(violator ~ .,data= train, family="binomial")
summary(Model1)

# 4.2 Interpret

exp(1.6119919)

# 4.3 

Logodds <- -4.2411574+0.3869904*1+0.8867192*1+-0.0001756*50+0+-0.1238867 *3+0.0802954*12+0+  0.6837143*1
exp(Logodds)
0.1825687/(1+0.1825687)

# 5.1 Predict

PredictTest <- predict(Model1, newdata = test, type="response")
summary(PredictTest)

# 5.2 In the following questions, evaluate the model's predictions on the test set using a threshold of 0.5.

table(test$violator, as.numeric(PredictTest >= 0.5))

#Sensivitity TP/TP+FN
12/(12+11)
#Specicity
167/(167+12)
#Accuracy
(167+12)/(167+35)

# 5.3 What is the accuracy of a simple model that predicts that every parolee is a non-violator?

table(test$violator)
179/(179+23)

# 5.5 Which of the following is the most accurate assessment of the value of the logistic regression model with a cutoff 0.5 to a parole board, based on the model's accuracy as compared to the simple baseline model?

# The model is likely of value to the board, and using a different logistic regression cutoff is likely to improve the model's value. correct

# 5.6 Using the ROCR package, what is the AUC value for the model?

library(ROCR)
ROCRpred <- prediction(PredictTest, test$violator)
as.numeric(performance(ROCRpred, "auc")@y.values)

# 5.7 Describe the meaning of AUC in this context.

# 6.1 


