# Clean up data/nu_faculty_raw.csv to be easier to work with

# data source: https://www.adminplan.northwestern.edu/ir/data-book/v54/8.01-full-time-and-tenure-line-faculty.pdf

library(tidyverse)

# read_csv handles the year column names better than read.csv by default

x <- read_csv("data/nu_faculty_raw.csv")

x <- rename(x, school=SCHOOL)  # don't want to have to type capitals

x <- pivot_longer(x, -school, names_to="year", values_to="faculty")

write_csv(x, "data/nu_faculty_long.csv")


# data source: https://www.adminplan.northwestern.edu/ir/data-book/v54/8.08-tenured-faculty.pdf

y <- read_csv("data/nu_tenured_raw.csv")

y <- rename(y, school=School)

y <- pivot_longer(y, -school, names_to="year", values_to="tenured")

y <- x %>%
  left_join(y, by=c("school", "year")) 

write_csv(y, "data/nu_all_fac.csv")



