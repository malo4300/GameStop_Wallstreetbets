library(tidyverse)

data = read_csv("pushshift.csv")

data$created_utc = as.Date(as.POSIXct(data$created_utc, origin="1970-01-01"))

data = select(data, -c(d_,created))

ggplot(data = data, mapping = aes(x=created_utc, y = num_comments))+
  geom_point()



data = data[str_detect(data$url, "comments"),] #url ohne comment sind bilder/memes/videos
data = data %>% filter(data$num_comments > 2) ##weniger als 3 Kommentare entweder irrelvant, gelöscht oder Bot

dim(data)
Anzahl_Kommentare = sum(data$num_comments)
write.csv(data, "pushshift_clean.csv")
### cleaning hier fertig, aber anzahl der kommentare müssen reduziert werden

ggplot(data = data) + 
  geom_histogram(mapping = aes(x = num_comments), bins = 10,color="black", fill="white") + 
  labs(x = "Anzahl Kommentare", y = "Anzahl", title = "Anzahl Kommentare")
sum(data_under_1000$num_comments)

ggplot(data = data, mapping = aes(x = created_utc, y = num_comments, col = score)) + 
  geom_point(size = 1) +
  scale_color_gradient(low = "red", high ="blue")
