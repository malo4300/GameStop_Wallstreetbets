library(tidyverse)
library(lubridate)
####### GME Change--------- 
gme = read_csv(file = "Data/GME_2021.csv")
gme = gme %>% select(Date,Close) %>% mutate(lag = lag(Close,1))

gme = gme %>% mutate(gme_change = ((Close-lag)/lag))


##### S&P Change und lags-----------

s_and_p = read_csv(file="Data/S&P_500_2021.csv")
s_and_p$Date = as.Date(date_temp, tryFormats = c("%m/%d/%Y"))

s_and_p  = s_and_p %>% select(Date,Close) %>% mutate(lag1 = lag(Close,1), lag2 = lag(Close,2), lag3 = lag(Close,3))
s_and_p = s_and_p %>% mutate(sp_change = ((Close-lag1)/lag1))
view(s_and_p)

stock_data = inner_join(gme,s_and_p, by = c("Date"))
view(stock_data)
write_csv(stock_data, "Data/Stock_Data.csv")

s_and_p$Date[1] + 1
