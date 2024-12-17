# This is the data download from the IDB dashboard. Download that data prior to
# running the following processing script.

library(tidyverse)

idb <- read_csv("data-raw/_archive/idb_1year_agywpop_2024.csv",
                na = character()) # this option is to read NA as a string rather than the type


# change name of GENC to iso2
names(idb)[names(idb) == "GENC"] <- "iso2"

iso <- read_csv("data-raw/dreams_iso.csv", na = character())
keys <- iso |> select(iso3, iso2)

# add iso3 column
idb <- left_join(idb, keys, by = "iso2")

write_csv(idb, "data-raw/idb_1year_agywpop_2024.csv")
