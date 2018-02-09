## load package(s), script(s) ####
library(dplyr)
source("load-data.R")

# glimpse(train_raw)
# glimpse(test_raw)


# unique IDs and rows match?
# length(unique(train_raw$id)) # 2400
# length(unique(test_raw$id)) # 600


# counts for spacegroup, number_of_total_atoms
# table(train_raw$spacegroup)
# table(train_raw$number_of_total_atoms)
# table(test_raw$spacegroup)
# table(test_raw$number_of_total_atoms)

# spacegroup, number_of_total_atoms values not seen in test set?
#setdiff(unique(train_raw$spacegroup), unique(test_raw$spacegroup))
#setdiff(unique(train_raw$number_of_total_atoms), unique(test_raw$number_of_total_atoms))


# check for missing data
#any(is.na(train_raw))
#any(is.na(test_raw))


# remove duplicated rows???
# which(duplicated(train_raw[,-1]))
#[1]  694  987 1009 1073 1159 1325 1436 1679 1769 1857 1889 1923 2085 2262 2314 2361
# sum(duplicated(train_raw[,-1]))  #[1] 16
# sum(duplicated(test_raw[,-1]))  #[1] 121

#unique(train_raw[,2:12]) # only 1313 rows




