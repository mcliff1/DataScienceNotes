Sys.time()
if (!require("pacman")) install.packages("pacman")
pacman::p_load(knitr, tidyverse, data.table, lubridate, zoo, DescTools, lightgbm, tictoc, pryr, caret)
set.seed(1)               
options(scipen = 9999, warn = -1, digits= 4)

total_rows <- 184903890  # from prior data exploratio

debug  <- FALSE # TRUE
#######################################################
testing_size <- 100000

total_rows <- 184903890  # from prior data exploratio
if (!debug) {
  train_rows <- 50000000 #40000000
  skip_rows_train <- total_rows - train_rows
  test_rows <- -1L
} else {
  train_rows <- testing_size
  skip_rows_train <- 0
  test_rows <- testing_size
}
##############################

train_path <- "../input/train.csv"
test_path  <- "../input/test.csv"
mem_before <- mem_used()

#######################################################

train_col_names <- c("ip", "app", "device", "os", "channel", 
                     "click_time", "attributed_time", "is_attributed")

most_freq_hours_in_test_data <- c("4","5","9","10","13","14")
least_freq_hours_in_test_data <- c("6","11","15")

#######################################################


cat("Reading ", train_rows, "training data records, from row ", skip_rows_train, " to row ", (train_rows + skip_rows_train))
train <- fread(train_path, skip = skip_rows_train, nrows = train_rows, colClasses = list(numeric=1:5),
               showProgress = FALSE, col.names = train_col_names) %>% select(-c(attributed_time))           
invisible(gc())

#######################################################
cbind(before=mem_before, after=mem_used())
Sys.time()


