#-------------------------------------------------------------------------------
# R code for the data preparation phase
#-------------------------------------------------------------------------------

# Import data
tweets_df<-read.csv("../../datasets/tweets&users-data-merged.csv")

# Convert some variables to binary
tweets_df$external.link <- ifelse(tweets_df$external.link == "", FALSE, TRUE)
tweets_df$pictures <- ifelse(tweets_df$pictures=="[]", FALSE, TRUE)
tweets_df$videos<-ifelse(tweets_df$videos=="[]", FALSE, TRUE)
tweets_df$gifs<-ifelse(tweets_df$gifs=="[]", FALSE, TRUE)

tweets_df$is.retweet<-ifelse(grepl("False",tweets_df$is.retweet), FALSE, TRUE)

tweets_df$user.image<-ifelse(tweets_df$user.image == "", FALSE, TRUE)
tweets_df$user.bio<-ifelse(tweets_df$user.bio == "", FALSE, TRUE)
tweets_df$user.website<-ifelse(tweets_df$user.website == "", FALSE, TRUE)

# Binary variable which is true if the tweet contains ANY 
tweets_df$multimedial_content <- tweets_df$picture| tweets_df$videos | tweets_df$gifs
# NB: think about making this a multinomial var with categories "picture", "video", "gif"

# Compute engagement rate
tweets_df$engagement.rate= with(tweets_df,log((1+likes+retweets+comments)/(1+user.followers))*100)


# Count hashtags
library(stringr)
count_hashtags <- function(tweet) {
  hashtags <- str_extract_all(tweet, "#\\w+")
  return(length(hashtags[[1]]))
}

n_hashtags<- vector(mode="numeric", length = nrow(tweets_df))

for(i in 1: nrow(tweets_df)){
  n_hashtags[i]= count_hashtags(tweets_df[i,"text"])
}

tweets_df$n_hashtags= n_hashtags

# Save csv 
sub= subset(tweets_df,select= c("text","quotes","is.retweet","external.link",
                                "pictures","videos","gifs","multimedial_content",
                                "user.image","user.bio","user.website","user.tweets",
                                "user.following","user.media","engagement.rate",
                                "n_hashtags"
                                )
            )

write.csv(sub,file = "../../datasets/data-prepared.csv",row.names = FALSE)
