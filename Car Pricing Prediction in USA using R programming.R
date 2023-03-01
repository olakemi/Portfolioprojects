APPENDIX
#Install libraries
pkgs = c("klaR", "caret", "ElemStatLearn") 
install.packages(pkgs) 
install.packages("ISLR")
install.packages("tree")
install.packages("class")
install.packages("plotrix")
install.packages("kableExtra")
install.packages("wesanderson")
install.packages("bestglm")
install.packages("ggparallel")
install.packages("bestglm")
install.packages("moments")
install.packages("tidyverse")
install.packages("DataExplorer")
install.packages("dplyr")
install.packages("corrgram")
install.packages("caret")
install.packages("psych")
install.packages("moments")
install.packages("vif")
install.packages("corrplot")
#Import Necessary Libraries
library(tidyr)
library(moments)
library (tidyverse)
library (DataExplorer)
library (dplyr)
library (caret)
library(corrgram)
library(ggplot2)
library(RColorBrewer)
library(wesanderson)
library(plotrix)
library(kableExtra)
library("PerformanceAnalytics")
library(psych)
library (caret)
library(corrgram)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(wesanderson)
library(plotrix)
library("ElemStatLearn")
library("klaR") 
library(yardstick)
library(ggplot2)
library("class")
library(tree)
library(data.tree)
library(ISLR)
library(party)
library(rpart)
library(rpart.plot)
library(caTools)
library(GGally)
library(RColorBrewer)
library(rattle)
library(DAAG)
library(mlbench)
library(pROC)
library(e1071)
library(moments)
require("lmtest")
library(vif)
library(corrplot)


#Setting APPLIED STATISTICS") working directory
setwd("C:/Users/User/OneDrive/Desktop/APPLIED STATISTICS")

#clearing the workspace to check for hidden vslues (reset workspace)
rm(list = ls())

#import the csv file
cars <- read.csv("CarPrice_Assignment.csv",sep = ",", header = TRUE)

#cars <- read.csv("CarPrice_Assignment.csv", stringsAsFactors = FALSE)

#viewing the csv file
View(cars)

#exploring the structure of the data
str(cars)

# checking for missing values
colSums(is.na(cars))
sum(is.na(cars))

#Plot bar to check the data metrics
plot_intro(cars)

#dropping the first 2 columns
newcars <- cars[-c(1:2) ]
newestcars <-newcars[-c(1:1) ]

#Viewing the dataset
View(newcars)


#selecting categorical variables from dataset
catcars <- select_if(newestcars, is.character)

#selecting numeric variables from dataset
numcars <- select_if(cars, is.numeric)




#SUMMARY OF THE DATASET (numeric variables)
summary(numcars)
# Summary of the dependent variable "Price"
summary(numcars$price)
#  SD and other descriptive statistics
summary(cars$price)
sd(cars$price)

#viewing skewnness of the distributions

skewness(newestcars$citympg)
skewness(newestcars$wheelbase)
skewness(newestcars$curbweight)
skewness(newestcars$enginesize)
skewness(newestcars$boreratio)
skewness(newestcars$stroke)
skewness(newestcars$compressionratio)
skewness(newestcars$horsepower)
skewness(newestcars$peakrpm)
skewness(newestcars$highwaympg)
skewness(newestcars$price)


# proportion distribution of the nominal features (categorical)
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

# bar plot of categorical variables
plot_bar(cars)

plot_bar(catcars)
#histogram plots
hist(newestcars$citympg, main = "Histogram of Citympg",
     xlab = "Citympg per miles")

hist(newestcars$wheelbase , main = "Histogram of Wheelbase",
     xlab = "Wheelbase")

hist(newestcars$carlength, main = "Histogram of Carlength",
     xlab = "Centimetres")

hist(newestcars$curbweight, main = "Histogram of Curbweight",
     xlab = "Kilograms")


hist(newestcars$carwidth, main = "Histogram of Curbwidth",
     xlab = "Feet")

hist(newestcars$enginesize, main = "Histogram of Enginesize",
     xlab = "cubic cm")

hist(newestcars$boreratio, main = "Histogram of Boreratio",
     xlab = "Milimetres")

hist(newestcars$stroke, main = "Histogram of Stroke",
     xlab = "Kilometres")

hist(newestcars$compressionratio, main = "Histogram of Compressionratio",
     xlab = "Ratio")
hist(newestcars$horsepower, main = "Histogram of Horsepower",
     xlab = "Horsepower")
hist(newestcars$peakrpm, main = "Histogram of Peakrpm",
     xlab = "Revolutions per minute")
