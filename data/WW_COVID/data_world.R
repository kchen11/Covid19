url_link = "https://raw.githubusercontent.com/datasets/covid-19/main/data/"

global_agg = str_c(
  url_link, "worldwide-aggregate.csv", sep="")

countries_aggregate = str_c(
  url_link, "countries-aggregated.csv", sep="")

global_aggregate <- fread(global_agg, stringsAsFactors = F, header = T)
countries_aggregated <- fread(countries_aggregate, stringsAsFactors = F, header = T)

global_aggregate$Date <- as.Date(global_aggregate$Date)

global_aggregate <- global_aggregate %>%
  rename(Increase_rate = `Increase rate`)

maxdate <- max(global_aggregate$Date)
