library(rtweet)
library(twitteR)
library(streamR)
library(tidytext)
library(Rsentiment)
library(syuzhet)
library(SnowballC)
library(tm)
library(RColorBrewer)
library(plyr)
library(dplyr)
library(tmap)
library(wordcloud)

consumer_key <-"DNnhocvfRJwAdVq05EKHFBV7v"
consumer_secret <- "FnVrIdxCG95Qainl1gqDeg4uLOaNHmFQIslO20RB2pfqC0BPMn"
access_token<-"2814898578-wKarKmnCDX6SaASPdY70yi0aFkQcBRlrrajAZ8S"
access_secret <- "jO0gXM1lpYj3Ty1AFqajDUwAZ7Cf1pnJAOlZSXHb81Dis"


setup_twitter_oauth(consumer_key ,consumer_secret,access_token,access_secret)
 
 
 tweetsretrived <- searchTwitter("liberals", lang="en", n=1500)
  
 tweetsdf <- twListToDF(tweetsretrived)
 write.csv(tweetsdf, file = "Tweets.csv")
 
 tweets_text <- sapply(tweetsretrived, function(x) x$getText())
 # View(tweets_text)

 #cleaning Text
 
 clean_text1 <- gsub("RT|via)((?:\\b\\w*@\\w+)+)","",tweets_text)
 clean_text2 <- gsub("http[^[:blank:]]+","",clean_text1)
 clean_text3 <- gsub("@\\w+","",clean_text2)
 clean_text4 <- gsub("[[:punct:]]"," ",clean_text3)
 clean_text5 <- gsub("[^[:alnum:]]"," ",clean_text4)
 
 write.csv(clean_text5, "Tweets1.csv")
 
 
 #creating wordcorpus word cloud
clean_text7 <- tm::Corpus(tm::VectorSource(clean_text5))
clean_text7 <- tm::tm_map(clean_text7,tm::removePunctuation)
clean_text7 <- tm::tm_map(clean_text7,tm::content_transformer(tolower))
clean_text7 <- tm::tm_map(clean_text7, tm::removeWords, tm::stopwords("english"))
clean_text7 <- tm::tm_map(clean_text7, tm::stripWhitespace)
 
 
pal <- RColorBrewer::brewer.pal(8,"Dark2")
wordcloud::wordcloud(clean_text7,min.freq = 7, max.words = Inf, width = 1000, height = 1000, random.order = FALSE, color = pal)
# wordcloud(clean_text7, random.order=F,max.words=80, col=rainbow(50), scale=c(4,0.5))


#getting different emotions from the cleaned tweets
mysentiment <- syuzhet::get_nrc_sentiment(clean_text5)
sentimentscores <- data.frame(colSums(mysentiment[,]))
names(sentimentscores) <- "score"
sentimentscores <- cbind("sentiment" = rownames(sentimentscores), sentimentscores)

row.names(sentimentscores) <- NULL

#plotting them on to the bar garph

ggplot2::ggplot(data = sentimentscores, ggplot2::aes(x = sentiment, y = score))+
        ggplot2::geom_bar(ggplot2::aes(fill = sentiment),stat = "identity")+
        ggplot2::theme(legend.position = "none")+
          ggplot2::xlab("sentiment") + ggplot2::ylab("score") + ggplot2::ggtitle("Total sentiment score based on tweets")



# trying to seggragate positive and negative tweets and plot it in the graph but it doesn't worked here

#  sent.value <- syuzhet::get_sentiment(clean_text5)
# 
# value <- RSentiment::calculate_sentiment(clean_text5)
# 
# positive <- clean_text5[sent.value > 0]
# negative <- clean_text5[sent.value < 0]
# neutral <- clean_text5[sent.value = 0]
#  
 