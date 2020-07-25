
library(broom)

add_AIC_pvalue <- function(model){
  
  # Add AIC
  model$AIC <- AIC(model)
  
  # Add p.value 
  model$p.value <- broom::tidy(model)$p.value %>% as.numeric()
  
  model 
  
}


add_df <- function(model){
  
  # Add AIC
  model$df <- df.residual(model)
  
  model 
  
}
add_AIC <- function(model){
  
  # Add AIC
  model$AIC <- AIC(model)
  
  model 
  
}