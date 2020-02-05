# The Analytics Edge

What is analytics? Analytics is the science of using data to build models that lead to better decisions that add value to individuals, to companies and institutions.

# Unit 1. Introduction to R

- vector[3] -> Gives the element "3" of the vector.
- seq(0,100,2) -> Gives a sequence from 0 to 100 with jumps of 2 units.
- data.frame(vector_1, vector_2) -> Gives the combination of vector_1 and vector_2, for numerical and non-numerical elements.
- CountryData"<img src="/tex/bdc5ed60461badbbe8b84453f84334b4.svg?invert_in_darkmode&sanitize=true" align=middle width=783.1687693499999pt height=126.57534120000001pt/>variable_name) -> finds the index of the variable "name"

# Unit 2. Linear Regression

<p align="center"><img src="/tex/61262a329566e304947932d2a82cd5b5.svg?invert_in_darkmode&sanitize=true" align=middle width=141.2716173pt height=17.597769749999998pt/></p>

Where <img src="/tex/3bde0199092dbb636a2853735fb72a69.svg?invert_in_darkmode&sanitize=true" align=middle width=15.85051049999999pt height=22.831056599999986pt/> is the intercept coefficient, <img src="/tex/15ef3b23ef739e47090fa0825bf9d390.svg?invert_in_darkmode&sanitize=true" align=middle width=15.85051049999999pt height=22.831056599999986pt/> is the regression coefficient and <img src="/tex/7ccca27b5ccc533a2dd72dc6fa28ed84.svg?invert_in_darkmode&sanitize=true" align=middle width=6.672392099999992pt height=14.15524440000002pt/> is the error term.

- SST: Sum of Squares Total. Is the squared differences between the observed dependent variable and its mean:

<p align="center"><img src="/tex/051dd31f7aeb9adff1e115d0bacbf13c.svg?invert_in_darkmode&sanitize=true" align=middle width=90.23796044999999pt height=44.89738935pt/></p>

In R: sum((test-mean(training))^2)

- SSE: Sum of Squared Errors. Measures the unexplained variability by the regression.

<p align="center"><img src="/tex/7133ba5f5a7a1adaed451470dacf15a7.svg?invert_in_darkmode&sanitize=true" align=middle width=55.227508050000004pt height=44.89738935pt/></p>

The SEE's units of measurement are hard to interpret: if you use twice the amount of data it twice the amount of the error. Due to that we use:

- RMSE: Root mean squared error. Its the sum of squared errors normalized by the number of observations (N).

<p align="center"><img src="/tex/99161ce1bbca758cd60c3a0b01e37e38.svg?invert_in_darkmode&sanitize=true" align=middle width=140.2109247pt height=16.438356pt/></p>

- <p align="center"><img src="/tex/5980c17499e2d5158c596bcd63f3169f.svg?invert_in_darkmode&sanitize=true" align=middle width=19.1610177pt height=14.202794099999998pt/></p>: R-squared captures the value added of the model. It represents the proportion of the variance for a dependent variable that is explained by the independent variables of the regression.

<p align="center"><img src="/tex/fdb472eba6beef1b372ae2d02fc21695.svg?invert_in_darkmode&sanitize=true" align=middle width=139.29192584999998pt height=15.572667pt/></p>

Goes from 0, or "no improvement over baseline", to 1, or "perfect predictive model". In other words, it tells us the accuracy on the training model, but *not* how well the model perform on new data (test data). In can be a "perfect predictive model" for the data that you already have and no predictive power over new data (*overfitting*)

- Not all available variables should be used in the analysis. Each new variable requires mode data, and might cause overfitting: high <p align="center"><img src="/tex/5980c17499e2d5158c596bcd63f3169f.svg?invert_in_darkmode&sanitize=true" align=middle width=19.1610177pt height=14.202794099999998pt/></p> on the training data to create a model but bad performance on test data.

- T-value: measures the size of the difference relative to the variation in your sample data. The larger the absolute value of the t-value, the more likely the estimate is significant.

<p align="center"><img src="/tex/1e17118495ac8c0c6485c319b8636b59.svg?invert_in_darkmode&sanitize=true" align=middle width=106.73501849999998pt height=17.4097869pt/></p>

Where <p align="center"><img src="/tex/114bb3fb62e91ef270cc92fd2216ae1f.svg?invert_in_darkmode&sanitize=true" align=middle width=9.3949878pt height=11.4155283pt/></p> is the training mean, <p align="center"><img src="/tex/b39e75248b11a5b309b8e02ef9eff339.svg?invert_in_darkmode&sanitize=true" align=middle width=14.55582315pt height=10.2739725pt/></p> is the hypothesized test mean, <p align="center"><img src="/tex/0d6d0a3f5bcc5a27d3ba5cf91524b5a4.svg?invert_in_darkmode&sanitize=true" align=middle width=7.705480199999999pt height=7.0776222pt/></p> is the standard deviation error and <p align="center"><img src="/tex/b49da7325822089835b531a5fce8b94e.svg?invert_in_darkmode&sanitize=true" align=middle width=9.866876249999999pt height=7.0776222pt/></p> the sample size. You can think of the T-value as the estimator over the standard error normalized.

- Correlation: measures the linear relationship between variables. One of the main problem of linear regression is *multicollinearity*, which means that two of the independent variables used in the model are highly correlated.

- AIC: Akaike Information Criterion. Is an "out-of-sample" estimator that helps model selection. Given a collection of models for the data, AIC estimates the quality of each model relative to each of the others. How it evaluate quality? It sets a trade-off between simplicity of the model and predictability:

<p align="center"><img src="/tex/94c4140eebdc61b67199e7e9068626ce.svg?invert_in_darkmode&sanitize=true" align=middle width=140.35990155pt height=19.68035685pt/></p>

Where k is the number of parameters (dependent variables) and <p align="center"><img src="/tex/35a2bf58b8de54a175921997b470af8f.svg?invert_in_darkmode&sanitize=true" align=middle width=11.18724255pt height=15.570767849999998pt/></p> the maximum value of the likelihood function for the model. You have one AIC value for each model, the more AIC value the better. The penalty discourages overfitting, because increasing the number of parameters in the model almost always improves the goodness of the fit.

- The use of logarithms in the dependent variable prevents that an unusual small number of observations affect disproportionally the SEE or RMSE. For example, you have a regression that explains really well 99% of your data points but the SEE is high not because the model is badly specificated but because you have an 1% of extreme observations that higher up the SEE.

<p align="center">
<img src="x.png" width="40%" height="40%">
</p>
