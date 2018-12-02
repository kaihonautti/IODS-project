#---
#title: "Chapter 5 data wrangling"
#author: "Antti Kaihovaara"
#date: "December 1, 2018"
#description: "Chapter 5 data"
#Data : "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt"
#---


#Reading the data and observing structure and dimensions. Summarizing.

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)
str(human)
head(human)
summary(human)
glimpse(human)
names(human)

#This week's data is Human Development Index (HDI) that is collected and upheld by UNDP. 
#The HDI combines several indicators from most countries in the world to construct and 
#index that measures human development and welfare.It is made of three different indices,
#which are Life Expectancy Index, Education Index, and GNI Index.
#The HDI functions as an alternative for GDP as it contains information on 
#e.g. maternal mortality ratio, life expectancy and theproportion of females in the 
#labour force. Alltogether, the data contains 19 variables and 195 observations.
#Read more from here: http://hdr.undp.org/en/content/human-development-index-hdi


#First, we mutate the data by changing GNI variable to numeric.

library(stringr)
library(dplyr)
library(MASS)


str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
human$GNI <- as.numeric(human$GNI)
human$GNI

#Second, we exclude the unneeded variables and keep only the following:

keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- dplyr::select(human, one_of(keep))

#Third, we remove all the rows with missing values.

complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human <- filter(human, complete.cases(human))

#Fourth, we remove the observations that relate regions instead of countries. 

tail(human, 10)
last <- nrow(human) - 7
human <- human[1:last, ]

#Fifth, we define the row names of the data by the contry names and remove the country 
#name column. 

rownames(human) <- human$Country
human <- dplyr::select(human, -Country)
str(human)
dim(human)
write.csv(human, file = "create_human.csv", row.names=TRUE)
