##### Librarys ---------
library(syuzhet)
library(tidyverse)
library(RedditExtractoR)


##### Find Threads von python ----------
threads = read.csv("Data/pushshift_clean_first_quarter.csv")


n = nrow(threads)


##### group Threads-------
gme_tibble_mean = tibble(Date = threads$created_utc,
                        Count_of_Comments = threads$num_comments,
                        URL =  threads$url, 
                        mean = rep(0))


##### analyse thread -----------
summarize_thread = function(content_array){
  anzahl_comments = nrow(content_array$comments)
  #create variable to store sentiment per comment
  sentiment = rep(0,anzahl_comments-1)
  # i skip the first comment since it is always a bot comment
  for(j in 2:anzahl_comments){
    comment = content_array$comments$comment[j]
    saetze = get_sentences(comment)
    sentiment[j-1] = mean(get_sentiment(saetze))*content_array$comments$score[j] #weighted by score
  }
  return(mean(sentiment))
}

pb = txtProgressBar(min = 0, max = n, initial = 0, style = 3) 
for (i in 1:n) { # gehe durch alle threads
  tryCatch(expr = {thread_content = get_thread_content(gme_tibble_mean$URL[i])
                   gme_tibble_mean$mean[i] = summarize_thread(thread_content)}, 
                    error = function(e){
                   print(sprintf("Error im Lauf %s", i))
                
                   }, 
                   finally ={setTxtProgressBar(pb, i)})
}
close(pb)
#this loop took 7 hours

ggplot(data = gme_tibble_mean[1:n,])+ 
  geom_point(mapping = aes(x = Date, y = mean, col = Count_of_Comments), show.legend = TRUE)+
  scale_color_gradient(low="red", high="green")

##### Group means by date and weight by the number of comments per post
gme_tibble_mean = na.omit(gme_tibble_mean)
gme_date_discrete = select(gme_tibble_mean, - "URL") %>% group_by(Date) %>% summarise(mean = weighted.mean(x = mean, w = Count_of_Comments ), sum_com = sum(Count_of_Comments))
sum_of_comments_usable = sum(gme_date_discrete$sum_com)
#save data
write.csv(gme_tibble_mean, file = "Data/gme_tibble_mean_first_quarter.csv")
write.csv(gme_date_discrete, file = "Data/gme_date_discrete_first_quarter.csv")

#plot
gme_date_discrete = read_csv("Data/gme_date_discrete_first_quarter.csv")
ggplot(data = filter(gme_date_discrete))+  #, Date > "2022-02-05")
  geom_point(mapping = aes(x = Date, y = mean, col = sum_com), show.legend = TRUE)+
  scale_color_gradient(low="red", high="green") +
  geom_hline(yintercept = 0) +
  labs(title = "Game Stop Sentiment im Subreddit WallstreetBets im Jahr 2021\n", x = "Datum", y = "Durchschnittliches Sentiment", color = "Anzahl Kommentare") +
  theme(plot.title = element_text(size = 15, face = "bold", color = "darkgrey"))