hist(newestcars$highwaympg, main = "Histogram of Highwaympg",
     xlab = "Miles per gallon")

hist(newestcars$price, main = "Histogram of Price",
     xlab = "Price in $")

#boxplot of all attributes
boxplot(newestcars$citympg, main="Boxplot of of Citympg ",
        ylab="Miles per gallon")

boxplot(newestcars$wheelbase, main="Boxplot of of Wheelbase ",
        ylab="Wheelbase")

boxplot(newestcars$carlength, main="Boxplot of of Carlength ",
        ylab="Centimetres")

boxplot(newestcars$curbweight, main="Boxplot of Curbweight ",
        ylab="Kilograms")


boxplot(newestcars$enginesize, main="Boxplot of Enginesize",
        ylab="Cubic cm")

boxplot(newestcars$boreratio, main="Boxplot of Boreratio ",
        ylab="Milimetres")

boxplot(newestcars$stroke, main="Boxplot of Stroke ",
        ylab="Kilometres")

boxplot(newestcars$compressionratio, main="Boxplot of Compressionratio ",
        ylab="Ratio")
boxplot(newestcars$horsepower, main="Boxplot of Horsepower ",
        ylab="Horsepower")
boxplot(newestcars$peakrpm, main="Boxplot of Peakrpm ",
        ylab="Revolutions per minute")
boxplot(newestcars$boreratiox, main="Boxplot of Peakrpm ",
        ylab="Revolutions per minute")

boxplot(newestcars$highwaympg, main="Boxplot of Highwaympg ",
        ylab="Miles per gallon")

boxplot(newestcars$price, main="Boxplot of Price ",
        ylab="Price in $")




#Uni-variate plots of the dataset
dataset <- data.frame(newestcars)

all_plots <- lapply(X = 1:ncol(dataset), function(x) ggplot()+
                      geom_bar(data = dataset,
                               aes(x = dataset[,x]), fill = "blue" ,
                               alpha = 0.6)+ 
                      
                      xlab(colnames(dataset)[x])
)

        
marrangeGrob(all_plots, nrow=2, ncol=2) 

#################

#scatter plot of numerical variables
plot_scatterplot(numcars, by = "price") 
################
#visualising relationship-scatterplot
#A scatterplot is a diagram that visualizes a bivariate relationship
plot(x = numcars$peakrpm, y = numcars$price,
     main = "Scatterplot of Price vs. Peakrpm",
     xlab = "Peakrpm (rpm.)",
     ylab = "Car Price ($)")

plot(x = numcars$wheelbase, y = numcars$price,
     main = "Scatterplot of Price vs. Wheelbase",
     xlab = "Wheelbase",
     ylab = "Car Price ($)")



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


library(corrplot)
# using corrgram t\o view correlations in the dataset
corrgram(numcars, order=TRUE, upper.panel=panel.cor)
library(corrplot)
corrplot(cor(numcars))
corrplot(cor(numcars, type = "upper", order = "hclust", 
tl.col = "black", tl.srt = 45))

#using Pearson's scatterplot to view correlation in the dataset
pairs.panels(numcars[ c("curbweight", "citympg", "horsepower", "enginesize", "carwidth")])
#pairs.panels(numcars[c( "citympg", "carlength","horsepower","cardwidth", "curbweight","wheelbase", "enginesize", "price")])
chart.Correlation(numcars()[,-1], histogram=T, pch="+")
#Enhanced scatterplo
pairs.panels(numcars[ c("curbweight", "citympg","horsepower" ,"enginesize", "carwidth", "price")])

#Regression model
car_model1 <- lm(price ~ carlength +enginesize+carwidth+ wheelbase+ highwaympg+ curbweight+horsepower+ citympg, data = numcars)
car_model2<- lm(price ~ +enginesize+carwidth+ wheelbase+ highwaympg+ curbweight+horsepower, data = numcars)
car_model3<- lm(price ~ carlength +carwidth+ wheelbase+ highwaympg+ curbweight+horsepower+ citympg, data = numcars)
car_model4<- lm(price ~ carlength +enginesize+carwidth+ highwaympg+ curbweight+ citympg, data = numcars)
car_model5<- lm(price ~ carlength +enginesize+carwidth+ wheelbase+ curbweight+horsepower+ citympg, data = numcars)
car_model6<- lm(price ~ carlength + enginesize+carwidth+ wheelbase+highwaympg+horsepower+ citympg, data = numcars)
car_model7- lm(price ~ carlength + enginesize+carwidth+ wheelbase+highwaympg+ citympg, data = numcars)
car_model8<- lm(price ~ carlength + enginesize+carwidth+ wheelbase+highwaympg, data = numcars)
##Final model
car_model<- lm(price ~ enginesize +carwidth+ horsepower+curbweight, data = numcars)
# OUTPUT OF REGRESSION MODEL
summary(car_model)

