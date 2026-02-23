library(tidyverse)
iris
getwd()
write_csv(iris, "iris_csv.csv")

my_iris <- read_csv("iris_csv.csv")
my_iris


url <- "https://raw.githubusercontent.com/mwaskom/seaborn-data/master/mpg.csv"

print(url)

test_df <- read_csv(url)
test_df
test_df |> head()


readxl::read_excel()

exxon_statements <- read_excel(
  "data/financial-statements-exxon-mobil.xlsx",
  sheet = 1,
  skip = 1
)


exxon_statements <- exxon_statements |>
  janitor::clean_names()

names(exxon_statements)
