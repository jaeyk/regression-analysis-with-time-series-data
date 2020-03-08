# regression-analysis-with-time-series-data


**Regression analysis with time series data**

- Big data is a buzz word. However, still most of research projects are based on small and medium size data (less than 10 GB). Collecting, cleaning, and merging these small and meidum data takes serious efforts and care because they are usually unstructured and have widely different formats. Drawing a sound inference from them is also quite challenging as the data is small and noisy. I documented this project to demonstrate how we can tackle these small (in terms of size) and wide (in terms of formats) data and provide insights into the dynamics of policy and behavioral changes.

## Motivation

This project is part of my dissertation research. The main motivation of this project is to understand why Asian American and Latino community-based and advocacy organizations started to emerge in the 1960s and 1970s. Until the 1950s, Asian American and Latino communities were divided along national origin lines. Chinese, Japanese, and Filipino communities only minded their business. This is also true for the relationship between Mexicans, Cubans, and Puerto Ricans. However, in the 1960s and 1970s, these fragmented communities started to build organizations which represent their united voice. In my dissertation, I argued that this new trend emerged during this particulary time period because Asian American and Latino activists were in competition with their African American counterparts in the federal grants market. Uniting their group helped them to increase their visibility and, thus, draw support from the War on Poverty programs (e.g., Community Action Programs, Community Development Centers, Community Health Clinics, etc.).

- Check out [this Git repository](https://github.com/jaeyk/content-analysis-for-evaluating-ML-performances) to learn about my another dissertation chapter which leverages machine learning to study political opinion among minority groups in historical contexts.

## Research design

The importance of the War on Poverty on the community building efforts among Asian Americans and Latinos was mentioned by previous studies in sociology, history, and ethnic studies. However, the evidence for the argument mostly came from anecdotal examples. This study provides the first systematic evidence for the influence of the War on Poverty programs on Asian American and Latino civic mobilization in the 1960s and 1970s. To do so, I focused on the difference in the organizational founding between the War on Poverty and the post-Reagan period. If my resource-driven theory were plausible, I hypothesize that then president Reagan's reduction of the budgets for these community support programs should have decreased the founding rate of these community organizations in the post-Reagan period. This focus on the interruption in the time series data (interrupted time series design) helps us isolate the effect of the budget change from that of other concurrent factors, such as demographic change and political activism (Cook and Campbell 1979).

## Datasets

I have collectede a wide range of original data for this project.

1. Organizational data: An original dataset traces the founding of Asian American and Latino community-based and advocacy organizations over the last century. The dataset includes about 299 Asian American and 519 Latino advocacy and community-based organizations. Each observation includes the organization title, the founding year, the physical address, and whether they operate as a community-based, an advocacy or a hybrid (active in both types of work) organization. Source materials were mainly collected from the following four databases. I made the dataset publicly available at [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/FLUPBJ) and created a [dashbaord](https://rpubs.com/jaeyeonkim/581083) for easy data exploration.

2. Administrative data:
- Federal budget statistics: The federal budget data come from the Budget of the U.S. Government, the Fiscal year 2017 Historical Tables.
- Population statistics: Asian American and Latino population data come from the U.S. census.
- Party control: Party control of the presidency and Congress data come from [Russell D. Renka's website](http://cstl-cla.semo.edu/rdrenka/ui320-75/presandcongress.asp)

3. Foundation data: The Ford Foundation grants information comes from the catalog of the Rockefeller Archive Center

4. Community newspaper data:  The transcribed records of *The International Examiner* (1976 - 1987) are provided by the [Ethnic Newswatch database](https://www.proquest.com/products-services/ethnic_newswatch.html).

## Workflow

1. Data cleaning, wrangling, and merging
2. Descriptive data anlaysis
3. Statistical modeling of time series data (interrupted time series design)

## 1. Data cleaning, wrangling, and merging

The original organization dataset I collected contains founding year variable, but it is not time series data. Time series data, by definition, has a series of temporally varying observations. Founding year variable could miss some years if in these years none of the organizations on the dataset were founded. For this reason, filling these years in is important. The following code is my custom function to perform that task.

```{r}
org_to_ts <- function(data){

  # Create the year sequence

  all_years <- seq(min(data$F.year), max(data$F.year))

  # Turn it into a dataframe

  all_years <- data.frame(F.year = all_years)

  # Count by year and type

  data_year <- data %>%
    count(F.year, States, Type) %>%
    rename(Freq = n) %>%
    right_join(all_years, by = "F.year")

  # Replace NA Freq with 0s

  data_year$Freq[is.na(data_year$Freq)] <- 0

  # Replace NA Type with unique Type

  data_year$Type[is.na(data_year$Type)] <- unique(data_year$Type[!is.na(data_year$Type)])

  data_year
}
```

## 2. Descriptive data analysis [[Code](https://github.com/jaeyk/regression-analysis-with-time-series-data/blob/master/code/01_descriptive_analysis.Rmd)]

There is a reason why it is useful to plot time series data using both point and line plots but not bar plot. Point plot is useful to show which data points are missing. Line plot is useful to trace the overall trend. Bar plot is not useful because it does not care whether we have overlapping observations at a particular temporal point. In that case, bar plot just shows the sum of these numerical elements. Time series plot should match each temporal unit with each observation. Violation of this assumption is hard to be detected by bar plot.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/org_founding_year.png)

**Figure 1. Organizational trend**

Figure 1 shows that the founding rate (the slope of line plot) of community-based organizations (CBOs, those organizations that focus on providing social services) both in Asian American and Latino communities increased before the budget cut (red dashed line) and decreased after the budget cut. We cannot find a similar trend from advocacy organizations or hybrid organizations (organizations active both in advocacy and service delivery). This evidence is consistnet with the theory as CBOs are service-oriented, and thus most dependnet on the outside financial support than the other two types of organizations. However, the evidence is only suggestive as the change could also have been influenced by other factors and the data includes noises as well as signals.


## 3. Statistical modeling of time series data [[Code](https://github.com/jaeyk/regression-analysis-with-time-series-data/blob/master/code/03_ITS_design_analysis.Rmd)]

### 3.1. Checking on independent and dependent variables

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/reagan_budget_cut.png)

**Figure 2. Budget trend**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/dic_newspaper.png)

**Figure 3. Dictionary-based methods analysis**

Before moving into a more serious statistical analysis, I checked some assumptions I made about the research design. Figure 2 shows that percentage of the federal budget for education, employment, and social service plunged after the Reagan intervention. (It shows a slight decrease during the Carter administration, as he was forced to reduce the budget for social policy programs due to the budget constraint.) Reagan made the low budget priority for social policy programs more dramatic and consistent throughout the 1980s. A more specific analysis of the budget change showed that programs empowering minority communities, sucha as Comprehensive Employment Training Act, were critically hurt by the budget cut. I did not include a more detailed analysis of these policies for spatial constraints. This evidence is important to take the budget cut as a major intervention.

Figure 3 shows how minority community members reacted to the budget crisis. The *International Examiner* (IE), a community newspaper, circulated among Asian American activists in Seattle, did not mention Reagan until 1981. I created a custom dictionary and anlyzed the frequency of budget related terms appeared in Reagan related articles from this newspaper source. The figure shows that when the newspaper first mentioned Reagan, the budget crisis received serious attention. This evidence is crucial to take the year 1981 as a critical juncture for Asian American and Latino community organizers.

```{r}
# Text data
ie_processed <- ie_data[,-1] %>% # drop the first col
  ########################## Cleaning vars ##########################
  mutate(date = gsub(".*:", "", date) %>% str_trim(),
         date = gsub(",", "", date),
         date = as.Date(as.character(date), format = "%b%d%Y"),
         source = gsub(".*:", "", source) %>% str_trim(),
         author = gsub(".*:", "", author) %>% str_trim())

# Create a document term matrix based on a custom dictionary
ie_dic <- dfm(corpus(ie_processed),
              dictionary = dictionary(list(budget =
                                      c("spending","grants","grant","funding","funds","fund"))))
# Add to the original data
ie_processed$budget <- convert(ie_dic, to = "data.frame")[,2]
```

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/outliers_detected.png)

