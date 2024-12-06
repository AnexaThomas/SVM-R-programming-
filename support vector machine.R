dataset <- read.csv("C:/Users/windows/Desktop/rstudio program/Social_Network_Ads.csv")
dataset
dataset <- dataset[3:5]

#Encoding the target feature as factor
dataset$Purchased = factor(dataset$Purchased,levels = c(0,1))

#splitting the data into training and test data
set.seed(120)
library(caTools)
split<-sample.split(dataset$Purchased,SplitRatio=0.75)
head(split)
train<-subset(dataset,split="TRUE")
train
test<-subset(dataset,split="FALSE")
test

#fitting Logistic regression to the training set
install.packages('e1071')
library(e1071)
classifier <- svm(formula = Purchased ~ .,
                  data = train,
                  type='C-classification',
                  kernel='linear')

#run the test data through the model
y_pred <-predict(classifier,newdata = test)
y_pred

#making the confusion matrix
val=table(test[,3],y_pred)
val


#accuracy
(val[[1,1]]+val[[2,2]])/sum(val)