# use-this-graph-to-build
# confirm-sufficiency-before-start
# link-back-after-build
# status:pending

# solving-methods — how to find optimal w and b

loss-function: [MSE:1/n*sum(yi-yi_hat)^2, quantify-error, differentiable, optimization-target]
data-representation: [feature-matrix:X, target-vector:y, weight-vector:w, bias:b, matrix-form:Y=XW+b]
derivative: [derivative:single-var-rate, partial-derivative:multi-var-fix-others, chain-rule, enables-gradient]
normal-equation: [closed-form:w=(XTX)^-1*XTy, no-iteration, O(n^3), suitable-when:features<10k]
gradient-descent: [iterative:w=w-alpha*dL/dw, learning-rate:alpha, types:batch|SGD|mini-batch, mini-batch:default-choice]
comparison: [normal-eq:exact|no-hyperparameter|slow-large-data, GD:iterative|scalable|needs-tuning]
