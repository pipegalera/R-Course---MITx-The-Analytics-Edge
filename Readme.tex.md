# The Analytics Edge

What is analytics? Analytics is the science of using data to build models that lead to better decisions that add value to individuals, to companies and institutions.

# Unit 1. Introduction to R

- vector[3] -> Gives the element "3" of the vector.
- seq(0,100,2) -> Gives a sequence from 0 to 100 with jumps of 2 units.
- data.frame(vector_1, vector_2) -> Gives the combination of vector_1 and vector_2, for numerical and non-numerical elements.
- CountryData"$"Population -> adds the column "Population" to the dataset "CountryData"
- rbind() -> joint datasets
- getwd() -> gets the directory you are working on
- subset(dataset, variable == "the one you want") -> creates a subset of the dataframe with the vaiable that you select. It works also with a condition instead.
- write.csv(dataset, "el nombre.csv")
- names() -> gives the names of the variables
- match("name", dataset$variable_name) -> finds the index of the variable "name"

# Unit 2. Linear Regression

\begin{align*}
  y^i=\beta_0 + \beta_1X^i+\epsilon^i
\end{align*}

Where $\beta_0$ is the intercept coefficient, $\beta_1$ is the regression coefficient and $\epsilon$ is the error term.

- SST: Sum of Squares Total. Is the squared differences between the observed dependent variable and its mean:

\begin{align*}
  \sum\limits_{i=1}^{n}(y_i-\hat{y}_i)^2
\end{align*}

In R: sum((test-mean(training))^2)

- SSE: Sum of Squared Errors. Measures the unexplained variability by the regression.

\begin{align*}
  \sum\limits_{i=1}^{n}(\epsilon_i)^2
\end{align*}

The SEE's units of measurement are hard to interpret: if you use twice the amount of data it twice the amount of the error. Due to that we use:

- RMSE: Root mean squared error. Its the sum of squared errors normalized by the number of observations (N).

\begin{align*}
  RMSE= \sqrt{\fraq{SSE}{N}}
\end{align*}

- $$R^2$$: R-squared captures the value added of the model. It represents the proportion of the variance for a dependent variable that is explained by the independent variables of the regression.

\begin{align*}
  R^2= 1-\fraq{SSE}{SST}
\end{align*}

Goes from 0, or "no improvement over baseline", to 1, or "perfect predictive model". In other words, it tells us the accuracy on the training model, but *not* how well the model perform on new data (test data). In can be a "perfect predictive model" for the data that you already have and no predictive power over new data (*overfitting*)

- Not all available variables should be used in the analysis. Each new variable requires mode data, and might cause overfitting: high $$R^2$$ on the training data to create a model but bad performance on test data.

- T-value: measures the size of the difference relative to the variation in your sample data. The larger the absolute value of the t-value, the more likely the estimate is significant.

\begin{align*}
  t = \fraq{\hat{x}-\mu}{s/\sqrt{n}}
\end{align*}

Where $$\hat{x}$$ is the training mean, $$\mu_i$$ is the hypothesized test mean, $$s$$ is the standard deviation error and $$n$$ the sample size. You can think of the T-value as the estimator over the standard error normalized.

- Correlation: measures the linear relationship between variables. One of the main problem of linear regression is *multicollinearity*, which means that two of the independent variables used in the model are highly correlated.

- AIC: Akaike Information Criterion. Is an "out-of-sample" estimator that helps model selection. Given a collection of models for the data, AIC estimates the quality of each model relative to each of the others. How it evaluate quality? It sets a trade-off between simplicity of the model and predictability:

\begin{align*}
  AIC = 2k - 2ln(\hat{L})
\end{align*}

Where k is the number of parameters (dependent variables) and $$\hat{L}$$ the maximum value of the likelihood function for the model. You have one AIC value for each model, the more AIC value the better. The penalty discourages overfitting, because increasing the number of parameters in the model almost always improves the goodness of the fit.

- The use of logarithms in the dependent variable prevents that an unusual small number of observations affect disproportionally the SEE or RMSE. For example, you have a regression that explains really well 99% of your data points but the SEE is high not because the model is badly specificated but because you have an 1% of extreme observations that higher up the SEE.

<p align="center">
<img src="x.png" width="40%" height="40%">
</p>
