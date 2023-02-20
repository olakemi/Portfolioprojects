pkgs = c("klaR", "caret", "ElemStatLearn") 
install.packages(pkgs) 
install.packages("https://cran.rproject.org/src/contrib/Archive/ElemStatLearn/ElemStatLearn_2015.6.26.1.tar.gz", repos=NULL)
install.packages("ISLR")
install.packages("tree")
install.packages("class")
library("ElemStatLearn")
library("klaR") 
library("caret") 
library(tidyr)
library(yardstick)
library(ggplot2)
library("class")
library(tree)
library(data.tree)
library(ISLR)
library(dplyr)
library(party)
library(rpart)
library(rpart.plot)
library(caTools)
library(caret)
library(GGally)
library(RColorBrewer)
library(rattle)
library(DAAG)
library(mlbench)
library(pROC)
library(e1071)
library(moments)
library (tidyverse)
library (DataExplorer)
library (dplyr)
library (caret)
library(corrgram)

library(tidyr)
library(moments)
library (tidyverse)
library (DataExplorer)
library (dplyr)
library (caret)
library(corrgram)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(wesanderson)
library(plotrix)
library(kableExtra)
library("PerformanceAnalytics")
library(psych)
install.packages("moments")
install.packages("tidyverse")
install.packages("DataExplorer")
install.packages("dplyr")
install.packages("corrgram")
install.packages("caret")
install.packages("psych")


#Setting APPLIED STATISTICS") working directory
setwd("C:/Users/User/OneDrive/Desktop/APPLIED STATISTICS")

#clearing the workspace to check for hidden vslues (reset workspace)
rm(list = ls())

#import the csv file
cars <- read.csv("CarPrice_Assignment.csv",sep = ",", header = TRUE)

#cars <- read.csv("CarPrice_Assignment.csv", stringsAsFactors = FALSE)

#viewing the csv file
View(cars)
View(newestcars)
View(numcars)

#exploring the structure of the data
str(cars)

#selecting categorical variables from dataset
catcars <- select_if(newestcars, is.character)

#selecting numeric variables from dataset
numcars <- select_if(newestcars, is.numeric)


#you can used a character for histogram so you need to convert it (so str function help to check the structure)



# checking for missing values
colSums(is.na(cars))

sum(is.na(cars))
#Plot bar to check the data metrics
plot_intro(cars)

#Viewing the dataset
View(newcars)

#dropping the first 2 columns
newcars <- cars[-c(1:2) ]
newestcars <-newcars[-c(1:1) ]



#SUMMARY OF THE DATASET (numeric variables)
summary(numcars)

#CORRELATION MATRIX
ggcorr(
  numcars,
  cor_matrix = cor(numcars, use = "pairwise"),
  label = T, 
  hjust = 0.95,
  angle = 0,
  size = 4,
  layout.exp = 3
)

# using corrgram t\o view correlations in the dataset
corrgram(numcars, order=TRUE, upper.panel=panel.cor)
library(corrplot)
corrplot(cor(numcars))
##corrplot(cor(numcars, type = "upper", order = "hclust", 
##tl.col = "black", tl.srt = 45))

#using Pearson's scatterplot to view correlation in the dataset
pairs.panels(numcars[ c("curbweight", "citympg", "horsepower", "enginesize", "carwidth")])
#pairs.panels(numcars[c( "citympg", "carlength","horsepower","cardwidth", "curbweight","wheelbase", "enginesize", "price")])
chart.Correlation(numcars()[,-1], histogram=T, pch="+")
#Enhanced scatterplo
pairs.panels(numcars[ c("curbweight", "citympg","horsepower" ,"enginesize", "carwidth", "highwaympg", "price")])

enginesize +carwidth+  highwaympg+ curbweight+horsepower+ citympg




numcars$

cars <- cars %>% drop_na() #Dropping All NA in the dataset
carsnew<- cars
carsnew[1:25] <- lapply(carsnew[1:25], as.numeric)
carsnew$price<- as.factor(carsnew$price)




#Uni-variate plots of the dataset
dataset <- data.frame(newestcars)

all_plots <- lapply(X = 1:ncol(dataset), function(x) ggplot()+
                      geom_bar(data = dataset,
                               aes(x = dataset[,x]), fill = "blue" ,
                               alpha = 0.6)+ 
                      
                      xlab(colnames(dataset)[x])
)

#colnames(dataset)        
marrangeGrob(all_plots, nrow=2, ncol=2) 

# proportion distribution of the nominal features (categorical)
carss <-cars
table(catcars)
table(catcars$fueltype)
table(catcars$aspiration)
table(catcars$doornumber)
table(catcars$carbody)
table(catcars$drivewheel)
table(catcars$enginelocation)
table(catcars$enginetype)
table(catcars$cylindernumber)
table(catcars$fuelsystem)



View(numcars)
#summary 