**Figure 4. Outlier detection**

Finally, I checked the presence of outliers (an observation with large residual). Outliers are particularily influential in the small data anlysis and, thus, they can change the results of a statistical analysis. I construed a multivariate regression model and detected DV values that are unsual given the predicted values of the model using Cook's distance (Cook's D). Cook's D is automatically calculated by the `ols_plot_cooksd_bar` function from the `olsrr` package. I then removed these outliers and imputed new values using k-nearest neighbors (KNN) algorithm.

```{r}
model <- lm(Freq ~ intervention + Percentage + pop_percentage + factor(category) + Type + presidency + senate + house, data = reagan_org)

ols_plot_cooksd_bar(model)
```

### 3.2. Interrupted time series design

Did the Reagan budget cut influence the founding rate of Asian American and Latino community-based and advocacy organizations? One difficulty to answer this question is that other factors also could have influenced the outcome. To account for these other factors, I built a multivariate statistical model. Also, we don't know which model would fit the data best. For that reason, I constructed various statistical models, fitted each of them to the data, and compared their model fit using Akaike information Criterion (AIC). Ordinary least square (OLS) regression model is a base model. OLS with logged depenednet variable fits for skewed data. Poisson model assumes that the residuals follow a Poisson, not a normal, distribution. It also models the natural log of the response variable. Negative binominal model is similar to poissson model except it does not assume that conditional means and conditional variances are equal.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/pred_plots.png)

**Figure 5. Interrupted time series design analysis**

