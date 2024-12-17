library(tidyverse)

# dreams_geographies is a bundled df with this package.
# It needs to be defined and documented prior to running this script
pepfar_snu1 <- dreams_geographies |>
  group_by(ou, snu1, dsnu) |>
  select(ou, snu1, dsnu) |>
  arrange(ou)

naomi_datapull <- read_csv("data-raw/unaids_pull_12162024.csv")
naomi_datapull |>
  pivot_wider(names_prefix = "level_",
              names_from = "level",
              values_from = "area")

naomi_snu1_snu2 <-
  naomi_datapull |>
  filter(level %in% c(1, 2)) |>
  group_by(country, area) |>
  arrange(country, area)


# which of pepfar_snu1 are in naomi_snu1?
absent_countries <- data.frame(
  country = pepfar_snu1$ou,
  pepfar_snu1 = pepfar_snu1$snu1,
  in_naomi = pepfar_snu1$snu1 %in% naomi_snu1_snu2$area) |>
  filter(in_naomi == FALSE) |>
  pull(country) |>
  unique()

absent_iso <- dreams_iso$iso3[dreams_iso$country %in% absent_countries]

naomi_snu1_snu2 |> filter(country %in% absent_iso) |> View()

# Calculate a distance matrix
dist_matrix <- stringdistmatrix(names_to_match, reference_names, method = "osa")

# Find the index of the closest match for each name
closest_match_index <- apply(dist_matrix, 1, which.min)

# Return the matched names
reference_names[closest_match_index]
