library(tidyverse)

data = read_csv("Data/pushshift_first_quarter.csv")

data$created_utc = as.Date(as.POSIXct(data$created_utc, origin="1970-01-01"))

data = select(data, -c(d_,created))

ggplot(data = data, mapping = aes(x=created_utc, y = num_comments))+
  geom_point()



data = data[str_detect(data$url, "comments"),] #urls without "comment" are pictures, memes or videos
data = data %>% filter(data$num_comments > 2) #post with less comments are either deleted, irrelevant or bots

dim(data)
Anzahl_Kommentare = sum(data$num_comments)
write.csv(data, "Data/pushshift_clean_first_quarter.csv")


ggplot(data = data) + 
  geom_histogram(mapping = aes(x = num_comments), bins = 10,color="black", fill="white") + 
  labs(x = "Anzahl Kommentare", y = "Anzahl", title = "Anzahl Kommentare")


ggplot(data = data, mapping = aes(x = created_utc, y = num_comments, col = score)) + 
  geom_point(size = 1) +
  scale_color_gradient(low = "red", high ="blue")
