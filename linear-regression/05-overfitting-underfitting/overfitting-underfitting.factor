# use-this-graph-to-build
# confirm-sufficiency-before-start
# link-back-after-build
# status:pending

# overfitting-underfitting — generalization control

overfitting: [train-low|test-high, cause:too-complex|too-many-features|too-few-data]
underfitting: [train-high|test-high, cause:too-simple|insufficient-features]
solution: [overfit-fix:regularization|reduce-feature|more-data, underfit-fix:add-feature|complex-model|less-regularization]
L1: [Lasso, add-lambda*sum|wi|, sparse-weight, auto-feature-selection]
L2: [Ridge, add-lambda*sum(wi^2), shrink-weight, keep-all-features, default-choice]
