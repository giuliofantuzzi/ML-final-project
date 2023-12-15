#-------------------------------------------------------------------------------
# R code for the data preparation phase
#-------------------------------------------------------------------------------

# Import data
tweets_df<-read.csv("../../datasets/tweets&users-data-merged.csv")

# Convert some variables to binary
tweets_df$external.link <- ifelse(grepl("^\\s*$",tweets_df$external.link), FALSE, TRUE)
tweets_df$pictures <- ifelse(grepl("^\\[\\]$",tweets_df$pictures), FALSE, TRUE)
tweets_df$videos<-ifelse(grepl("^\\[\\]$",tweets_df$videos), FALSE, TRUE)
tweets_df$gifs<-ifelse(grepl("^\\[\\]$",tweets_df$gifs), FALSE, TRUE)

tweets_df$is.retweet<-ifelse(grepl("False",tweets_df$is.retweet), FALSE, TRUE)

tweets_df$user.image<-ifelse(tweets_df$user.image == "", FALSE, TRUE)
tweets_df$user.bio<-ifelse(tweets_df$user.bio == "", FALSE, TRUE)
tweets_df$user.website<-ifelse(tweets_df$user.website == "", FALSE, TRUE)

# Binary variable which is true if the tweet contains ANY 
tweets_df$multimedial_content <- tweets_df$picture| tweets_df$videos | tweets_df$gifs

# Compute engagement rate
tweets_df$engagement.rate= with(tweets_df,(likes+retweets+comments)/(1+user.followers)*100)

# Save csv 
sub= subset(tweets_df,select= c("text","quotes","is.retweet","external.link",
                                "pictures","videos","gifs","multimedial_content",
                                "user.image","user.bio","user.website","user.tweets",
                                "user.following","user.media","engagement.rate")
            )

write.csv(sub,file = "../../datasets/data-prepared.csv",row.names = FALSE)

# TO DO
#   - define functions to count hashtags in a tweet and to get tweet_length
#   - something else...

tweets_df<-read.csv("../../datasets/data-prepared.csv",sep = ',')
