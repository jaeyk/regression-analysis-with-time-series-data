# regression-analysis-with-time-series-data

**Regression analysis with time series data**

- Published in *Political Research Quarterly*: https://journals.sagepub.com/doi/10.1177/1065912920983456

## Motivation

The importance of the War on Poverty on the community-building efforts among Asian Americans and Latinos has been mentioned by prior research in sociology, history, and ethnic studies. However, the evidence for this importance has mostly come from anecdotal examples. The present study provides the first systematic evidence for the influence of the War on Poverty programs on Asian American and Latino civic mobilization in the 1960s and 1970s. 

## Datasets

**Update: I scanned and digitized all of the newsletters issued by the National Council of La Raza from 1973 to 1981.**

I have collected a wide range of original data for this project.

1. Organizational data: An original dataset traces the founding of Asian American and Latino CBOs over the last century. The dataset includes about 299 Asian American and 519 Latino CBOs. Each observation includes the organization's title, the year of founding, the physical address, and whether the CBO’s purpose was social (i.e., charitable, educational, cultural or some other non-political function), advocacy (engaged in political or legal lobbying), or hybrid (active in both types of work). I made the dataset publicly available at [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/FLUPBJ) and created a [dashbaord](https://rpubs.com/jaeyeonkim/581083) for easy exploration of the data.

2. Administrative data:
- Federal budget statistics: The federal budget data come from the Budget of the U.S. Government, Fiscal Year 2017 Historical Tables.
- Population statistics: Asian American and Latino population data come from the U.S. census.
- Party control: Party control of the presidency and Congress data come from [Russell D. Renka's website](http://cstl-cla.semo.edu/rdrenka/ui320-75/presandcongress.asp)

3. Foundation data: Ford Foundation information on grants comes from the catalog of the Rockefeller Archive Center.

4. Community newspaper data: The transcribed records of *The International Examiner* (1976 - 1987) are provided by the [Ethnic Newswatch database](https://www.proquest.com/products-services/ethnic_newswatch.html).


## Workflow

1. Data cleaning, wrangling, and merging
2. Descriptive data analysis
3. Statistical modeling of time series data (interrupted time series design)

## 1. Data cleaning, wrangling, and merging [[Code](https://github.com/jaeyk/regression-analysis-with-time-series-data/blob/master/code/01_descriptive_analysis.Rmd)]

The original organization dataset that I collected contains a founding year variable, but it is not time series data. Time series data, by definition, has a series of temporally varying observations. The founding year variable could miss some years if no organizations were founded in those years. For this reason, filling in these years is important. The following code is my custom function to perform that task.


## 2. Descriptive data analysis [[Code](https://github.com/jaeyk/regression-analysis-with-time-series-data/blob/master/code/01_descriptive_analysis.Rmd)]

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/pop_mass_densty.png)

**Figure 1. Organizational trend**

**Update: Used a simpler descriptive plot for easy interpretation.**

Figure 1 shows that, when the organizational founding trend is measured density (number of organizations per 1 milliion population), the founding rate of community-based organizations in both Asian American and Latino communities increased before the budget cut and decreased after the budget cut. We could not find a similar trend in advocacy or hybrid organizations (organizations active both in advocacy and service delivery). This evidence is consistent with the theory that CBOs are service-oriented, and thus most dependent, and thus more dependent on outside financial support than the other two types of organizations. However, the evidence is only suggestive as the change could also have been influenced by other factors. Also, the data includes noise as well as signals.


## 3. Statistical modeling of time series data [[Code](https://github.com/jaeyk/regression-analysis-with-time-series-data/blob/master/code/03_ITS_design_analysis.Rmd)]

### 3.1. Checking on independent and dependent variables

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/reagan_budget_cut.png)

**Figure 2. Budget trend**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/dic_analysis.png)

**Figure 3. Dictionary-based methods analysis**

- **Update: I scanned, digitized, and analyzed all of the newsltters issued by the National Council of La Raza from 1973 to 1981.**

Before moving into a more serious statistical analysis, I checked some assumptions I made about the research design. Figure 2 shows that the percentage of the federal budget for education, employment, and social service plunged after the Reagan cuts. (This amount shows a slight decrease during the Carter administration, as he was forced to reduce social programs due to budget constraints.) Reagan made these reductions more dramatic and consistent throughout the 1980s. A more specific analysis of the budget change shows that programs empowering minority communities, such as the Comprehensive Employment Training Act, were critically hurt by the budget cuts. I did not include a more detailed analysis of these policies owing to spatial constraints. This evidence is important for seeing the budget cut as a major intervention.

