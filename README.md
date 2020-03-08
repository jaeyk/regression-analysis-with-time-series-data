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

## 2. Descriptive data analysis

**Figure 1**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/org_founding_year.png)

**Figure 2**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/reagan_budget_cut.png)

**Figure 3**

## 3. Statistical modeling of time series data (interrupted time series design)

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/dic_newspaper.png)

**Figure 4**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/outliers_detected.png)

**Figure 5**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/pred_plots.png)

**Figure 6**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/AIC_in_time.png)

**Figure 7**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/boot_cis.png)

**Figure 8**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/acf_test.png)


## Conclusions

1.

**Figure 9**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/state_county_maps.png)
