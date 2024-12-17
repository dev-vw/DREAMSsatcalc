library(tidyverse)

# TODO (12/16/2024): once hivRutils gets cleaned up as a package, use the bundled
#                    functions in this script

# NOTE: create dreams_geographies first, then isolate the iso3 of the countries
# with dreams programming. Note that Naomi iso3 codes are slightly different
countries <- unique(dreams_geographies$iso3_naomi)

periods <- rep("2024-3", length(countries))
names(periods) <- countries
periods["MOZ"] <- "2024-4"

indicator <- "prevalence"
ages <- c("Y010_014", "Y015_019", "Y020_024", "Y025_029")
sex <- "female"

unaids_prev <- pull_hiv_df(periods, countries, ages, indicator, sex)
unaids_prev <- unaids_prev |> select(-c(lower, upper))
write_csv(unaids_prev, "data-raw/unaids_pull_12162024.csv")

# --- functions ----

# Countries: PEPFAR countries
# Areas: 0, 1, 2
# Sex: M
# Ages: 15-19; 20-24; 25-34; 35-49; 50-64; 65+
# Period: December 2022
# Indicators: Population; HIV prevalence; HIV incidence per 1000; New infections; PLHIV; Number PLHIV aware; Number Aware PLHIV (ART catchment); ART number (residents); ART number (attending)
# store a function that pulls and labels a data frame for a set of variable inputs



#' Title
#'
#' @param period
#' @param country
#' @param indicator
#' @param age
#' @param sex
#'
#' @importFrom dplyr mutate
#' @return
#' @export
#'
#' @examples
get_data_from_remote <- function(period, country, indicator, age, sex) {
  options(scipen = 999)

  url <- paste0("https://naomiviewerserver.azurewebsites.net/api/v1/data?country=",
                country,
                "&indicator=",
                indicator,
                "&ageGroup=",
                age,
                "&period=",
                period,
                "&sex=",
                sex,
                "&areaLevel=0&areaLevel=1&areaLevel=2&areaLevel=3")

  print(url)

  data_pull <- read.csv(as.character(url)) %>%
    mutate(country = country) %>%
    mutate(indicator = indicator) %>%
    mutate(age = age) %>%
    mutate(sex = sex)

  return(data_pull)
}

#' Title
#'
#' @param periods
#' @param countries_included
#' @param ages
#' @param indicators
#' @param sex
#'
#' @importFrom dplyr bind_rows
#' @return
#' @export
#'
#' @examples
pull_hiv_df <- function(periods, countries_included, ages, indicators, sex) {

  # set paramter value combinations
  params <- expand.grid(countries_included = countries_included,
                        indicators = indicators,
                        ages = ages,
                        sex = sex)

  # iteratively pull data using params
  data_lst <- apply(params, 1,
                    function(param_combo) {
                      period <- periods[param_combo[1]]
                      new_data <- get_data_from_remote(period,
                                                       param_combo[1],
                                                       param_combo[2],
                                                       param_combo[3],
                                                       param_combo[4])
                      print(new_data)
                    })

  # remove empty data frames
  data_lst <- Filter(function(df) dim(df)[1] > 0, data_lst)

  # bind the list of dfs
  all_data <- dplyr::bind_rows(data_lst)

  return(all_data)
}

#' Title
#'
#' @param df
#' @param iso3
#' @param adm_level
#'
#' @importFrom dplyr filter select
#' @importFrom tidyr pivot_wider
#'
#' @return
#' @export
#'
#' @examples
filter_data <- function(df, iso3, adm_level) {
  df <- dplyr::filter(df, country == iso3)
  df <- dplyr::filter(df, level == adm_level)

  df <- df %>% dplyr::select(-lower, -upper)
  df <- tidyr::pivot_wider(df, names_from = indicator, values_from = mean)
  df <- tidyr::pivot_wider(df,
                           names_from = sex,
                           values_from = c(prevalence, incidence, plhiv, art_coverage))

  return(df)
}

#' Title
#'
#' @param df
#' @param outname
#'
#' @importFrom readr write_csv
#'
#' @return
#' @export
#'
#' @examples
save_data <- function(df, outname) {
  readr::write_csv(df, paste0("output/hiv-data/"))
}

