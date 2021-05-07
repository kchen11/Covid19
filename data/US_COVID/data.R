# https://stackoverflow.com/questions/27969968/is-there-an-efficient-way-to-append-to-an-existing-csv-file-without-duplicates-i

url_link = "https://raw.githubusercontent.com/datasets/covid-19/main/data/"

us_confirmed_cases = str_c(
  url_link, "us_confirmed.csv", sep="")

us_death_cases = str_c(
  url_link, "us_deaths.csv", sep="")

if(file.exists('data/US_COVID/us_confirmed.csv') == TRUE) {
  us_confirmed <- data.table::fread(us_confirmed_cases, na = "NA", fill=TRUE)
  us_confirmed_df <- data.table::fread('data/US_COVID/us_confirmed.csv', na = "NA", fill=TRUE)
  
  all <- rbind(us_confirmed, us_confirmed_df) # rbind both data.frames
  
  NonDuplicate_1 <- all[!duplicated(all)&c(rep(FALSE, dim(us_confirmed)[1]), rep(TRUE, dim(us_confirmed_df)[1])), ]
  
  fwrite(NonDuplicate_1, "data/US_COVID/us_confirmed.csv", row.names = F, col.names = F, na = "NA", append = T)
  rm(all, NonDuplicate_1, us_confirmed)
}else{
  fwrite(fread(us_confirmed_cases, stringsAsFactors = F, header = T), 
         file = 'data/US_COVID/us_confirmed.csv', row.names = F, col.names = T, na = "NA")
  us_confirmed_df <- fread('data/US_COVID/us_confirmed.csv', stringsAsFactors = F, header = T)
}


if(file.exists('data/US_COVID/us_deaths.csv') == TRUE) {
  us_deaths <- data.table::fread(us_death_cases, na = "NA", fill=TRUE)
  us_deaths_df <- data.table::fread('data/US_COVID/us_deaths.csv', na = "NA", fill=TRUE)
  
  all <- rbind(us_deaths_df, us_deaths) # rbind both data.frames
  
  NonDuplicate_2 <- all[!duplicated(all)&c(rep(FALSE, dim(us_deaths)[1]), rep(TRUE, dim(us_deaths_df)[1])), ]
  fwrite(NonDuplicate_2, "data/US_COVID/us_deaths.csv", row.names = F, col.names = F, na = "NA", append = T)
  rm(all, NonDuplicate_2, us_deaths)
}else{
  fwrite(fread(us_death_cases, stringsAsFactors = F, header = T), 
         file = 'data/US_COVID/us_deaths.csv', row.names = F, col.names = T, na = "NA")
  us_deaths_df <- fread('data/US_COVID/us_deaths.csv', stringsAsFactors = F, header = T)
}

us_confirmed_df_1 <- us_confirmed_df %>%
  rename(County = "Admin2",
         Confirmed = 'Case')
rm(us_confirmed_df)

us_deaths_df_1 <- us_deaths_df %>%
  rename(County = "Admin2",
         Deaths = 'Case')
rm(us_deaths_df)

us_cases <- us_confirmed_df_1 %>%
  full_join(us_deaths_df_1)
rm(us_confirmed_df_1, us_deaths_df_1)