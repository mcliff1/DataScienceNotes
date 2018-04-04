require(xlsx)
ccDataFile <- "./data/ccDataFile.xls"

ccDataURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00350/default%20of%20credit%20card%20clients.xls"
download.file(url=ccDataURL, destfile=ccDataFile, mode="wb")

# this is taking forever (when I have giant python job running)
ccData <- read.xlsx(file=ccDataFile, sheetIndex=1, startRow=2)

ccData <- read.xlsx2(file=ccDataFile, sheetIndex=1, startRow=2, stringsAsFactors=FALSE)
d2 <- head(transform(ccData, 
               ID = as.numeric(ID),
               LIMIT_BAL = as.numeric(LIMIT_BAL),
               SEX = as.factor(SEX),
               EDUCATION = as.factor(EDUCATION),
               MARRIAGE = as.factor(MARRIAGE)
               ))
d3 <- ccData %>% mutate_if(is.character, funs(factor(.)))
d3


fCols <- c("SEX", "EDUCATION", "MARRIAGE", "default.payment.next.month")
nCols <- c("LIMIT_BAL", "AGE", "PAY_0", "PAY_2", "PAY_3", "PAY_4", "PAY_5", "PAY_6",
           "BILL_AMT1", "BILL_AMT2", "BILL_AMT3", "BILL_AMT4", "BILL_AMT5", "BILL_AMT6", 
           "PAY_AMT1", "PAY_AMT2", "PAY_AMT3", "PAY_AMT4", "PAY_AMT5", "PAY_AMT6" )
d4 <- ccData %>% mutate_at(fCols, funs(factor(.)))
d5 <- ccData %>% mutate_at(nCols, funs(as.numeric(.)))

d6 <- ccData %>%
    mutate_at(fCols, funs(factor(.))) %>%
    mutate_at(nCols, funs(as.numeric(.)))

summary(factor(d6$PAY_0))
summary(d6$PAY_0)
table(d6$PAY_0, d6$PAY_2)



rm(ccData)
load(file="data/ccData.Rdata")

require(caret)
# takes a long time
fit <- train(default.payment.next.month ~ ., data=ccData)


# using Lasso
mod_lasso <- train(default.payment.next.month ~ ., data=ccData, method="lasso")
library(elasticnet)
plot.enet(mod_lasso$finalModel, xvar="penalty", use.color=TRUE)

require(dplyr)
# lets look at the outliers
table(ccData$LIMIT_BAL)

filter (ccData, LIMIT_BAL > 500000) %>%
    select(EDUCATION, default.payment.next.month)
?qplot
?xyplot
qplot(PAY_AMT1,BILL_AMT1,data=ccData, col=default.payment.next.month)










##########################################
## (2/2/18)
##  Work on PK stuff
pkDataURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/parkinsons/parkinsons.data"
pkDataFile <- "./data/parkinsons.data"
dir.create("data", showWarnings=FALSE)
if (!file.exists(pkDataFile)) {
    download.file(url=pkDataURL, destfile=pkDataFile)
}
pkData <- read.csv(file = pkDataFile)

load("data/pkData.RData")
require(caret)

fit <- train(status ~ ., data=pkData)
plot(fit)
summary(fit$importance)
plot(fit$finalModel)



#### linear regression thing to try
#  note I saved this locally on H:/Programming/datasets
dat <- read.table("http://www4.stat.ncsu.edu/~stefanski/NSF_Supported/Hidden_Images/orly_owl_files/orly_owl_Lin_4p_5_flat.txt", header=FALSE)
pairs(dat)
fit <- lm(V1 ~ . -1, data=dat)
summary(fit)$coef
plot(predict(fit), resid(fit), pch='.')
#########


# back To PK

inTrain <- createDataPartition(pkData$status, p=0.8, list=FALSE)
training <- pkData[inTrain,]
testing <- pkData[-inTrain,]
control <- trainControl(method="cv", number=4)
set.seed(10)
fit.lda <- train(status ~ ., data=training, method="lda")


fit.knn <- train(status ~ ., data=training, method="knn", trControl = control)

pdData <- pkData


# notes from
#https://www.kaggle.com/bwboerman/a-first-dive-with-r-s-data-table-and-caret

variablesFactor <- colnames(pdData)[which(as.vector(pdData[,names(sapply(pdData, class))]) == "character")]

which(as.vector(pdData[,sapply(pdData, class)]) == "character")

pdData[,sapply(pdData, class)]
names(sapply(pdData, class))
pdData[, names(sapply(pdData, class))]


variablesNumeric <- sapply(pdData, is.numeric) # both numeric integers
corrData <- pdData[, names(variablesNumeric)]
names(variablesNumeric)
variablesNumeric
corrData <- pdData[, names(variablesNumeric), with=FALSE]
