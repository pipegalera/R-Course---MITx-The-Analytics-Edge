# Homework 5 - Separating Spam from Ham (Part 1)


rm( list = ls())

library(rpart)
library(rpart.plot)
library(tm)
library(SnowballC)
library(caTools)
library(randomForest)
library(ROCR)

#Problem 1 - Loading the Dataset

emails <- read.csv("emails.csv", stringsAsFactors=FALSE, encoding="latin1")
str(emails)
sum(emails$spam)
head(emails)
max(nchar(emails$text))
which.min(nchar(emails$text))

# Problem 2 - Preparing the Corpus

corpus <- Corpus(VectorSource(emails$text))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)
dtm <- DocumentTermMatrix(corpus)
dtm

spdtm <- removeSparseTerms(dtm, 1-0.05)
spdtm 
emailsSparse <- as.data.frame(as.matrix(spdtm))
colnames(emailsSparse) <- make.names(colnames(emailsSparse))
which.max(colSums(emailsSparse))
emailsSparse$spam <- emails$spam
ham <- subset(emailsSparse, spam==0)
sum(colSums(ham) >= 5000)
spam <- subset(emailsSparse, spam==1)
sum(colSums(spam) > 1000) - 1

# Problem 3 - Building machine learning models

emailsSparse$spam = as.factor(emailsSparse$spam)
set.seed(123)
split <- sample.split(emailsSparse$spam, SplitRatio=.7)
train <- subset(emailsSparse, split==T)
test <- subset(emailsSparse, split==F)

spamLog <- glm(spam ~., data=train, family="binomial")
spamCART <- rpart(spam ~., data=train, method="class")
spamRF <- randomForest(spam ~., data=train)
predTrainLog <- predict(spamLog, type="response")
predTrainCART <- predict(spamCART)[,2]
predTrainRF <- predict(spamRF, type="prob")[,2] 

sum(predTrainLog < 0.00001)
sum(predTrainLog > 0.99999)
sum(predTrainLog >= 0.00001 & predTrainLog <= 0.99999)

summary(spamLog)
prp(spamCART)
table(train$spam, predict(spamLog) >= 0.5)
(3052 + 954)/(3052 + 954 + 4)
predictionTrainLog <-  prediction(predTrainLog, train$spam)
as.numeric(performance(predictionTrainLog, "auc")@y.values) 
table(train$spam, predTrainCART > 0.5)
(2885 + 894)/(2885 + 167 + 64 + 894)
predictionTrainCAR <- prediction(predTrainCART, train$spam)
as.numeric(performance(predictionTrainCART, "auc")@y.values) 
table(train$spam, predTrainRF > 0.5)
(3016 + 912)/(3016 + 912 + 36 + 46)
predictionTrainRF <- prediction(predTrainRF, train$spam)
as.numeric(performance(predictionTrainRF, "auc")@y.values) 

# Problem 4 - Evaluating on the Test Set

predTestLog = predict(spamLog, newdata=test, type="response")
predTestCART = predict(spamCART, newdata=test)[,2]
predTestRF = predict(spamRF, newdata=test, type="prob")[,2] 

table(test$spam, predTestLog >= .5)
(1257+376)/(1257+376+51+34)
predictionTestLog = prediction(predTestLog, test$spam)
as.numeric(performance(predictionTestLog, "auc")@y.values)
table(test$spam, predTestCART >= .5)
(1228+386)/(1228+386+80+24)
predictionTestCART = prediction(predTestCART, test$spam)
as.numeric(performance(predictionTestCART, "auc")@y.values) 
table(test$spam, predTestRF >= 0.5)
(1290+388)/(1290+388+22+18)
predictionTestRF = prediction(predTestRF, test$spam)
as.numeric(performance(predictionTestRF, "auc")@y.values) 
