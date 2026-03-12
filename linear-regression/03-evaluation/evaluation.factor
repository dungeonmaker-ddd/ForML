# use-this-graph-to-build
# confirm-sufficiency-before-start
# link-back-after-build
# status:pending

# evaluation — measure regression model quality

MAE: [mean-absolute-error:1/n*sum|yi-yi_hat|, robust-to-outlier, interpretable]
MSE: [mean-squared-error:1/n*sum(yi-yi_hat)^2, penalize-large-error, default-loss]
RMSE: [root-MSE:sqrt(MSE), same-unit-as-target, most-common-report-metric]
