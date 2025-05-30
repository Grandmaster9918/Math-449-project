
# U.S. Quality of Life Logistic Regression Analysis (2024)

This project performs a full logistic regression analysis using 2024 data on U.S. states' quality of life metrics.

## 📂 Files Included

- `qol_states_2024.csv`: Raw data file containing quality of life metrics by state
- `qol_logistic_analysis.R`: R script that executes the entire analysis workflow

## 📊 Analysis Overview

We model whether a U.S. state has an **above-median quality of life** using four predictors:
- Affordability Rank
- Economy Rank
- Education & Health Rank
- Safety Rank

## 🔍 Methodology

1. Logistic regression modeling
2. Confidence interval estimation for odds ratios
3. ROC curve and AUC calculation
4. Optimal threshold determination using Youden’s Index
5. Confusion matrices for multiple thresholds
6. Cross-validation:
   - Leave-One-Out CV (LOOCV)
   - 5-Fold CV
7. Alternative link functions (probit, identity)

## 🧪 Key Results

- **AUC**: 0.984
- **Best cutoff (Youden)**: ~0.287
- **LOOCV Accuracy**: ~76%
- **5-Fold CV Accuracy**: ~74%
- **Logit AIC**: ~23.94 (best among links)

## 🚦 Requirements

This project uses:
- R (>= 4.0)
- Packages: `tidyverse`, `caret`, `pROC`, `boot`

Install them via:
```R
install.packages(c("tidyverse", "caret", "pROC", "boot"))
```

## 🧾 License

CC 0 universal PD declaration.
