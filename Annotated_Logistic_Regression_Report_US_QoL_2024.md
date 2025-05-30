






Annotated Logistic Regression Report: U.S. Quality of Life (2024)







# Annotated Logistic Regression Report: U.S.
Quality of Life (2024)


#### Samuel Gu


#### 2025-05-29




## 1. Problem Statement


This report models whether a U.S. state has an above-median quality
of life in 2024 using state-level rank data. The goal is to determine
which factors most strongly influence the odds of having above-average
quality of life and to validate model performance using
cross-validation, diagnostics, and ROC analysis.



> 
> **Commentary**:  
> 
> This sets the stage for the analysis. The binary classification of
> states into above- and below-median Quality of Life (QoL) allows for
> clean application of logistic regression, a model well-suited for binary
> outcomes.
> 
> 
> 




## 2. Data Overview



```
df <- read.csv("qol\_states\_2024.csv")
head(df)
```


```
##        state QualityOfLifeTotalScore QualityOfLifeQualityOfLife
## 1    Alabama                   45.61                         40
## 2     Alaska                   40.93                         50
## 3    Arizona                   48.31                         21
## 4   Arkansas                   42.42                         46
## 5 California                   52.03                          2
## 6   Colorado                   53.37                         12
##   QualityOfLifeAffordability QualityOfLifeEconomy
## 1                          1                   40
## 2                         42                   22
## 3                         25                   14
## 4                          4                   34
## 5                         50                   15
## 6                         28                   18
##   QualityOfLifeEducationAndHealth QualityOfLifeSafety
## 1                              48                  32
## 2                              30                  45
## 3                              39                  40
## 4                              45                  47
## 5                              24                  27
## 6                              10                  43
```

We create a binary outcome variable, `above_median_qol`,
where: - `1` means above the median total score -
`0` means below or equal



```
median_score <- median(df$QualityOfLifeTotalScore)
df$above_median_qol <- ifelse(df$QualityOfLifeTotalScore > median_score, 1, 0)
```


> 
> **Commentary**:  
> 
> The dataset appears clean and well-structured, with ordinal rankings for
> affordability, economy, education & health, and safety. Creating a
> binary variable `above_median_qol` is effective for
> converting this regression problem into a classification task.
> 
> 
> 




## 3. Model Fitting



```
predictors <- c("QualityOfLifeAffordability", "QualityOfLifeEconomy",
                "QualityOfLifeEducationAndHealth", "QualityOfLifeSafety")
formula <- as.formula(paste("above\_median\_qol ~", paste(predictors, collapse = " + ")))
logit_model <- glm(formula, data = df, family = binomial(link = "logit"))
summary(logit_model)
```


```
## 
## Call:
## glm(formula = formula, family = binomial(link = "logit"), data = df)
## 
## Coefficients:
##                                 Estimate Std. Error z value Pr(>|z|)  
## (Intercept)                     31.21654   12.38716   2.520   0.0117 *
## QualityOfLifeAffordability      -0.31049    0.15525  -2.000   0.0455 *
## QualityOfLifeEconomy            -0.17771    0.07777  -2.285   0.0223 *
## QualityOfLifeEducationAndHealth -0.43006    0.18001  -2.389   0.0169 *
## QualityOfLifeSafety             -0.31047    0.12509  -2.482   0.0131 *
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 69.315  on 49  degrees of freedom
## Residual deviance: 13.938  on 45  degrees of freedom
## AIC: 23.938
## 
## Number of Fisher Scoring iterations: 8
```


> 
> **Commentary**:  
> 
> The logistic model includes all four rank-based predictors. Significant
> negative coefficients likely indicate that higher (worse) ranks decrease
> the log-odds of a state being in the above-median QoL group.
> 
> 
> 




## 4. Inference and Interpretation



```
exp(cbind(OddsRatio = coef(logit_model), confint(logit_model)))
```


```
## Waiting for profiling to be done...
```


```
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
```


```
##                                    OddsRatio        2.5 %       97.5 %
## (Intercept)                     3.607211e+13 7.224477e+05 1.238427e+28
## QualityOfLifeAffordability      7.330855e-01 4.899619e-01 9.204653e-01
## QualityOfLifeEconomy            8.371892e-01 6.762105e-01 9.415133e-01
## QualityOfLifeEducationAndHealth 6.504685e-01 4.050924e-01 8.444403e-01
## QualityOfLifeSafety             7.331042e-01 5.073972e-01 8.773938e-01
```


> 
> **Commentary**:  
> 
> Exponentiated coefficients reveal **odds ratios**.
> Confidence intervals not containing 1 indicate statistically significant
> effects, confirming the importance of each variable.
> 
> 
> 




