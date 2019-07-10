# Homework 5 - Automating Reviews in Medicine

rm( list = ls())

# Problem 1 - Loading the Data

trials <-  read.csv("clinical_trial.csv", , stringsAsFactors=FALSE)
summary(trials)
max(nchar(trials$abstract)) 
sum(nchar(trials$abstract)==0)
trials$title[which.min(nchar(trials$title))]

# Problem 2 - Preparing the Corpus

library(tm)
corpusTitle <- Corpus(VectorSource(trials$title))
corpusAbstract <- Corpus(VectorSource(trials$abstract))

corpusTitle <- tm_map(corpusTitle, content_transformer(tolower))
corpusAbstract <- tm_map(corpusAbstract, content_transformer(tolower))

corpusTitle <- tm_map(corpusTitle, removePunctuation)
corpusAbstract <- tm_map(corpusAbstract, removePunctuation)

corpusTitle <- tm_map(corpusTitle, removeWords, stopwords("english"))
corpusAbstract <- tm_map(corpusAbstract, removeWords, stopwords("english"))

corpusTitle <- tm_map(corpusTitle, stemDocument)
corpusAbstract <- tm_map(corpusAbstract, stemDocument)

Corpus = tm_map(corpusTitle, PlainTextDocument)
Corpus = tm_map(corpusAbstract, PlainTextDocument)

dtmTitle= DocumentTermMatrix(corpusTitle)
dtmAbstract= DocumentTermMatrix(corpusAbstract)

dtmTitle= removeSparseTerms(dtmTitle, 0.95)
dtmAbstract= removeSparseTerms(dtmAbstract, 0.95)

dtmTitle= as.data.frame(as.matrix(dtmTitle))
dtmAbstract = as.data.frame(as.matrix(dtmAbstract))

ncol(dtmTitle)
ncol(dtmAbstract)

which.max(colSums(dtmAbstract))
# Problem 3 - Building a model

colnames(dtmTitle) = paste0("T", colnames(dtmTitle))
colnames(dtmAbstract) = paste0("A", colnames(dtmAbstract))

dtm = cbind(dtmTitle, dtmAbstract)
dtm$trial <- trials$trial
ncol(dtm)

library(caTools)
set.seed(144)
spl = sample.split(dtm$trial, 0.7)
train= subset(dtm, spl == TRUE)
test=subset(dtm, spl == FALSE)
cmat_baseline <-table(train$trial) 
cmat_baseline 
accu_baseline <- max(cmat_baseline)/sum(cmat_baseline)
accu_baseline

library(rpart)
library(rpart.plot)
trialCART <-  rpart(trial~., data=train, method="class")
prp(trialCART)
predTrain <- predict(trialCART)[,2]
summary(predTrain)

cmat_CART1 <- table(train$trial, predTrain >= 0.5)
cmat_CART1
accu_CART <- (cmat_CART1[1,1] + cmat_CART1[2,2])/sum(cmat_CART1)
accu_CART
#sensitivity
441/(131+441)
#specificity
631/(631+99)

# Problem 4 - Evaluating the model on the testing set

predTest = predict(trialCART, newdata=test)[,2] 
summary(predTest)
cmat_CART<-table(test$trial, predTest>= 0.5)
cmat_CART
accu_CART <- (cmat_CART[1,1] + cmat_CART[2,2])/sum(cmat_CART)
accu_CART

library(ROCR)
ROCRpred <- prediction(predTest, test$trial)
as.numeric(performance(ROCRpred, "auc")@y.values)