Figure 3 shows how minority communities reacted to the budget crisis. The *International Examiner* (IE), a community newspaper circulating among Asian American activists in Seattle, did not mention Reagan until 1981. I created a custom dictionary and analyzed the frequency of budget-related terms that appeared in Reagan-related articles from this newspaper source. The figure shows that when the newspaper first mentioned Reagan, the budget crisis received serious attention. This evidence is crucial for seeing the year 1981 as a critical juncture for Asian American and Latino community organizers.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/outliers_detected.png)

**Figure 4. Outlier detection**

Finally, I checked the presence of outliers (an observation with a large residual). Outliers are particularly influential in small data analysis and can change the results. I construed a multivariate regression model and detected any DV values that are unusual given the predicted values of the model using Cook's distance (Cook's D). I then removed these outliers and imputed new values using the k-nearest neighbors (KNN) algorithm.

### 3.2. Interrupted time-series design

Did the Reagan cuts alter the founding rate of Asian American and Latino CBOs and advocacy organizations? This question is difficult to answer because other factors could have influenced the outcome. To account for these other factors, I built a multivariate statistical model. However, we don't know which model would fit the data best. For that reason, I constructed various statistical models, fitted each of them to the data, and compared their model fit using the Akaike Information Criterion (AIC). The ordinary least squares (OLS) regression model is a base model. OLS with a logged dependent variable fits better for skewed data. The Poisson model assumes that the residuals follow a Poisson, not a normal, distribution. It also models the natural log of the response variable. The negative binomial model is similar to the Poisson model except it does not assume that the conditional means and conditional variances are equal.


![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/pred_plots.png)

**Figure 5. Interrupted time series design analysis**

Figure 5 illustrates how these different models fitted to the data. The blue plotted line indicates predicted values. The grey ribbons, around the line plot, display two standard errors, which are approximate to 95% confidence intervals. The impacts of the intervention could be detected in two ways in an interrupted time series design: level and slope. The level of the predicted values is almost identical between the pre- and post-intervention periods. In contrast, the slope change is detected in all four models.

I then checked the performances of these four models using AIC. The AIC score measures the difference between model accuracy and complexity. A lower AIC score indicates a less overfitting model. However, checking AIC scores of these models at one point might not be sufficient for a comprehensive test. Another concern is that these models perform differently depending on the period under investigation. Some models may fit for a short-term period and others do better for a long term. To address this concern, I created a "for loop" function and checked how the AIC scores of these four models varied as I extended the data from the year 1970 to 2017. Figure 6 indicates that the OLS model with logged dependent variable consistently outperformed the OLS, Poisson, and negative binomial models.

```r

# Initilization vars
lm.AIC <-NA
lm_log.AIC <-NA
poisson.AIC <- NA
nb.AIC <- NA
year <-NA

# For loop
for (i in c(0:38)){

# Models
lm.out <- lm(Freq ~ Percentage + pop_percentage + category, data = subset(reagan_org, Year <= 1970 + i))

lm_log.out <- lm(log(Freq) ~ Percentage + pop_percentage + category, data = subset(reagan_org, Year <= 1970 + i))

poisson.out <- glm(Freq ~ Percentage + pop_percentage + category, data = subset(reagan_org, Year <= 1970 + i), family = "poisson")

nb.out <- glm.nb(Freq ~ Percentage + pop_percentage + category, data = subset(reagan_org, Year <= 1970 + i))

# AIC scores of the models
lm.AIC[i] <- AIC(lm.out)
lm_log.AIC[i] <- AIC(lm_log.out)
poisson.AIC[i] <- AIC(poisson.out)
nb.AIC[i] <- AIC(nb.out)

# Year var
year[i] <- 1970 + i
}

```

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/AIC_in_time.png)

**Figure 6. Model performance comparisons*

