Sys.setlocale("LC_ALL", "C")
mvt <- read.csv("mvtWeek1.csv")

#1.1 How many rows of data (observations) are in this dataset?
nrow(mvt)

#1.2 How many variables are in this dataset?
names(mvt)

#1.3 Using the "max" function, what is the maximum value of the variable "ID"?
max(mvt$ID)

#1.4 What is the minimum value of the variable "Beat"?
min(mvt$Beat)

#1.5 How many observations have value TRUE in the Arrest variable (this is the number of crimes for which an arrest was made)?
table(as.numeric(mvt$Arrest))
sum(mvt$Arrest == TRUE)

#1.6 How many observations have a LocationDescription value of ALLEY?
nrow(mvt[mvt$LocationDescription=="ALLEY",])
sum(mvt$LocationDescription == "ALLEY")

#2.1 In what format are the entries in the variable Date?
mvt$Date[1]

#2.2 What is the month and year of the median date in our dataset?
DateConvert <- as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
summary(DateConvert)

#2.3 In which month did the fewest motor vehicle thefts occur?
mvt$Month <- months(DateConvert)
mvt$Weekday <- weekdays(DateConvert)
mvt$Date <- DateConvert

which.min(table(mvt$Month))

#2.4 On which weekday did the most motor vehicle thefts occur?
which.max(table(mvt$Weekday))

#2.5 Which month has the largest number of motor vehicle thefts for which an arrest was made?
arrest <- subset(mvt, mvt$Arrest == TRUE)
which.max(table(arrest$Month))

#3.1 In general, does it look like crime increases or decreases from 2002 - 2012?
#In general, does it look like crime increases or decreases from 2005 - 2008?
#In general, does it look like crime increases or decreases from 2009 - 2011?
hist(mvt$Date, breaks=15)

#3.2 Does it look like there were more crimes for which arrests were made in the first half of the time period or the second half of the time period? 
boxplot(mvt$Date~mvt$Arrest)

#3.3 For what proportion of motor vehicle thefts in 2001 was an arrest made?
mvt$Year <- as.numeric(format(mvt$Date, "%Y"))
mvt2001 <- subset(mvt, mvt$Year == 2001)
sum(mvt2001$Arrest/nrow(mvt2001))

#3.4 For what proportion of motor vehicle thefts in 2001 was an arrest made?
mvt2007 <- subset(mvt, mvt$Year == 2007)
sum(mvt2007$Arrest) / nrow(mvt2007)

#3.5 For what proportion of motor vehicle thefts in 2012 was an arrest made?
mvt2012 <- subset(mvt, mvt$Year == 2012)
sum(mvt2012$Arrest/ nrow(mvt2012))

#4.1 Which locations are the top five locations for motor vehicle thefts, excluding the "Other" category? You should select 5 of the following options.

sort(table(mvt$LocationDescription))

#4.2 How many observations are in Top5?

Top5<- subset(mvt, LocationDescription=="STREET" | LocationDescription=="PARKING LOT/GARAGE(NON.RESID.)" | LocationDescription=="ALLEY" | LocationDescription=="GAS STATION" | LocationDescription=="DRIVEWAY - RESIDENTIAL")
str(Top5)

#4.3 One of the locations has a much higher arrest rate than the other locations. Which is it?

table(Top5$LocationDescription, Top5$Arrest)
prop.table(table(Top5$LocationDescription, Top5$Arrest),1)

#4.4

max(table(Top5$Weekday[Top5$LocationDescription=="GAS STATION"]))
table(Top5$Weekday[Top5$LocationDescription=="GAS STATION"])

#4.5

min(table(Top5$Weekday[Top5$LocationDescription=="DRIVEWAY - RESIDENTIAL"]))
table(Top5$Weekday[Top5$LocationDescription=="DRIVEWAY - RESIDENTIAL"])

          