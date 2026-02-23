library(tidyverse)
modified_exxon <- read_csv(
  "https://raw.githubusercontent.com/matthewgson/public_data/refs/heads/main/data/modified_exxon.csv"
)
modified_exxon |>
  distinct(Category)

modified_exxon

modified_exxon |>
  ggplot(aes(x = Category)) +
  geom_bar()


# Summarize the data

summary_exxon <- modified_exxon |>
  group_by(Category) |>
  summarize(Sum_USD = sum(M_USD, na.rm = TRUE))

summary_exxon |>
  ggplot(aes(x = fct_reorder(Category, -Sum_USD), y = Sum_USD)) +
  geom_col(fill = "lightblue", color = "black") +
  scale_y_continuous(
    n.breaks = 6,
    labels = scales::label_currency(prefix = "$", scale = 0.001, suffix = "T")
  ) +
  labs(
    title = "Exxon Mobile Total Revenue / Expenditure",
    subtitle = "From Years 2009 - 2018",
    x = "",
    y = "Total Revenue / Expenditure ($)",
    caption = "Source: Exxon Financial Statements"
  ) +
  theme_bw()

library(tidyquant)

stock_returns <- tq_get(
  c("AAPL", "KO"),
  from = "2020-01-01",
  to = "2023-12-31"
) |>
  group_by(symbol) |>
  arrange(symbol, date) |>
  mutate(pct_ret = (adjusted / lag(adjusted) - 1) * 100) |>
  ungroup() |>
  select(symbol, date, pct_ret)

stock_returns