**Update: Limited the data for the bootstrapping analysis up to year 2004 to avoid too much extrapolation. The breakpoint was determined by the `strucchange::breakpoints()` function`. This decision applies to all the model outcomes presented below.**

From this point on, I used the OLS with logged DV for the analysis and limited the data to CBOs. We saw the slope change. Given the research question, it is important to know to what extent the federal funding contributed to the slope change as opposed to other factors. To do so, I examined how the coefficients of federal funding changed as we extended the data from 1970 to 2004. For instance, the 1970 data is the subset of the original data which includes observations up to the year 1970. I created a point plot using a for loop. The point plot in Figure 7 shows that the coefficients of the federal funding were positive up to the cutpoint. Then they became almost zero after the cutpoint. An opposite trend was found from the changes in the coefficients of population growth. They were either negative or zero before the cutpoint. Then they became positive in the 1980s and then again became almost zero or negative afterward.

To measure the certainty of the coefficient change, I added confidence intervals using bootstrapping. Bootstrapping is resampling with replacement. For each regression model at a time point, I resampled the data and ran the same analysis for 1,000 times, and created confidence intervals based on the sampling variability of regression coefficients. This information shows that the coefficient change around the cutpoint is statistically significant.

```r
# Initilization vars
fed <- NA
pop <- NA
year <- NA

# For loop
for (i in c(0:38)){

# Model
model <- lm(log(Freq) ~ Percentage + pop_percentage + category, data = subset(reagan_org, Year <= 1970 + i))

# Save iterations
fed[i] <- model$coefficients[3] %>% as.numeric()
pop[i] <- model$coefficients[4] %>% as.numeric()
year[i] <- 1970 + i}

```

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/boot_cis.png)

**Figure 7. Changes in coefficients with bootstrapped CIs**


### 3.3. Correcting standard errors

So far, we have examined how the reduced treatment (reduced budget) influenced the DV. In this subsection, I focus on the first half of the previous analysis: the relationship between the increasing budget and the increasing organizational founding rate. We saw that they are correlated, but is the relationship statistically significant? In Figure 7, the regression coefficients are all over zero before the intervention and the confidence intervals are wide. To check robustness, I ran the model with the subset of the data that included observations up to the year 1980. Then, I employed various methods to calculate correct standard errors.

- Heteroskedasticity: I ran the studentized Breusch-Pagan test to check the presence of heteroskedasticity. This is a problem because OLS assumes constant variance (homoscedasticity). Otherwise, p-values become unstable. The null hypothesis of the test is that the variance of residuals is constant (homoscedasticity). The p-value of the test result is 0.04. Thus, we reject the null hypothesis.
- Autocorrelation: The autocorrelation test (ACF) (Figure 8) shows the correlation between the time series and its lagged values. It appears that none of the correlation coefficients are statistically significant. I also ran the Durbin-Watson test, which checks the autocorrelation of residuals. The test fails to reject the null hypothesis. Therefore, we worry about heteroskedasticity but not autocorrelation.


![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/acf_test.png)

**Figure 8. Autocorrelation test**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/se_table.png)

**Table 1. Standard errors corrected for heteroskedasticity and outliers**

In Table 1, the first model is a simple OLS. The second model is also an OLS but it uses the robust Newey-West variance estimator to account for heteroskedasticity. In this case, we expect the standard errors to be different from the base model. The third model is based on a robust regression model to account for unusual observations. In this case, we expect that both regression coefficients and standard errors could be different from the base model. As expected, they are different but only marginally. The statistical significance of federal funding (p value < 0.01) does not change across the three models. In model 3, the coefficient increased by 0.002. Note that the dependent variable is logged. Thus, the regression coefficient of 0.3 is close to 2. In substantive terms, we can interpret a one percent increase in federal funding to be associated with the increase of the two Asian American and Latino CBOs in the 1960s and 1970s.

### 3.4. Sensitivity analysis

However, we cannot take the regression coefficients at their face value. There could still be confounders. If a model is misspecified, then the regression coefficient is not an unbiased estimator. I ran a sensitivity test using the `sensemakr` package in R. The result shows that "unobserved confounders (orthogonal to covariates) that do not explain more than **34.65%** of the residual variance of both the treatment and the outcome are not strong enough to reduce the absolute value of the effect size by 100%."

I suspect that philanthropic giving could be one of those unobserved confounders. It is very difficult to find systematic data on philanthropic giving, especially in a historical context. I collected the Ford Foundation grant data and found that Ford allocated grants selectively. Only a few Asian American and Latino CBOs received support from the Ford Foundation. Yet, as this evidence is only partial information of philanthropic giving, I suggest that one should take the above regression coefficient with a grain of salt.
