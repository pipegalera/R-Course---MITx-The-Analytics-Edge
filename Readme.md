# The Analytics Edge

What is analytics? Analytics is the science of using data to build models that lead to better decisions that add value to individuals, to companies and institutions.

# Unit 1. Introduction to R

```
- vector[3] -> Gives the element "3" of the vector.
- seq(0,100,2) -> Gives a sequence from 0 to 100 with jumps of 2 units.
- data.frame(vector_1, vector_2) -> Gives the combination of vector_1 and vector_2, for numerical and non-numerical elements.
- CountryData<img src="/tex/3a5e2b96731cb7dd030b25eab7314ff8.svg?invert_in_darkmode&sanitize=true" align=middle width=774.94956pt height=126.57534120000001pt/>variable_name) -> finds the index of the variable "name"
````

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

<p align="center"><img src="/tex/7774215092ae6407a258c8de783c5717.svg?invert_in_darkmode&sanitize=true" align=middle width=131.89583879999998pt height=39.452455349999994pt/></p>

- <img src="/tex/ee9dc84d168b211ff9f4b354e295af3c.svg?invert_in_darkmode&sanitize=true" align=middle width=19.161017699999988pt height=26.76175259999998pt/>: R-squared captures the value added of the model. It represents the proportion of the variance for a dependent variable that is explained by the independent variables of the regression.

<p align="center"><img src="/tex/376b036b167bf6880b5bcc01552011c4.svg?invert_in_darkmode&sanitize=true" align=middle width=107.32051934999998pt height=33.62942055pt/></p>

Goes from 0, or "no improvement over baseline", to 1, or "perfect predictive model". In other words, it tells us the accuracy on the training model, but *not* how well the model perform on new data (test data). In can be a "perfect predictive model" for the data that you already have and no predictive power over new data (*overfitting*)

- Not all available variables should be used in the analysis. Each new variable requires mode data, and might cause overfitting: high <img src="/tex/ee9dc84d168b211ff9f4b354e295af3c.svg?invert_in_darkmode&sanitize=true" align=middle width=19.161017699999988pt height=26.76175259999998pt/> on the training data to create a model but bad performance on test data.

- T-value: measures the size of the difference relative to the variation in your sample data. The larger the absolute value of the t-value, the more likely the estimate is significant.

<p align="center"><img src="/tex/74c3b5a9a84f1ff79677cd08503acf6c.svg?invert_in_darkmode&sanitize=true" align=middle width=69.3165627pt height=37.99258484999999pt/></p>

Where <img src="/tex/f84e86b97e20e45cc17d297dc794b3e8.svg?invert_in_darkmode&sanitize=true" align=middle width=9.39498779999999pt height=22.831056599999986pt/> is the training mean, <img src="/tex/ce9c41bf6906ffd46ac330f09cacc47f.svg?invert_in_darkmode&sanitize=true" align=middle width=14.555823149999991pt height=14.15524440000002pt/> is the hypothesized test mean, <img src="/tex/6f9bad7347b91ceebebd3ad7e6f6f2d1.svg?invert_in_darkmode&sanitize=true" align=middle width=7.7054801999999905pt height=14.15524440000002pt/> is the standard deviation error and <img src="/tex/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode&sanitize=true" align=middle width=9.86687624999999pt height=14.15524440000002pt/> the sample size. You can think of the T-value as the estimator over the standard error normalized.

- Correlation: measures the linear relationship between variables. One of the main problem of linear regression is *multicollinearity*, which means that two of the independent variables used in the model are highly correlated.

- AIC: Akaike Information Criterion. Is an "out-of-sample" estimator that helps model selection. Given a collection of models for the data, AIC estimates the quality of each model relative to each of the others. How it evaluate quality? It sets a trade-off between simplicity of the model and predictability:

<p align="center"><img src="/tex/94c4140eebdc61b67199e7e9068626ce.svg?invert_in_darkmode&sanitize=true" align=middle width=140.35990155pt height=19.68035685pt/></p>

Where <img src="/tex/63bb9849783d01d91403bc9a5fea12a2.svg?invert_in_darkmode&sanitize=true" align=middle width=9.075367949999992pt height=22.831056599999986pt/> is the number of parameters (dependent variables) and <img src="/tex/dc8dc5a2f03a5937263a8b1b75664767.svg?invert_in_darkmode&sanitize=true" align=middle width=11.18724254999999pt height=31.141535699999984pt/> the maximum value of the likelihood function for the model. You have one AIC value for each model, the more AIC value the better. The penalty discourages overfitting, because increasing the number of parameters in the model almost always improves the goodness of the fit.

- The use of logarithms in the dependent variable prevents that an unusual small number of observations affect disproportionally the SEE or RMSE. For example, you have a regression that explains really well 99% of your data points but the SEE is high not because the model is badly specificated but because you have an 1% of extreme observations that higher up the SEE.
