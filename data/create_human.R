# Antti Kaihovaara
# November 25th
# Chapter 4: Data Wrangling (for week 5)

library(dplyr)

# Reading the data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# Metadata http://hdr.undp.org/en/content/human-development-index-hdi

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
# Metadata http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

# Exploration an summary
str(hd)
dim(hd)
summary(hd)

# Renaming the variables

colnames(hd) <- c("HDI_Rank", "Country", "HDI_index", "Life_Exp", "Edu_Exp", "Edu_Mean", "GNI", "GNI_Minus_HDI" )

# Exploring data gii

str(gii)
dim(gii)
summary(gii)

# Renaming the variables, part 2


colnames(gii) <- c("Gii_Rank","Country", "Gii_Index","Mat_Mortal_Ratio","Teen_Preg_Rate","Repres_Parl","Sec_grade_edu_F", "Sec_grade_edu_M", "Working_F", "Working_M")

# Adding two new variables: Edu_Ratio_Gender and Working_Ratio_Gender

ERG <- (gii$Sec_grade_edu_F / gii$Sec_grade_edu_M)
WRG <- (gii$Working_F / gii$Working_M)

gii <- mutate(gii, Edu_Ratio_Gender = ERG)
gii <- mutate(gii, Working_Ratio_Gender = WRG)

str(gii)

# Join datasets

join_by <- c("Country")

human <- inner_join(hd, gii, by = join_by)

str(human)


write.csv(human, file = "create_human.csv", row.names=TRUE)
write.table(human, file = "create_human.txt", row.names=TRUE)
 
