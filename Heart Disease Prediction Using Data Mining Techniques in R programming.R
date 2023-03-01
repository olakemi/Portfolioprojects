Basic Exploratory Data Analysis code in R
#Install libraries
install.packages("plotrix")
install.packages("kableExtra")
install.packages("wesanderson")
install.packages("bestglm")
install.packages("ggparallel")
install.packages("bestglm")
#Import Necessary Libraries
library(tidyr)
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(wesanderson)
library(plotrix)
library(kableExtra)
require(knitr)
require(dplyr)
require(ggplot2)
require(readr)
require(gridExtra) #for multiple plots
require(GoodmanKruskal) 
require(vcd)
require(psych) # for phi() in order to compute the strenght of a found association
require(ggparallel) # for parallel coordinate plot
require(bestglm) # to find the best variable subset using CV
require(RColorBrewer) # apetizing palettes!
hdisease <- read.csv("E:/Semester - 2/Data Mining/Project/framingham.csv")
head(hdisease)
#showing NA values and bar plot
colSums(is.na(hdisease))
data<-colSums(is.na(hdisease))
data_withNA <- data[data>0]
barplot(data_withNA)
table(data_withNA)
hdisease <- hdisease %>% drop_na() #Dropping All NA in the dataset
################################EDA ###########################################
hdisease$TenYearCHD<-as.factor(hdisease$TenYearCHD)
levels(hdisease$TenYearCHD)<-c("No", "Yes")
str(hdisease)
#Age of patients
p1 <- ggplot(data = hdisease, aes(x = age)) 
p1 + geom_bar(stat = 'Count', aes(y = ..count..), fill = 'skyblue4') +
  labs(x = 'Age', y = 'Population', title = 'Age of the patient') +
  theme_classic()
#Heart Disease w.r.t Age
ggplot(hdisease,aes(x=age,fill=TenYearCHD,color=TenYearCHD)) + geom_histogram(binwidth = 
                                                                                1,color="black") + labs(x = "Age",y = "Frequency", title = "Heart Disease w.r.t. Age")
#Current Smoker and Non Smoker
hdisease$currentSmoker<-as.factor(hdisease$currentSmoker)
hdisease$male<-as.factor(hdisease$male)
p2 <- ggplot(data = hdisease, aes(x = currentSmoker, fill = male)) 
p2 + geom_bar(position = "dodge") +
  xlab('Current Smoker') +
  ylab('Population') +
  labs(title = 'Current Smokers',
       subtitle = '0 means not a current smoker; 1 means a current smoker',
       fill = 'male')
#Education Details Dropping NA columns
hdisease_edunum <- hdisease %>%
  count(education)
str(hdisease_edunum)
hdisease_edunum$education = as.factor(hdisease_edunum$education)
p3 <- ggplot(data = hdisease_edunum, aes(x = "", y = n, fill = education)) 
p3 + geom_bar(width = 1, stat = "identity", color = "white") + 
  coord_polar("y", start=0) +
  scale_fill_hue(c=45, l=80) +
  labs(title = "Patients' Education level")
#Pie chart of Education Levels
mytable <- (hdisease_edunum$n)
pie3D(mytable,labels=mytable,explode=0.1,
      main="Pie Chart of Education with levels")
#bar graph of education levels
barplot(hdisease_edunum$n, names.arg = c('1', '2', '3','4'),col = c('red', 'green', 
                                                                    'skyblue','blue'),main="Bar Graph of Education with different levels")
#Identify the different level of Education
hdisease_edunum %>% 
  group_by(education) %>%
  count() %>% 
  ungroup() %>%
  kable(align = rep("c", 2)) %>% kable_styling("full_width" = F)
#Education versus BMI
hdisease_edu <- hdisease %>% 
  group_by(education) %>% 
  summarise(BMI = median(BMI,na.rm=TRUE))
p4 <- ggplot(data = hdisease_edu, aes(x = education , y = BMI, fill = education))
p4 + 
  geom_bar(stat = 'identity',show.legend = F) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = 'Education', y = 'Average BMI', title = 'Education versus BMI') 
##################################################################################
#######################
#Uni-variate plots of the dataset
dataset <- data.frame(hdisease)
all_plots <- lapply(X = 1:ncol(dataset), function(x) ggplot()+
                      geom_bar(data = dataset,
                               aes(x = dataset[,x]), fill = "blue" ,
                               alpha = 0.6)+ 
                      
                      xlab(colnames(dataset)[x])
)
#colnames(dataset) 
marrangeGrob(all_plots, nrow=2, ncol=2)
Data Modeling using 3 Data Mining Algorithm in R
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
library(naivebayes)
################### Dataset Loading and cleaning #####################
heart_disease_dataset <- read.csv("C:/Users/mshre/Desktop/Data Mining/project/framingham.csv", 
                                  header = TRUE)
