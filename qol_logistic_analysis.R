
# Logistic Regression Analysis for Quality of Life Data (2024)

# Load required libraries
library(tidyverse)
library(caret)
library(pROC)
library(boot)

# Load the dataset
df <- read.csv("qol_states_2024.csv")

# Create binary target variable
median_score <- median(df$QualityOfLifeTotalScore)
df$above_median_qol <- ifelse(df$QualityOfLifeTotalScore > median_score, 1, 0)

# Select predictors
predictors <- c("QualityOfLifeAffordability", "QualityOfLifeEconomy",
                "QualityOfLifeEducationAndHealth", "QualityOfLifeSafety")

# Fit logistic regression
formula <- as.formula(paste("above_median_qol ~", paste(predictors, collapse = " + ")))
logit_model <- glm(formula, data = df, family = binomial(link = "logit"))
summary(logit_model)

# Confidence intervals (multiplicative effects)
exp(cbind(OR = coef(logit_model), confint(logit_model)))

# Predicted probabilities
df$pred_prob <- predict(logit_model, type = "response")

# ROC Curve and AUC
roc_obj <- roc(df$above_median_qol, df$pred_prob)
auc_val <- auc(roc_obj)
plot(roc_obj, main = paste("ROC Curve (AUC =", round(auc_val, 3), ")"))

# Best cutoff using Youden's Index
roc_df <- coords(roc_obj, "best", ret = c("threshold", "sensitivity", "specificity"), best.method = "youden")
best_threshold <- roc_df["threshold"]

# Confusion matrices at different thresholds
thresholds <- c(0.3, 0.5, 0.7)
for (pi0 in thresholds) {
  pred_class <- ifelse(df$pred_prob >= pi0, 1, 0)
  cat("\nThreshold =", pi0, "\n")
  print(table(Predicted = pred_class, Actual = df$above_median_qol))
}

# LOOCV
loo_cv <- cv.glm(df, logit_model)
cat("\nLOOCV Error Rate:", loo_cv$delta[1], "\n")

# K-Fold CV (k=5)
set.seed(123)
train_control <- trainControl(method = "cv", number = 5)
cv_model <- train(formula, data = df, method = "glm", family = "binomial", trControl = train_control)
cat("5-Fold CV Accuracy:", max(cv_model$results$Accuracy), "\n")

# Probit model
probit_model <- glm(formula, data = df, family = binomial(link = "probit"))
AIC(logit_model); AIC(probit_model)

# Identity link (may fail)
identity_model <- tryCatch({
  glm(formula, data = df, family = binomial(link = "identity"))
}, error = function(e) NA)
if (!is.na(identity_model)) AIC(identity_model)

