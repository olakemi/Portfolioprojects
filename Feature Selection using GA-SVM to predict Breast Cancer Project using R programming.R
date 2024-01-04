install.packages("DataExplorer")
library(DataExplorer)

#To upload csv file

#> setwd("C:/Users/XXXX/OneDrive/Desktop")   ## click the session option on rstudio,set the working directory to the set file e.g desktop
#then, upload the file by runnung the example below

breastcan <- read.csv("breastcancer.csv")
#breast_train <- read.csv("breast_train.csv")

#breastcan <- read.csv("breastcancer.csv")   # create a variable e.g (breastcan) and upload the csv file

#To view the content of file

#breastcan(view) or view(breastcancer) and enter
#or just enter breastcancer

#check data structure
#str(breastcan)
#checking for missing data
#plot_intro(breastcan)

#checking for no of missing columns
#plot_intro(breastcan)


#checking for a missing data
#miss <- sum(is.na(breastcan))
#miss
#or
#sum(is.na(breastcan))


#checking the details in a feature
#input the variable and dollar sign($) and click on the feature you need to check
#breastscan$(click on the feature to check on the dropbox option)
#press enter

#assigning a variable to a colunm
#diagnosis<-breastcan$diagnosis
#diagnosis

#DELETING A COLUNMN IN R

#Input the below

breastcan$id <- NULL
breastcan$X <- NULL
# and enter

#deleting n/a :steps
#complete.cases(breastcan) & enter
#which(complete.cases(breastcan)) & enter
#which(!complete.cases(breastcan)) & enter

#create new variables
#na_vec <- which(complete.cases(breastcan))
#na_vec

#na_vec <- which(!complete.cases(breastcan))
#na_vec

#brestscan_no_na <- breastcan[-na_vec,]
#brestscan_no_na

#then check variable again as a new colunm will have be created for n/a
#then delete column

#breastcan$id <- NULL
# and enter

#checking the first and last and last rows(number of rows to view needs to be stated) of a datasets
#example
#head(breastscan, 4)
#press enter
#tail(breastscan, 4)
#press enter

#changing statments in column to True or false or binary
#step 1
#create a new variable and attached the feature to it (using the old variable $ sign aand picking from the dropbox for the required features and enter the new varisble, see example below)
#press enter
#example
#breastcans <- breastcan$diagnosis== "M"
#breastcans

#to create a new column with the true/yes (create a new variable and attached the initial variable(breastcan with the earlier new variable breastcans)
#see below example
#breastcan_new <- cbind(breastcan, breastcans)
#breastcan_new

#link to video on youtube
#Logic Statements (TRUE/FALSE), cbind and rbind Functions in R | R Tutorial 1.10| MarinStatsLectures

#svm

# how to split data to training and test

#split dataset into training (70%) and validation (30%)


#summary of the dataset: mean, median,1st and 3rd quarter
#summary(breastcan)
#press enter
#checking the summary for a single feature
## summary + input the variable and dollar sign($) in a bracket() and click on the feature you need to check
#ist step: input summary
#2nd step: input breastscan$(click on the feature to check on the dropbox option)= summary(breastcan$perimeter_se)
#press enter

#To plot graphs

#upload the csv file

#download plotly on rstudio
#install.packages("plotly")

#then
#formula
#plot(x = my_data$wt, y = my_data$mpg,
     #pch = 16, frame = FALSE,
     #xlab = "wt", ylab = "mpg", col = "#2E9FDF")

#example with the breastscancer dataset

#plot(x = breastcan$texture_mean, y = breastcan$compactness_mean,
     #pch = 16, frame = FALSE,
     #xlab = "texture_mean", ylab = "compactness_mean", col = "#2E9FDF")

#scatterplot
#x <- breastcan$texture_mean
#y <- breastcan$concavity_mean
#plot(x, y, main = "Breastcancer",
     #xlab = "texture_mean", ylab = "concavity_mean",
     #pch = 19, frame = FALSE)
#plot(x, y, main = "Breastcancer",
    # xlab = "texture_mean", ylab = "concavity_mean",
     #pch = 19, frame = FALSE)
#abline(lm(y ~ x, data = breastcan), col = "blue")


#enhanced scatterplot
#install package

#install.packages("car")

#then run

#library("car")
#scatterplot(wt ~ mpg, data = mtcars)

#example for the breastscan dataset

#library("car")
#scatterplot(texture_mean ~ concavity_mean, data = breastcan)

#changing from character to a factor
breastcan$diagnosis <- as.factor(breastcan$diagnosis)

#changing character to 1 or 0
levels(breastcan$diagnosis)[levels(breastcan$diagnosis)=="B"] <- "0"
levels(breastcan$diagnosis)[levels(breastcan$diagnosis)=="M"] <- "1"

# creating function to split data into train and test
#train_test <- function(diagnosis, size = 0.8, train = TRUE) {
  #train_row = size * nrow(diagnosis)
  #train_set <- 1: train_row
  #if (train == TRUE) {
    #return (diagnosis[train_set, ])
  #} else {
    #return (diagnosis[-train_set, ])
  #}
