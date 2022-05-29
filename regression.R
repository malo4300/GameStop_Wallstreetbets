#----Librarys
library(tidyverse)


#---- group all data


gme_sap = read_csv(file = "Data/Stock_Data.csv")
sentiment = read_csv(file = "Data/sentiment_frame_no_lag_first_quarter.csv")
sentiment = sentiment %>% select(-Date)
sentiment = sentiment[,-1]

full_data = inner_join(gme_sap, sentiment, by = c ("Date" = "day_to_pred"))

full_data = full_data %>% select(-c(Close.x, lag, Close.y, lag1, lag2,lag3))


#---- Regression

lm_reg = lm(formula = gme_change~mean +sum_com + sum_com * mean, data = full_data)

lm_reg_controlls = lm(formula = gme_change~mean +sum_com + mean*sum_com + sp_change  +lag(sp_change,1) + lag(sp_change, 2) + lag(sp_change, 3), 
            data = full_data)
subset_data = full_data %>% filter(sum_com < 10000)
lm_reg_subset = lm(formula = gme_change~mean +sum_com+ sum_com * mean, data = subset_data)
summary(lm_reg_subset)

ggplot(data = full_data ) + 
  geom_point(mapping = aes(x=sum_com, y = gme_change)) +
  xlim(0,10000)

up_down_data = full_data %>% mutate(gme_dummy = gme_change>0)

dummy_reg = lm(gme_dummy ~ sp_change, data = up_down_data)
summary(dummy_reg)

