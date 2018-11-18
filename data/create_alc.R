#---
#title: "Chapter 2 data wrangling"
#author: "Antti Kaihovaara"
#date: "November 13, 2018"
#description: "Chapter 3 data"
#Data : "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
#---
  
getwd()
setwd("\\\\ATKK/home/k/kaihovaa/Kurssit/Open data science/IODS-project-master/data")

StudentMat <- read.csv("student-mat.csv", sep=";", header=TRUE)
StudentPor <- read.csv("student-por.csv", sep=";", header=TRUE)
