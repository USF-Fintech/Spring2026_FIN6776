library(tidyverse)
data(diamonds)
diamonds

housing <- data.frame(
  name = c("Amy")
)
str(housing)


iris |>
  select(Sepal.Length, Petal.Width, Species) |>
  head(3)


my_diamonds <- diamonds |>
  filter(
    carat > 0.23,
    carat < 0.5,
    cut == "Good"
  )

my_diamonds
diamonds


iris |>
  group_by(Species) |>
  summarize(mean_sepal = mean(Sepal.Length))


iris |>
  group_by(Species) |>
  summarize(across(everything(), mean))

cor(iris$Sepal.Length, iris$Petal.Length)


library(tidyquant)
tickers = c("MSFT", "TSLA", "AAPL", "BAC")
stock_prices = tq_get(tickers, from = '2020-01-01', to = '2023-12-31')

stock_prices
