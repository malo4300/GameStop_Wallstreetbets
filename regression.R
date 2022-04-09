#----Librarys
library(tidyverse)


#---- group all data


gme_sap = read_csv(file = "Stock_Data.csv")
sentiment = read_csv(file = "sentiment_frame.csv")
sentiment = sentiment %>% select(-Date)
sentiment = sentiment[,-1]

full_data = inner_join(gme_sap, sentiment, by = c ("Date" = "day_to_pred"))

full_data = full_data %>% select(-c(Close.x, lag, Close.y, lag1, lag2,lag3))


#---- Regression
lm_reg = lm(formula = gme_change~mean +sum_com + mean*sum_com, data = full_data)

lm_reg_controlls = lm(formula = gme_change~mean +sum_com + mean*sum_com + sp_change  +lag(sp_change,1) + lag(sp_change, 2) + lag(sp_change, 3), 
            data = full_data)

summary(lm_reg)

ggplot(data = full_data) + geom_point(mapping = aes(x=mean, y = gme_change))
