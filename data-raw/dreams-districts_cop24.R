# generates "dreams_geographies" in data/

library(tidyverse)

iso <- read_csv("data-raw/dreams_iso.csv",
                na = character())
dreams_geographies <- read_csv("data-raw/dreams-districts_cop24.csv")

# add iso3 and iso2 to dreams_geos
dreams_geographies <- left_join(dreams_geographies, iso, by = c("ou" = "country"))

# add naomi iso3 to dreams_geos. In Naomi, SWZ is ESW
dreams_geographies$iso3_naomi <- dreams_geographies$iso3
dreams_geographies$iso3_naomi[dreams_geographies$iso3 == "SWZ"] <- "ESW"

usethis::use_data(dreams_geographies, overwrite = TRUE)
