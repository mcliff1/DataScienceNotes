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