Figure 5 shows how these different models fitted to the data. The blue line plot indicates the preicted values. The grey ribbons, around the line plot, display two standard errors, which are approximate to 95% confidence intervals. The impacts of the intervention could be detected in two ways in an interrupted time series design: level and slope. The level of the predicted values is almost identical between the pre- and post-intervention period. In contrast, the slope change is detected in the all four models.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/AIC_in_time.png)

**Figure 6. Model performance comparisons**

I then checked the performances of these four models using AIC. AIC score measures the difference between the model accuracy and complexity. Lower AIC score indicates a closer fit. However, checking AIC scores of these models at one point could be not sufficient for a comprehensive test. Another concern is these models perform differently depending on the period under investigation. Some models may fit for the short-term time period and others do better for the long-term period. To address this concern, I created a for loop function and checked how AIC scores of these four models vary as I extended the data from the year 1970 to 2017. Fogire 6 demonstrates that the ordinary least square model with logged dependent variable consistently outperforms OLS, poisson, and negative binominal models.

```{r}

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

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/boot_cis.png)

**Figure 7. Changes in coefficients with bootstrapped CIs**

From now on, I use the OLS with logged DV for the analysis. We saw the slope change. Given the research question, it is important to know to what extent the federal funding contributed to the slope change as opposed to other factors. To do so, I examine how the coefficient of federal funding changed as we extended the data from the year 1970 to 2017. For instance, the 1970 data is the subset of the original data which includes observations up to the year 1970. I created point plot using the for loop. The point plot in Figure 7 shows that the coefficients of the federal funding were positive up to the cutpoint. Then, they became almost zero after the cut point. An opposite trend was found from the changes in the coefficients of population growth. They were either negative or zero before the cutpoint. Then, they became positive in the 1980s and then became almost zero or negative again.

```{r}
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

I also added confidence intervals using bootstrapping. Bootstrapping is resampling wiht replacement. For each regression model at a time point, I resampleed the data and ran the same analysis for 1,000 times, and created confidence intervals based on the sampling variability of regression coefficients. This informatino shwos that the coefficient change around the cutpoint is statistically significant.

```{r}
boot_ci <- function(i){

# For reproducibility
set.seed(1234)

# Init vars
stat = data.frame()
result = data.frame()
year = data.frame()

# Model
m = Boot(lm(log(Freq) ~ Percentage + pop_percentage + category, data = subset(reagan_org, Year <= 1970 + i)), R = 1000)

# Extract bootSE
stat = rbind(stat, summary(m) %>% data.frame() %>% select(bootSE))

# Putting them together as a dataframe
Year = rep(c(1970 + i), nrow(stat))

Names = c("Intercept", "Fed_SE", "Pop_SE", "Latino_SE")

result = cbind(stat, Year, Names)

rownames(result) <- NULL

result}

cis <- data.frame()

for (i in c(1:38)){
  print(paste0(i, " iteration completed"))
  cis = rbind(cis, boot_ci(i))
}

colnames(cis)[1:2] <- c("SE", "Year")

cis_spread <- cis %>%
  spread(Names, SE) %>%
  select(-c(Intercept, Latino_SE))

boot_merged <- merge(cis_spread, for_loop)
```

### 3.3. Correct standard errors

So far, we have examined how the reduced treatment (reduced budget) influenced the DV. In this section, I focus on the first half of the previous analysis: the relationship between the increasing budget and the increasing organizational fouding rate. We saw that they are correlated but is the relationship statisticall significant? In Figure 7, we saw that the regression coefficients are all overzero. However, the confidence intervals are wide and close to zero. To check that, I ran the model with the subset of the data that included observations up to the year 1980. Then, I employed various methods to calculate corrrect standard errors.

- Heteroskedasticity: I ran studentized Breusch-Pagan test to check the presence of heteroskedasticity. The null hypothesis of the test is the the variance of residuals is constant (homoscedasticity). The p-vaue of the test result is 0.04. Thus, we reject the null hypothesis.
- Autocorrelation: Autocorrelation test (ACF) (Figure 8) shows the correlation between the time series and its lagged values. It appears none of the correlation coefficients are statistically significant. Thus, we worry about heteroskedasticity but not autocorrelation.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/acf_test.png)

**Figure 8. Autocorrelation test**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/se_table.png)

**Table 1. Standard errors corrected for heteroskedasticity and outliers**


### 3.4. Sensitivity analysis`

the absolute value of the effect size by 100 % at the significance level of alpha = 0.05 . Conversely, unobserved confounders that do not explain more than 10.34% of the residual variance of both the treatment and the outcome are not strong enough to reduce the absolute value of the effect size by 100% at the significance level of alpha = 0.05 .

An extreme confounder (orthogonal to the covariates) that explains 100% of the residual variance of the outcome, would need to explain at least 15.53% of the residual variance of the treatment to fully account for the observed estimated effect.

## 4. Conclusions

1.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/state_county_maps.png)

**Figure 9. US county map of Asian American and Latino community-based and advocacy organizations**
