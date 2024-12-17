# this script combines dreams_iso3.csv and pepfar_countries.csv
# to create dreams_iso.csv

library(tidyverse)
iso3 <- read_csv("data-raw/_archive/dreams_iso3.csv")

pepfar_countries <- read_csv("data-raw/_preprocessing/_raw/pepfar_countries.csv",
                             na = character()) # this option is to read NA as a string rather than the type

iso2 <- pepfar_countries |> select(ISO_alpha_2, ISO_alpha_3)

iso <- left_join(iso3, iso2, c("iso3" = "ISO_alpha_3")) |> rename(iso2 = ISO_alpha_2)

write_csv(iso, "data-raw/dreams_iso.csv")
