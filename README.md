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

1. Organizational data: An original dataset traces the founding of Asian American and Latino community-based and advocacy organizations over the last century. The dataset includes about 299 Asian American and 519 Latino advocacy and community-based organizations. Each observation includes the organization title, the founding year, the physical address, and whether they operate as a community-based, an advocacy or a hybrid (active in both types of work) organization. Source materials were mainly collected from the following four databases. I made the dataset publicly available at [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/FLUPBJ).

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

I also created a [dashboard](https://rpubs.com/jaeyeonkim/581083) based on the organizational data for those interested in examining the data by themselves.

## 2. Descriptive data analysis [[Code](https://github.com/jaeyk/regression-analysis-with-time-series-data/blob/master/code/01_descriptive_analysis.Rmd)]

There is a reason why it is useful to plot time series data using both point and line plots but not bar plot. Point plot is useful to show which data points are missing. Line plot is useful to trace the overall trend. Bar plot is not useful because it does not care whether we have overlapping observations at a particular temporal point. In that case, bar plot just shows the sum of these numerical elements. Time series plot should match each temporal unit with each observation. Violation of this assumption is hard to be detected by bar plot.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/org_founding_year.png)

**Figure 1. Organizational trend**

Figure 1 shows that the founding rate (the slope of line plot) of community-based organizations (CBOs, those organizations that focus on providing social services) both in Asian American and Latino communities increased before the budget cut (red dashed line) and decreased after the budget cut. We cannot find a similar trend from advocacy organizations or hybrid organizations (organizations active both in advocacy and service delivery). This evidence is consistnet with the theory as CBOs are most dependnet on the outside financial support than the other two types of organizations. However, the evidence is only suggestive as the change could also have been influenced by other factors and the data includes noises as well as signals.


## 3. Statistical modeling of time series data [[Code](https://github.com/jaeyk/regression-analysis-with-time-series-data/blob/master/code/03_ITS_design_analysis.Rmd)]

### 3.1. Checking on independent and dependent variables

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/reagan_budget_cut.png)

**Figure 2. Budget trend**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/dic_newspaper.png)

**Figure 3. Dictionary-based methods analysis**

Before moving into a more serious statistical analysis, I checked some assumptions I made about the research design. Figure 2 shows that percentage of the federal budget for education, employment, and social service seriously decreased after the Reagan intervention. It showed a slightl decrease during the Carter administration due to the budget constraint. Reagan made the low budget priority for social programs consistent throughout the 1980s and which continued even in the 1990s. A more specific analysis of the budget change showed that programs empowering minority communities were critically hurt by the budget cut. I did not include a more detailed analysis here for spatial constraints. This evidence is important to take the budget cut as a major intervention.

Figure 3 shows how minority community members reacted to the budget crisis. The *International Examiner* (IE), a community newspaper, circulated among Asian American activists in Seattle did not mention Reagan until 1981. I created a custom dictionary and anlyzed the frequency of budget related terms appeared in Reagan related articles from this newspaper source. The figure shows that when the newspaper first mentioned Reagan, the budget crisis received serious attention. This evidence is crucial to take the year 1981 as a critical juncture for Asian American and Latino community organizers.

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


![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/pred_plots.png)

**Figure 5. Interrupted time series design analysis**

```{r}
ols_its <- function(input){

  # Apply model

  model <- lm(Freq ~ intervention + Percentage + pop_percentage + category + Type + presidency + senate + house,
               data = input)

  # Make predictions

  input$pred <- predict(model, type = "response", input)

  # Create confidence intervals

  ilink <- family(model)$linkinv # Extracting the inverse link from parameter objects

  # Combined prediction outputs

  input <-predict(model, input, se.fit = TRUE)[1:2] %>%
    bind_cols(input) %>%
    mutate(
      upr = ilink(fit + (2 * se.fit)),
      lwr = ilink(fit - (2 * se.fit)))

  # Visualize the outcome

  input %>%
    ggplot(aes(x = Year, y = Freq)) +
    geom_point(alpha = 0.2) +
    geom_line(aes(y = pred), size = 1, col = "blue") +
    geom_vline(xintercept = c(1980), linetype = "dashed", size = 1, color = "red") +
    labs(x = "Year",
         y = "Organizational founding") +
    geom_ribbon(aes(ymin = lwr, ymax = upr),
                alpha = 0.3) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))  +
  #  facet_grid(category~Type) +
    scale_y_continuous(breaks = scales::pretty_breaks())
}
```

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/AIC_in_time.png)

**Figure 6. Model performance comparisons**

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

```{r}
boot_ci <- function(i){

# For reproducibility
set.seed(1234)

# Init vars
stat = data.frame()
result = data.frame()
year = data.frame()

# Model
m = Boot(lm(log(Freq) ~ Percentage + pop_percentage + category, data = subset(reagan_org, Year <= 1970 + i)), R = 500)

# Extract bootSE
stat = rbind(stat, summary(m) %>% data.frame() %>% select(bootSE))

# Putting them together as a dataframe
Year = rep(c(1970 + i), nrow(stat))

Names = c("Intercept", "Fed_SE", "Pop_SE", "Latino_SE")

result = cbind(stat, Year, Names)

rownames(result) <- NULL

result}
```

### 3.3. Correct standard errors

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/acf_test.png)

**Figure 8. Autocorrelation test**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/se_table.png)

**Figure 9. Standard errors corrected for heteroskedasticity and outliers**


### 3.4. Sensitivity analysis`

the absolute value of the effect size by 100 % at the significance level of alpha = 0.05 . Conversely, unobserved confounders that do not explain more than 10.34% of the residual variance of both the treatment and the outcome are not strong enough to reduce the absolute value of the effect size by 100% at the significance level of alpha = 0.05 .

An extreme confounder (orthogonal to the covariates) that explains 100% of the residual variance of the outcome, would need to explain at least 15.53% of the residual variance of the treatment to fully account for the observed estimated effect.

## 4. Conclusions

1.

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/state_county_maps.png)

**Figure 10. US county map of Asian American and Latino community-based and advocacy organizations**
