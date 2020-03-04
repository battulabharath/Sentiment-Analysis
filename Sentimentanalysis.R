library(ROAuth)
library(twitteR)
install.packages(c("devtools", "rjson", "bit64", "httr"))

consumer_key <-"DNnhocvfRJwAdVq05EKHFBV7v"
consumer_secret <- "FnVrIdxCG95Qainl1gqDeg4uLOaNHmFQIslO20RB2pfqC0BPMn"
access_token<-"2814898578-wKarKmnCDX6SaASPdY70yi0aFkQcBRlrrajAZ8S"
access_secret <- "jO0gXM1lpYj3Ty1AFqajDUwAZ7Cf1pnJAOlZSXHb81Dis"

setup_twitter_oauth(consumer_key ,consumer_secret, access_token,  access_secret )


 cred <- OAuthFactory$new(consumerKey='DNnhocvfRJwAdVq05EKHFBV7v', consumerSecret='FnVrIdxCG95Qainl1gqDeg4uLOaNHmFQIslO20RB2pfqC0BPMn',requestURL='https://api.twitter.com/oauth/request_token',accessURL='https://api.twitter.com/oauth/access_token',authURL='https://api.twitter.com/oauth/authorize')
 
 cred$handshake(cainfo="cacert.pem")