#missing values
colSums(is.na(heart_disease_dataset))
heart_disease_dataset <- heart_disease_dataset %>% drop_na() #Dropping All NA in the dataset
heart_disease_dataset_clean<- heart_disease_dataset
heart_disease_dataset_clean[1:15] <- lapply(heart_disease_dataset_clean[1:15], as.numeric)
heart_disease_dataset_clean$TenYearCHD<- as.factor(heart_disease_dataset_clean$TenYearCHD)
ggcorr(
  heart_disease_dataset,
  cor_matrix = cor(heart_disease_dataset, use = "pairwise"),
  label = T, 
  hjust = 0.95,
  angle = 0,
  size = 4,
  layout.exp = 3
)
#calling function for KNN algorithm
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x))) }
#for normalizing the dataset
heart_disease_dataset_clean_n <- as.data.frame(lapply(heart_disease_dataset_clean[1:15], 
                                                      normalize))
##################################################################################
# Split the data in training and testing for algorithms
set.seed(1234)
inx = sample(nrow(heart_disease_dataset_clean), round(nrow(heart_disease_dataset_clean) * 0.7)) 
train = heart_disease_dataset_clean[inx,] 
test = heart_disease_dataset_clean[-inx,] 
#Define a matrix with features, X_train And a vector with class labels, y_train 
X_train = train[,-16] # dropped the last (target) column.
y_train = train$TenYearCHD
X_test = test[,-16] 
y_test = test$TenYearCHD
##################################################################################
#Naive Bayes
#Train the model with Naive Bayes
NBclassifier_cl <- naiveBayes(train$TenYearCHD ~ ., data = train)
# Predicting on test data'
y_pred <- predict(NBclassifier_cl, newdata = test)
# Confusion Matrix
cm <- table(test$TenYearCHD, y_pred)
# Model Evaluation
confusion_matrix_NB <- confusionMatrix(y_test,y_pred)
precision(cm)
recall(cm)
#FourFold Confusion Matrix plot
fourfoldplot(confusion_matrix_NB$table, color = c("cyan", "pink"),
             conf.level = 0, margin = 1, main = "Confusion Matrix of Naive Bayes without K fold")
#with K fold cross validation
NBclassifier_cl_WK = train(TenYearCHD~., heart_disease_dataset_clean, method = 'nb', 
                           trControl = trainControl(method = 'cv', number = 10)) 
##################################################################################
#KNN
#Train the model with KNN
knnclassifier_cl <- knn(train,test, cl= y_train)
#Confusion Matrix
cm1 <- table(y_test, knnclassifier_cl)
confusionMatrix_KNN<-confusionMatrix(y_test, knnclassifier_cl)
fourfoldplot(confusionMatrix_KNN$table, color = c("cyan", "pink"),
             conf.level = 0, margin = 1, main = "Confusion Matrix of KNN without K fold")
#with K fold cross validation
KNNclassifier_cl_WK = train(TenYearCHD~., heart_disease_dataset_clean, method = 'knn', 
                            trControl = trainControl(method = 'cv', number = 10)) 
#################################################################################
#Decision Tree
#Now we fit a tree to these data, and summarize and plot it.
tree.HeartDisease<-ctree(TenYearCHD~.,data=heart_disease_dataset_clean)
summary(tree.HeartDisease)
plot(tree.HeartDisease)
text(tree.HeartDisease,pretty=0)
set.seed(123) 
split =sample.split(heart_disease_dataset_clean,SplitRatio = 0.7) 
train = subset(heart_disease_dataset_clean,split == TRUE) 
test = subset(heart_disease_dataset_clean,split == FALSE) 
head(train) 
#Run tree model to find the most optimum cp 
fulltree <- rpart(formula = TenYearCHD~., data = train, control = rpart.control(cp=0)) 
mincp <- fulltree$cptable[which.min(fulltree$cptable[,"xerror"]),"CP"] 
plotcp(fulltree)
fancyRpartPlot(fulltree)
p <- predict(fulltree, test, type = 'class')
DTConfusion_Matrix_without_K<-confusionMatrix(test$TenYearCHD,p)
fourfoldplot(DTConfusion_Matrix_without_K$table, color = c("cyan", "pink"),
             conf.level = 0, margin = 1, main = "Confusion Matrix of Decision Tree")
#Tree Pruning 
prunedtree <- prune(fulltree, cp = mincp) 
rpart.plot(prunedtree, box.palette="RdBu", digits = -3) 
prune <- predict(prunedtree, test, type = 'class')
DTConfusion_Matrix_prune<-confusionMatrix(test$TenYearCHD,prune)
fourfoldplot(DTConfusion_Matrix_prune$table, color = c("cyan", "pink"),
             conf.level = 0, margin = 1, main = "Confusion Matrix of Pruned DT")
cm2 <- table(test$TenYearCHD, prune)
test$pruned <- predict(prunedtree, test, type = "vector") 
installed.packages('Metrics')
performance <- data.frame( R2 = R2(test$pruned, test$TenYearCHD), 
                           RMSE = RMSE(test$pruned, test$TenYearCHD), 
                           MAE = MAE(test$pruned, test$TenYearCHD), 
                           MSE2 = mean((test$pruned - test$TenYearCHD)^2)) 
performance 
# K-fold cross-validation 
DecisionTree_WK = train(TenYearCHD~., heart_disease_dataset_clean, method = 'rpart', 
                        trControl = trainControl(method = 'cv', number = 10))