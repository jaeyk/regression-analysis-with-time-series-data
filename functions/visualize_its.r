
ols_its <- function(input) {

  # Apply model

  model <- lm(Freq ~ Year + intervention + Year * intervention + category + Type, #+ Percentage + pop_percentage + presidency + senate + house, 
    data = input
  )

  # Make predictions

  input$pred <- predict(model, type = "response", input)

  # Create confidence intervals

  ilink <- family(model)$linkinv # Extracting the inverse link from parameter objects

  # Combined prediction outputs

  input <- predict(model, input, se.fit = TRUE)[1:2] %>%
    bind_cols(input) %>%
    mutate(
      upr = ilink(fit + (2 * se.fit)),
      lwr = ilink(fit - (2 * se.fit))
    )

  # Visualize the outcome

  input %>%
    ggplot(aes(x = Year, y = Freq)) +
    geom_point(alpha = 0.2) +
    geom_line(aes(y = pred), size = 1, col = "blue") +
    geom_vline(xintercept = c(1980), linetype = "dashed", size = 1, color = "red") +
    labs(
      x = "Year",
      y = "Organizational founding"
    ) +
    geom_ribbon(aes(ymin = lwr, ymax = upr),
      alpha = 0.4
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    #  facet_grid(category~Type) +
    scale_y_continuous(breaks = scales::pretty_breaks())
}

ols_its_only_cbo <- function(input) {

  # Apply model

  model <- lm(Freq ~ Year + intervention + Year * intervention + category, #+ Percentage + pop_percentage + presidency + senate + house, 
    data = input
  )

  # Make predictions

  input$pred <- predict(model, type = "response", input)

  # Create confidence intervals

  ilink <- family(model)$linkinv # Extracting the inverse link from parameter objects

  # Combined prediction outputs

  input <- predict(model, input, se.fit = TRUE)[1:2] %>%
    bind_cols(input) %>%
    mutate(
      upr = ilink(fit + (2 * se.fit)),
      lwr = ilink(fit - (2 * se.fit))
    )

  # Visualize the outcome

  input %>%
    ggplot(aes(x = Year, y = Freq)) +
    geom_point(alpha = 0.2) +
    geom_line(aes(y = pred), size = 1, col = "blue") +
    geom_vline(xintercept = c(1980), linetype = "dashed", size = 1, color = "red") +
    labs(
      x = "Year",
      y = "Organizational founding"
    ) +
    geom_ribbon(aes(ymin = lwr, ymax = upr),
      alpha = 0.4
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    #  facet_grid(category~Type) +
    scale_y_continuous(breaks = scales::pretty_breaks())
}

ps_its <- function(input) {

  # Apply poisson

  model <- glm(Freq ~ Year + intervention + Year * intervention + category + Type, #+ Percentage + pop_percentage + presidency + senate + house, 
    data = input, family = "poisson"
  )

  # Make predictions

  input$pred <- predict(model, type = "response", input)

  # Create confidence intervals

  ilink <- family(model)$linkinv # Extracting the inverse link from parameter objects

  # Combined prediction outputs

  input <- predict(model, input, se.fit = TRUE)[1:2] %>%
    bind_cols(input) %>%
    mutate(
      upr = ilink(fit + (2 * se.fit)),
      lwr = ilink(fit - (2 * se.fit))
    )

  # Visualize the outcome

  input %>%
    ggplot(aes(x = Year, y = Freq)) +
    geom_point(alpha = 0.2) +
    geom_line(aes(y = pred), size = 1, col = "blue") +
    geom_vline(xintercept = c(1980), linetype = "dashed", size = 1, color = "red") +
    labs(
      x = "Year",
      y = "Organizational founding"
    ) +
    geom_ribbon(aes(ymin = lwr, ymax = upr),
      alpha = 0.4
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    #  facet_grid(category~Type) +
    scale_y_continuous(breaks = scales::pretty_breaks())
}

nb_its <- function(input) {

  # Apply model

  model <- glm.nb(Freq ~ Year + intervention + Year * intervention + category + Type, #+ Percentage + pop_percentage + presidency + senate + house, 
    data = input
  )

  # Make predictions

  input$pred <- predict(model, type = "response", input)

  # Create confidence intervals

  ilink <- family(model)$linkinv # Extracting the inverse link from parameter objects

  # Combined prediction outputs

  input <- predict(model, input, se.fit = TRUE)[1:2] %>%
    bind_cols(input) %>%
    mutate(
      upr = ilink(fit + (2 * se.fit)),
      lwr = ilink(fit - (2 * se.fit))
    )

  # Visualize the outcome

  input %>%
    ggplot(aes(x = Year, y = Freq)) +
    geom_point(alpha = 0.2) +
    geom_line(aes(y = pred), size = 1, col = "blue") +
    geom_vline(xintercept = c(1980), linetype = "dashed", size = 1, color = "red") +
    labs(
      x = "Year",
      y = "Organizational founding"
    ) +
    geom_ribbon(aes(ymin = lwr, ymax = upr),
      alpha = 0.4
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    #  facet_grid(category~Type) +
    scale_y_continuous(breaks = scales::pretty_breaks())
}

zerofinl_its <- function(input) {

  # Apply model

  model <- zeroinfl(Freq ~ Year + intervention + Year * intervention + category + Type |
    Year + intervention + Year * intervention + category + Type,
  dist = "negbin",
  data = input
  )

  # Make predictions

  input$pred <- predict(model, type = "response", input)

  # Create confidence intervals

  ilink <- family(model)$linkinv # Extracting the inverse link from parameter objects

  # Combined prediction outputs

  input <- predict(model, input, se.fit = TRUE)[1:2] %>%
    bind_cols(input) %>%
    mutate(
      upr = ilink(fit + (2 * se.fit)),
      lwr = ilink(fit - (2 * se.fit))
    )

  # Visualize the outcome

  input %>%
    ggplot(aes(x = Year, y = Freq)) +
    geom_point(alpha = 0.2) +
    geom_line(aes(y = pred), size = 1, col = "blue") +
    geom_vline(xintercept = c(1980), linetype = "dashed", size = 1, color = "red") +
    labs(
      x = "Year",
      y = "Organizational founding"
    ) +
    geom_ribbon(aes(ymin = lwr, ymax = upr),
      alpha = 0.4
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    #  facet_grid(category~Type) +
    scale_y_continuous(breaks = scales::pretty_breaks())
}
