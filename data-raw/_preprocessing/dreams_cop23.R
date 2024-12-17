library(readxl)

dreams_countries_23 <- read_xlsx("data-raw/_archive/dreams_cop23.xlsx")
names(dreams_countries_23) <- c("ou_uid", "dsnu", "ou", "snu1")

# these are actually the dreams countries and dsnu list for cop 24 as well
write_csv(dreams_countries_23, "data-raw/dreams-districts_cop24.csv")
