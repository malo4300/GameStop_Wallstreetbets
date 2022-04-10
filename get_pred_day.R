library(tidyverse)

sentiment_frame = read_csv("gme_date_discrete.csv")

sentiment_frame = sentiment_frame[,-1]

sentiment_frame = sentiment_frame %>% mutate(week_day = weekdays((Date)))

week_day_add = rep(0,nrow(sentiment_frame))
week_day_add[sentiment_frame$week_day == "Sonntag"] = 1
week_day_add[sentiment_frame$week_day == "Samstag"] = 2
week_day_add[sentiment_frame$week_day == "Freitag"] = 0
week_day_add[sentiment_frame$week_day == "Donnerstag"] = 0


sentiment_frame = sentiment_frame %>% mutate(week_day_add = week_day_add)

sentiment_frame = sentiment_frame %>% mutate(day_to_pred = Date + week_day_add)

write.csv(sentiment_frame, "sentiment_frame_no_lag.csv")
