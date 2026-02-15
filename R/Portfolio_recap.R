library(tidyverse)
library(tidyquant)
stock_prices <- tq_get(
  c('TSLA', 'BAC', 'XOM'),
  from = '2020-01-01',
  to = '2023-12-31'
)


stock_prices <- stock_prices |>
  select(symbol, date, adjusted)

stock_prices |> head()

stock_returns <- stock_prices |>
  arrange(symbol, date) |>
  group_by(symbol) |>
  mutate(
    daily_return = adjusted / lag(adjusted) - 1,
  ) |>
  select(symbol, date, daily_return)


stock_returns <- stock_returns |> drop_na()

stock_returns

returns_wide <- stock_returns |>
  pivot_wider(names_from = symbol, values_from = daily_return) |>
  drop_na()

returns_wide |> head()


# Generating portfolio returns and
# calculating standard deviation of historic returns
weights <- c(0.2, 0.3, 0.5)

returns_wide <- returns_wide |>
  rowwise() |>
  mutate(port_ret = sum(c_across(!date) * weights)) |>
  ungroup()

returns_wide |> head()
