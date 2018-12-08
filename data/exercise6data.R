#---
#title: "Chapter 6 data wrangling"
#author: "Antti Kaihovaara"
#date: "December 8, 2018"
#description: "Chapter 6 data"
#Data1: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
#Data2:https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt
#---

getwd()
setwd("\\\\ATKK/home/k/kaihovaa/Kurssit/Open data science/IODS-project-master/data")

library(dplyr)
library(tidyr)

# Reading the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

#Let's give the data a look. We start from BPRS. The data contains 40 observations and 
#11 variables. Apparently 40 individuals were followed during 8 weeks. Some of them
#received "treatment" and the others did not.

str(BPRS)
names(BPRS)
summary(BPRS)

#Converting the categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Converting to long form and extracting the week number
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(BPRSL$weeks, 5, 5)))


glimpse(BPRSL)
names(BPRSL)
summary(BPRSL)

#In the long format the observations of the same individual are


#How about the RATS data?

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Factoring the variables ID and Group
RATS$ID <- factor(RATS$ID)
RATS$Group <-factor(RATS$Group)

glimpse(RATS)

# Converting the data to long form
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group)
RATSL <- RATSL %>% mutate(Time = as.integer(substr(RATSL$WD, 3, 4)))  

glimpse(RATSL)
names(RATSL)
summary(RATSL)

#Finally, writing the data to a file
write.csv(BPRSL, file = "BPRSLong.csv", row.names=TRUE)
write.csv(RATSL, file = "RATSLong.csv", row.names=TRUE)