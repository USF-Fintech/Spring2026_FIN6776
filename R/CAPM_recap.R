library(tidyverse)
library(tidyquant)

tickers <- c("MSFT")
stock_prices <- tq_get(tickers, from = '2020-01-01', to = '2023-12-31')

snp500 <- tq_get(
  "SP500",
  get = "economic.data",
  from = "2020-01-01",
  to = "2023-12-31"
)

snp500 <- snp500 |> rename(adjusted = price) # rename column for binding


prices <- bind_rows(stock_prices, snp500)
prices |> glimpse()

price_wide = prices |>
  pivot_wider(names_from = symbol, values_from = adjusted, id_cols = date)
price_wide |> head()

returns_wide <- price_wide |>
  mutate(across(-date, \(x) {
    (x / lag(x)) - 1
  }))
returns_wide


risk_free_data = tq_get(
  "DGS3MO",
  get = "economic.data",
  from = "2020-01-01",
  to = "2023-12-31"
)
risk_free_data

risk_free_converted <- risk_free_data |>
  mutate(rf = (price / 252) / 100)

risk_free_converted


risk_free_converted <- risk_free_converted |>
  pivot_wider(id_cols = date, names_from = symbol, values_from = rf)


risk_free_converted

capm_data <- returns_wide |>
  left_join(risk_free_converted, by = "date")
capm_data


capm_data <- capm_data |>
  mutate(
    date,
    MSFT_exret = MSFT - DGS3MO,
    Mkt_exret = SP500 - DGS3MO
  )

capm_data

capm_fit <- lm(MSFT_exret ~ Mkt_exret, capm_data)
print(capm_fit)