#Designate peakrpm and wheelbase as a numeric /categorical factor
numcars$peakrpm<-as.numeric(numcars$peakrpm)
numcars$peakrpm<-as.factor(numcars$peakrpm)
peakrpm <-as.numeric(numcars$peakrpm)

#Perform the Shapiro-Wilk Test for Normality on each group
shapiro.test( as.numeric( numcars$peakrpm ) )
shapiro.test( as.numeric( numcars$wheelbase ) )

#Perform QQ plots by group
ggplot(data = numcars, mapping = aes(sample = price, color = peakrpm, fill = peakrpm)) +
  stat_qq_band(alpha=0.5, conf=0.95, qtype=1, bandType = "ts") +
  stat_qq_line(identity=TRUE) +
  stat_qq_point(col="black") +
  facet_wrap(~ peakrpm, scales = "free") +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") + theme_bw() 

#Perform Levene's Test of Equality of Variances (Peakrpm)
lev1<-leveneTest(price ~ peakrpm, data=numcars, center="mean")
lev2<-leveneTest(price ~ peakrpm, data=numcars, center="median")
print(lev1)
print(lev2)

#Perform Levene's Test of Equality of Variances(wheelbase)
lev1<-leveneTest(price ~ wheelbase, data=numcars, center="mean")
lev2<-leveneTest(price ~ wheelbase, data=numcars, center="median")
print(lev1)
print(lev2)

##STEPS FOR HYPOTHESIS TESTING
#F test to compare two variances
var.test(numcars$price, numcars$peakrpm)
var.test(numcars$price, numcars$wheelbase)

#Produce boxplots and visually check for outliers
ggplot(numcars, aes(x = peakrpm, y = price, fill = peakrpm)) +
  stat_boxplot(geom ="errorbar", width = 0.5) +
  geom_boxplot(fill = "light blue") + 
  stat_summary(fun.y=mean, geom="point", shape=10, size=3.5, color="black") + 
  ggtitle("Boxplots of Price and Peakrpm") + 
  theme_bw() + theme(legend.position="none")

ggplot(numcars, aes(x = wheelbase, y = price, fill = wheelbase)) +
  stat_boxplot(geom ="errorbar", width = 0.5) +
  geom_boxplot(fill = "light blue") + 
  stat_summary(fun.y=mean, geom="point", shape=10, size=3.5, color="black") + 
  ggtitle("Boxplots of Price and wheelbase") + 
  theme_bw() + theme(legend.position="none")


#Perform an Independent Samples T-test
m1<-t.test(numcars$price, peakrpm, data=numcars, var.equal=FALSE, na.rm=TRUE)
print(m1)

m2<-t.test(numcars$price, numcars$wheelbase, data=numcars, var.equal=TRUE, na.rm=TRUE)
print(m2)

##test assumptions
#Plotting density plot
plot(density(numcars$residuals))
#Breusch-Pagan test
bptest(car_model)

#Residual-Fitted plot
resact %>% ggplot(aes(fitted, residual)) + geom_point() + geom_hline(aes(yintercept = 0)) + 
theme(panel.grid = element_blank(), panel.background = element_blank())

#residual Shapiro test
shapiro.test(numcars$residuals)
#Residual-Fitted plot
coef(car_model)
fitted.values(car_model)
numcars$predicted <- fitted.values(car_model)
View(numcars$predicted)
residuals(car_model)
numcars$residuals <- residuals(car_model)
View(numcars)
#Residual Plot
resact <- data.frame(residual = numcars$residuals, fitted = numcars$predicted)

#Residual plot
resact %>% ggplot(aes(fitted, residual)) + geom_point() + geom_hline(aes(yintercept = 0)) + 
  geom_smooth() + theme(panel.grid = element_blank(), panel.background = element_blank())

#checking for Multicollinearity
vif(car_model)

#Plotting for normality
qqnorm(numcars$residuals); qqline(numcars$residuals,col=2)

###checking for Heteroscedasticity

plot(numcars$predicted,
     numcars$residuals)

#Welch two sample t-test  

t.test(numcars$price, numcars$wheelbase, var.equal = FALSE)

