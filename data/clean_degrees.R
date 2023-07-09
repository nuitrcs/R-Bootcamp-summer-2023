# Clean Degrees Data
library(tidyverse)


# Make total degrees time series

bac <- read_csv("data/bachelors_raw.csv") %>% 
  pivot_longer(-1:-4, names_to="year", values_to="bachelors") 
masters <- read_csv("data/masters_raw.csv") %>% 
  pivot_longer(-1:-4, names_to="year", values_to="masters")
doc <- read_csv("data/doctorates_raw.csv") %>% 
  pivot_longer(-1:-4, names_to="year", values_to="doctorates")

filter(bac, level=="total") %>%
  select(year:last_col()) %>%
  left_join(filter(masters, level=="total") %>%
              select(year:last_col())) %>%
  left_join(filter(doc, level=="total") %>%
              select(year:last_col())) %>%
  write_csv("data/nu_degrees.csv")
