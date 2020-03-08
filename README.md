# analyzing-latino-asian-civic-infrastructure
Analyzing Asian American and Latino Advocacy and Community-based organizations


- The goal of this article is to document how I have developed this machine learning + causal inference project from end to end. I intend to share my successes and failures from the project and what I learned along the journey. What was really challenging about this project was that I needed to apply a wide range of skills (e.g., parsing HTML pages, sampling, classifying texts, and inferring causality in time series data) at the different stages. But, that's also what made working on the project so fun! 
- Many people helped me to push this project forward. [Andrew Thompson](https://sites.northwestern.edu/athompson/) (Northwestern and MIT) was essential in getting the project started in summer 2019. He's also a co-author of the paper based on this project. We plan to present the findings at the upcoming Western Political Science Association annual meeting (we would love to see you there and hear your feedback). My three amazing Berkeley undergraduate RAs---[Carlos Ortiz](https://www.linkedin.com/in/carlosortizdev/), [Sarah Santiago](https://www.linkedin.com/in/sarah-santiago-7a297b18a/), and [Vivek Datta](https://www.linkedin.com/in/vivek-datta/)---made it possible to complete most of the data analysis in fall 2019. 
- I will keep this Git repository and the article updated as I make progress. Any comments or questions on the project are warmly welcomed. 

## Motivation

As Andrew Ng said, [artificial intelligence, especially machine learning, is the new electricity](https://www.youtube.com/watch?v=21EiKfQYZXc). Yet, compared to the industry, the impact of machine learning has been relatively marginal in the social sciences. One reason for this is that most machine learning applications focus on prediction tools and have little to do with explaining the causal relationship between two variables, X and Y (causal inference). However, these relationships are what many social scientists deeply care about, as they are useful for making sound recommendations for policy or behavioral changes. In this context, I co-developed this project with Andrew Thompson to demonstrate **how machine learning can help create critical data for causal inference**. We hope that this project draws more social scientists to machine learning and AI.

**Figure 1**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/asian_latino_orgs_n.png)

**Figure 1**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/asian_latino_orgs_n.png)

**Figure 2**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/org_founding_year.png.png)

**Figure 3**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/state_county_maps.png)

**Figure 4**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/reagan_budget_cut.png)

**Figure 5**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/dic_newspaper.png)

**Figure 6**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/outliers_detected.png)

**Figure 7**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/ols_plots.png)

**Figure 8**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/non_ols_plots.png)

**Figure 9**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/AIC_in_time.png)

**Figure 10**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/boot_cis.png)

**Figure 11**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/acf_test.png)

**Figure 12**

![](https://github.com/jaeyk/analyzing-asian-american-latino-civic-infrastructure/blob/master/outputs/AIC_in_time.png)

## Conclusions 

1.