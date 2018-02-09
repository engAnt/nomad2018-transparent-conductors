## load package(s) ####
rm(list = ls())
library(readr)


# save data as rds file for faster re-importing later
saveDataToRDS <- function(file_path_rds, file_path_csv) {
  tmp_raw <- NULL
  if (file.exists(file_path_rds)) {
    print("***** reading from rds file **********")
    tmp_raw <- readRDS(file_path_rds)
  } else {
    tmp_raw <- read_csv(file_path_csv, guess_max =  3000)
    saveRDS(tmp_raw, file_path_rds)
  }
  tmp_raw
}


# *** re-run lines below Only (if necessary) ****************************

## Load train, test CSV files ####
# train
train_raw_rds <- file.path("data", "train.rds")
train_raw_csv <- file.path("data", "train.csv")
train_raw <- saveDataToRDS(train_raw_rds, train_raw_csv)

# test
test_raw_rds <- file.path("data", "test.rds")
test_raw_csv <- file.path("data", "test.csv")
test_raw <- saveDataToRDS(test_raw_rds, test_raw_csv)

rm(train_raw_csv, train_raw_rds, test_raw_csv, test_raw_rds)


## Load Geometry files??? ####



