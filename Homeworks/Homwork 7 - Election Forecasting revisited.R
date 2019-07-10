# Homework 7 - Election Ferecasting Revisited 

rm(list = ls())
library(tm)
install.packages("SnowballC")
library(SnowballC)

# Problem 1 - Preparing the Data

tweets <- read.csv("tweets.csv", stringsAsFactors = F)
corpus <- Corpus(VectorSource(tweets$Tweet))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- tm_map(corpus, removePunctuation)
corpus<- tm_map(corpus, removeWords, stopwords("english"))
frequencies <- DocumentTermMatrix(corpus)
allTweets <- as.data.frame(as.matrix(frequencies))
ncol(allTweets)

# Problem 2 - Building a Word Cloud

install.packages("wordcloud")
library(wordcloud)
?wordcloud
head(colSums(allTweets))
head(rowSums(allTweets))
head(sum(allTweets))
wordcloud(colnames(allTweets), colSums(allTweets))
wordcloud(colnames(allTweets), colSums(allTweets), scale=c(2, 0.25))


corpus <- Corpus(VectorSource(tweets$Tweet))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, c("apple", stopwords("english")))
frequencies <- DocumentTermMatrix(corpus)
allTweets <- as.data.frame(as.matrix(frequencies))
wordcloud(colnames(allTweets), colSums(allTweets), scale=c(2, 0.25))

# Problem 4 - Selecting a Color Palette

install.packages("RColorBrewer")
library("RColorBrewer")
display.brewer.all()
brewer.pal(9, "Blues")[c(-1, -2, -3, -4)]  
