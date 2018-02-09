## load package(s), script(s) ####
library(caret)
library(randomForest)
library(doMC)
registerDoMC(cores = 3)


# log1p translation fo targets
train_raw$formation_energy_ev_natom <- log1p(train_raw$formation_energy_ev_natom) 
train_raw$bandgap_energy_ev <- log1p(train_raw$bandgap_energy_ev) 

all_feats <- names(train_raw)
feats1 <- setdiff(all_feats, c("id", "bandgap_energy_ev"))
feats2 <- setdiff(all_feats, c("id", "formation_energy_ev_natom"))

control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(3)
modelRF <- caret::train(
  formation_energy_ev_natom ~ ., data = train_raw[, feats1],
  method = "rf", trControl = control,
  eval = "rmse"
)
modelRF2 <- caret::train(
  bandgap_energy_ev ~ ., data = train_raw[, feats2],
  method = "rf", trControl = control,
  eval = "RMSE", tuneLength = 3
)

# summary(resamples(list(bandgap_ev = modelRF2, formation_ev = modelRF)))
list(bandgap_ev = modelRF2, formation_ev = modelRF) %>%
  resamples() %>%
  summary()



## predict using test ####
formation_ev_test <- predict(modelRF, test_raw[, -1])
bandgap_ev_test <- predict(modelRF2, test_raw[, -1])

pred_df <- data.frame(
  id = test_raw$id,
  formation_energy_ev_natom = expm1(formation_ev_test),
  bandgap_energy_ev = expm1(bandgap_ev_test)
)

readr::write_csv(pred_df, path = file.path("submissions", "rf-pred-1.csv"))

