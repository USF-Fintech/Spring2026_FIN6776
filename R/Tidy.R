library(tidyverse)
table1
table2
table3


?num_range

?pivot_longer

# For pivot longer: "name" is the pivotal
# For pivot wider: both "name" and "values" should be specified.

billboard |>
  pivot_longer(starts_with("wk"))


population