#}
#diagnosis_train <<- train_test(diagnosis, 0.8, train = TRUE)
#diagnosis_test <<- train_test(diagnosis, 0.8, train = FALSE)

library(caTools)
split = sample.split(breastcan$diagnosis, SplitRatio = 0.8)
diagnosis_train = subset(breastcan, split == TRUE)
diagnosis_test = subset(breastcan, split == FALSE)
#write.csv(diagnosis_train, "breast_train")
#write.csv(diagnosis_test, "breast_test")


#install.packages("plotly")
#plot(mymodel, data = breastcan, slice = list(sepal.width = 3, sepal.length = 4))
#then
#formula
#plot(x = my_data$wt, y = my_data$mpg,
#pch = 16, frame = FALSE,
#xlab = "wt", ylab = "mpg", col = "#2E9FDF")

#example with the breastscancer dataset

#plot(x = breastcan$texture_mean, y = breastcan$compactness_mean,
#pch = 16, frame = FALSE,
#xlab = "texture_mean", ylab = "compactness_mean", col = "#2E9FDF")

#scatterplot
#x <- breastcan$texture_mean
#y <- breastcan$concavity_mean
#plot(x, y, main = "Breastcancer",
#xlab = "texture_mean", ylab = "concavity_mean",
#pch = 19, frame = FALSE)
#plot(x, y, main = "Breastcancer",
#xlab = "texture_mean", ylab = "concavity_mean",
#pch = 19, frame = FALSE)
#abline(lm(y ~ x, data = breastcan), col = "blue")

TClass <- factor(c(0, 0, 1, 1))
PClass <- factor(c(0, 1,0,1))
Y  <-c(2816, 248,34,235)
df<-a.frame(TClass, PClass, Y)

#library(ggplot2)
#ggplot(data= df, mapping = aes(x=TClass, y=PClass)
       #geom_tile(aes(fill=Y), colour="white)+geom_text(aes(label=sprintf()))
                 
        
#Import libraries
library(e1071)
library(caret)


#Load data

#data$id <- NULLdata=  read.csv('breastcancer.csv')    # for 32 features
data = read.csv('breastcancer_newest.csv')  # for 15 features
data = read.csv('breastcancer_new14.csv')  # for 14 features
data = read.csv('breastcancer_newer.csv')   # for 12 features
data = read.csv('breastcancer_new11.csv')   # for 11 features
data = read.csv('breastcancer_new.csv')   # for 9 features
data = read.csv('breastcancer_newer8.csv')  # for 8 features


data$id <- NULL

#changing from character to a factor
data$diagnosis <- as.factor(data$diagnosis)
#str(data)

#data = subset(train, select = -c(radius_mean, texture_mean) )


#changing character to 1 or 0
levels(data$diagnosis)[levels(data$diagnosis)=="B"] <- "0"
levels(data$diagnosis)[levels(data$diagnosis)=="M"] <- "1"


#use 80% of dataset as training set and 20% as test set
sample <- sample(c(TRUE, FALSE), nrow(data), replace=TRUE, prob=c(0.8,0.2))
train  <- data[sample, ]
test   <- data[!sample, ]


#dropping missing values and unwanted columns
#train = subset(train, select = -c(radius_mean, texture_mean) )
#test = subset(train, select = -c(radius_mean, texture_mean) )

#radius_mean	texture_mean	perimeter_mean	area_mean	smoothness_mean	compactness_mean	concavity_mean	concave points_mean	symmetry_mean	fractal_dimension_mean	radius_se	texture_se	perimeter_se	area_se	smoothness_se	compactness_se	concavity_se	concave points_se	symmetry_se	fractal_dimension_se	radius_worst	texture_worst	perimeter_worst	area_worst	smoothness_worst	compactness_worst	concavity_worst	concave points_worst	symmetry_worst	fractal_dimension_worst



#SVM
learn_svm <- svm(diagnosis~., data=train)
pre_svm <- predict(learn_svm, test)
cm_svm <- confusionMatrix(pre_svm, test$diagnosis)
cm_svm




library(e1071)
mymodel <- svm(diagnosis~., data=train)
summary(mymodel)

pred <-predict(mymodel, test)
tab <-table(Predicted=pred, Actual=test$diagnosis)
tab


#miscalassication error

1-sum(diag(tab))/sum(tab)



#accuracy metrix is confusion matrix,


ctable <- as.table(matrix(c(68, 2, 4, 44), nrow = 2, byrow = TRUE))
fourfoldplot(ctable, color = c("cyan", "pink"),
             conf.level = 0, margin = 1, main = "Confusion Matrix")

#Tuning
#Hyper parameter used to select the best model
tmodel <- tune(svm, diagnosis~., data = data, ranges =list(epsilon=seq(0.1,0.1), cost = 2^(2:9)))
plot(tmodel)
summary(tmodel)
#gives us performace of SVM
#DARKER region = lower miscalssification error

#we can choose our best model using tmodel

#Best model(we can replot with the best model)

mymodel <- tmodel$best.model
summary(mymodel)
plot(mymodel, data=data, M~B) 



