library(tidyverse)

dreams_iso <- read_csv("data-raw/dreams_iso.csv", na = character())

usethis::use_data(dreams_iso, overwrite = TRUE)
