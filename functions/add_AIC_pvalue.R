
library(broom)

add_AIC_pvalue <- function(model){
  
  # Add AIC
  model$AIC <- AIC(model)
  
  # Add p.value 
  model$p.value <- broom::tidy(lm_log.out2)$p.value %>% as.numeric()
  
  model 
  
}

add_AIC <- function(model){
  
  # Add AIC
  model$AIC <- AIC(model)
  
  model 
  
}