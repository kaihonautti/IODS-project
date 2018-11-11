---
  title: "Chapter 2 data wrangling"
author: "Antti Kaihovaara"
date: "November 11, 2018"
description: "Data wrangling for the Open data science course. 
Data source: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt "
---
  
  exercise2 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
library(ggplot2)
dim(exercise2)
str(exercise2)
View(exercise2)

#Dim and str - commands enable us to look at the dimensions and the structure of the data. 
#View -command shows all the observations as a table.It seems that the data has 183 observations and 63 variables. 
#Most of the variables are Likert-scale questions.

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#Above we created vectors of the required questions. Next we select the columns of these vectors and create single 
#columns by averaging the values. 
  
deep_columns <- select(exercise2, one_of(deep_questions))
exercise2$deep <- rowMeans(deep_columns)
surface_columns <- select(exercise2, one_of(surface_questions))
exercise2$surf <- rowMeans(surface_columns)
strategic_columns <- select(exercise2, one_of(strategic_questions))
exercise2$stra <- rowMeans(strategic_columns)
exercise2$attitude <- exercise2$Attitude / 10


#Next we access the dplyr-package and choose which columns to keep. We create a new dataset "learning2014" and look at 
#the structure of the data. Last we exclude the observation where points are zero with the Filter command.

library(dplyr)
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(exercise2, one_of(keep_columns))
str(learning2014)
View(learning2014)
learning2014 <- filter(learning2014, Points > 0)

#Finally, we create a new data-folder and save the data as a csv-file and open it.

getwd()
setwd("\\\\ATKK/home/k/kaihovaa/Kurssit/Open data science/IODS-project-master/data")
write.csv(learning2014, file ="create_learning2018.csv")
Exercise2data <- read.csv("\\\\ATKK/home/k/kaihovaa/Kurssit/Open data science/IODS-project-master/data/create_learning2018.csv", sep=",", header=TRUE)
View(Exercise2data)
str(Exercise2data)
head(Excercise2data)