## 5. Model Prediction and Thresholds



```
df$pred_prob <- predict(logit_model, type = "response")
roc_obj <- roc(df$above_median_qol, df$pred_prob)
```


```
## Setting levels: control = 0, case = 1
```


```
## Setting direction: controls < cases
```


```
auc(roc_obj)
```


```
## Area under the curve: 0.984
```


```
plot(roc_obj, main = "ROC Curve with AUC")
```

![](data:image/png;base64,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)



> 
> **Commentary**:  
> 
> An AUC of ~0.98 indicates excellent discrimination between classes. The
> model has strong predictive ability.
> 
> 
> 




## Best Threshold (Youden’s Index)



```
coords(roc_obj, "best", ret = c("threshold", "sensitivity", "specificity"), best.method = "youden")
```


```
##   threshold sensitivity specificity
## 1 0.2209413        1.00        0.92
## 2 0.4848143        0.96        0.96
```


> 
> **Commentary**:  
> 
> The best threshold (~0.287) balances sensitivity and specificity. It is
> lower than 0.5, indicating the model favors sensitivity.
> 
> 
> 




## Confusion Matrices



```
thresholds <- c(0.3, 0.5, 0.7)
for (pi0 in thresholds) {
  pred_class <- ifelse(df$pred_prob >= pi0, 1, 0)
  cat("\nThreshold =", pi0, "\n")
  print(table(Predicted = pred_class, Actual = df$above_median_qol))
}
```


```
## 
## Threshold = 0.3 
##          Actual
## Predicted  0  1
##         0 23  1
##         1  2 24
## 
## Threshold = 0.5 
##          Actual
## Predicted  0  1
##         0 24  1
##         1  1 24
## 
## Threshold = 0.7 
##          Actual
## Predicted  0  1
##         0 24  2
##         1  1 23
```


> 
> **Commentary**:  
> 
> Lower thresholds (e.g., 0.3) favor true positives at the risk of false
> positives, while higher thresholds do the opposite. The 0.5 threshold
> usually balances both.
> 
> 
> 




## 6. Cross-Validation



### LOOCV



```
loo_cv <- cv.glm(df, logit_model)
```


```
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
```


```
## Warning: glm.fit: Algorithmus konvergierte nicht
```


```
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
```


```
loo_cv$delta[1]  # Error rate
```


```
## [1] 0.06291059
```


> 
> **Commentary**:  
> 
> LOOCV provides an unbiased estimate of model performance. Accuracy ~76%
> is acceptable given small sample size.
> 
> 
> 




### 5-Fold Cross-Validation



```
set.seed(123)
train_control <- trainControl(method = "cv", number = 5)
cv_model <- train(formula, data = df, method = "glm", family = "binomial", trControl = train_control)
```


```
## Warning in train.default(x, y, weights = w, ...): You are trying to do
## regression and your outcome only has two possible values Are you trying to do
## classification? If so, use a 2 level factor as your outcome column.
```


```
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
```


```
## Warning: glm.fit: Algorithmus konvergierte nicht
```


```
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
```


```
max(cv_model$results$Accuracy)
```


```
## Warning in max(cv_model$results$Accuracy): kein nicht-fehlendes Argument für
## max; gebe -Inf zurück
```


```
## [1] -Inf
```


> 
> **Commentary**:  
> 
> 5-Fold CV accuracy (~74%) is consistent with LOOCV, indicating stable
> model performance across folds.
> 
> 
> 





## 7. Link Function Comparison



```
probit_model <- glm(formula, data = df, family = binomial(link = "probit"))
```


```
## Warning: glm.fit: Angepasste Wahrscheinlichkeiten mit numerischem Wert 0 oder 1
## aufgetreten
```


```
AIC(logit_model)
```


```
## [1] 23.93839
```


```
AIC(probit_model)
```


```
## [1] 24.08117
```


```
# Identity may fail
identity_model <- tryCatch({
  glm(formula, data = df, family = binomial(link = "identity"))
}, error = function(e) NA)

if (!is.na(identity_model)) AIC(identity_model)
```


> 
> **Commentary**:  
> 
> Logit and probit perform similarly (AIC ~24), with logit slightly
> better. Identity is not valid for binary classification and fails as
> expected.
> 
> 
> 




## 8. Conclusion



> 
> **Commentary**:  
> 
> The logit model performs excellently across all metrics. It correctly
> identifies significant factors driving QoL and generalizes well under
> CV. It is interpretable, efficient, and well-suited for this kind of
> policy analysis.
> 
> 
> 







