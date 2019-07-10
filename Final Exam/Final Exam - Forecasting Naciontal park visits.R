## Final Exam - Forecasting National Park Visits

rm(list = ls())

# Problem 1 - Number of National Parks in Jan 2016

visits <- read.csv("park_visits.csv", header = T)
str(visits)

## Let's first look at the visits in July 2016. Subset the observations to this year and month, name it visits2016jul. Work with this data subset for the next three problems.

visits2016 <- subset(visits, visits$Year == 2016)
visits2016jul <- subset(visits2016, visits$Month == 7)

## Which park type has the most number of parks?

table(visits$ParkType)

## Which specific park has the most number of visitors?

which.max(visits$logVisits)
visits$ParkName[11590]

# Problem 2 - Relationship Between Region and Visits

# Which region has the highest average log visits in July 2016?

str(visits2016jul$Region)
visits2016jul$Region[1]
table(visits2016jul$Region)
visits2016jul$Region <- as.numeric(visits2016jul$Region)
Alaska <- subset(visits2016jul, visits2016jul$Region == 1)
Intermountain <- subset(visits2016jul, visits2016jul$Region == 2)
Midwest <- subset(visits2016jul, visits2016jul$Region == 3)
National <- subset(visits2016jul, visits2016jul$Region == 4)
Northeast <- subset(visits2016jul, visits2016jul$Region == 5)
Pacific <- subset(visits2016jul, visits2016jul$Region == 6)
Southeast <- subset(visits2016jul, visits2016jul$Region == 7)

mean(Alaska$logVisits)
mean(Intermountain$logVisits)
mean(Midwest$logVisits)
mean(National$logVisits)
mean(Pacific$logVisits)
mean(Southeast$logVisits)

# Problem 3 - Relationship Between Cost and Visits

visits2016jul$cost <- as.numeric(visits2016jul$cost)
visits2016jul$logVisits <- as.numeric(visits2016jul$logVisits)
cor(visits2016jul$cost, visits2016jul$logVisits, use = "complete.obs")

# Problem 4 - Time Series Plot of Visits

ys <- subset(visits, visits$ParkName == "Yellowstone NP")

ys_ts=ts(ys$logVisits,start=c(2010,1),freq=12)

plot(ys_ts)

# Problem 5 - Missing Values

colSums(is.na(visits))
visits = visits[rowSums(is.na(visits)) == 0, ]

# Problem 6 - Predicting Visits

visits$Month = as.factor(visits$Month)
table(visits$Year)
train <- subset(visits, visits$Year > 2009 & visits$Year < 2015)
test <- subset(visits, visits$Year > 2014)
mod <- lm(train$logVisits ~train$laglogVisits)

# What's the out-of-sample R2 in the testing set for this simple model?

Predict <- predict(mod, newdata = test)
summary(predict)
SEE <- sum((Predict - test$logVisits)^2)
STT <- sum((mean(train$logVisits) - test$logVisits)^2)
R <- 1 - SEE/STT
R

# Problem 7 - Add New Variables

mod2 <- lm(logVisits ~ laglogVisits + laglogVisitsYear + Year + Month + Region + ParkType + cost, data = train)
summary(mod2)
Predict <- predict(mod2, newdata = test)
SEE <- sum((Predict - test$logVisits)^2)
STT <- sum((mean(train$logVisits) - test$logVisits)^2)
R <- 1 - SEE/STT
R

# Problem 9 - Regression Trees

# Looking at the plot of the tree, how many different predicted values are there?

library(caTools)
library(rpart)
library(rpart.plot)

CART <- rpart(logVisits ~ laglogVisits + laglogVisitsYear + Year + Month + Region + ParkType + cost, data = train, method= "class", cp = 0.05)
prp(spamCART)
