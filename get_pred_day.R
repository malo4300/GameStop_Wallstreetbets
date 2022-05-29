library(tidyverse)

sentiment_frame = read_csv("Data/gme_date_discrete_first_quarter.csv")

sentiment_frame = sentiment_frame[,-1]

sentiment_frame = sentiment_frame %>% mutate(week_day = weekdays((Date)))

week_day_add = rep(0,nrow(sentiment_frame))
week_day_add[sentiment_frame$week_day == "Sonntag"] = 2
week_day_add[sentiment_frame$week_day == "Samstag"] = 3
week_day_add[sentiment_frame$week_day == "Freitag"] = 3
week_day_add[sentiment_frame$week_day == "Donnerstag"] = 1


sentiment_frame = sentiment_frame %>% mutate(week_day_add = week_day_add)

sentiment_frame = sentiment_frame %>% mutate(day_to_pred = Date + week_day_add)

write.csv(sentiment_frame, "Data/sentiment_frame_one_lag_first_quarter.csv")
