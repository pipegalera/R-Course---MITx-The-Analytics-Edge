# Homework 3

songs <- read.csv("songs.csv")
## 1.4 The variable corresponding to the estimated time signature (timesignature) is discrete, meaning that it only takes integer values (0, 1, 2, 3, . . . ). What are the values of this variable that occur in our dataset? Select all that apply.

table(songs$timesignature)

## 1.5 Out of all of the songs in our dataset, the song with the highest tempo is one of the following songs. Which one is it?

which.max(songs$tempo) 
songs$songtitle[6206]

## 2.1 How many observations (songs) are in the training set?

SongsTrain <- subset(songs, year < 2010)
SongsTest <- subset(songs, year == 2010)

## 2.2 Now, use the glm function to build a logistic regression model to predict Top10 using all of the other variables as the independent variables. You should use SongsTrain to build the model.

SongsLog1 = glm(Top10 ~ ., data=SongsTrain, family=binomial)
nonvars = c("year", "songtitle", "artistname", "songID", "artistID")
SongsTrain = SongsTrain[ , !(names(SongsTrain) %in% nonvars) ]
SongsTest = SongsTest[ , !(names(SongsTest) %in% nonvars) ]

SongsLog1 = glm(Top10 ~ ., data=SongsTrain, family=binomial)
summary(SongsLog1)

# 2.3 Our model seems to indicate that these confidence variables are significant (rather than the variables timesignature, key and tempo themselves). What does the model suggest?

# The higher our confidence about time signature, key and tempo, the more likely the song is to be in the Top 10 correct

# 2.4 What does Model 1 suggest in terms of complexity?

# Mainstream listeners tend to prefer less complex songs

# 2.5 By inspecting the coefficient of the variable "loudness", what does Model 1 suggest?

summary(SongsLog1)

# 3.1 What is the correlation between the variables "loudness" and "energy" in the training set?

cor(songs$loudness, songs$energy)

# 3.2 Look at the summary of SongsLog2, and inspect the coefficient of the variable "energy". What do you observe?

SongsLog2 = glm(Top10 ~ . - loudness, data=SongsTrain, family=binomial)
summary(SongsLog2)

# 3.3 do we make the same observation about the popularity of heavy instrumentation as we did with Model 2?

SongsLog3 <- glm(Top10 ~ . - energy, data=SongsTrain, family=binomial)
summary(SongsLog3)

# 4.1 What is the accuracy of Model 3 on the test set, using a threshold of 0.45? (Compute the accuracy as a number between 0 and 1.)

testPredict <- predict(SongsLog3, type="response", newdata = SongsTest)
table(SongsTest$Top10, testPredict > 0.45)
(309 + 19)/(309 + 5 + 40 + 19)

# 4.2 What would the accuracy of the baseline model be on the test set? (Give your answer as a number between 0 and 1.)

table(SongsTest$Top10) 
314/(1 + 314 + 59)

# 4.3 How many songs does Model 3 correctly predict as Top 10 hits in 2010 (remember that all songs in 2010 went into our test set), using a threshold of 0.45?

table(SongsTest$Top10, testPredict > 0.45)

# 4.4 What is the sensitivity o specificity of Model 3 on the test set, using a threshold of 0.45?

19/(19+40)
309/(309+5)

# 4.5 
# 4.6