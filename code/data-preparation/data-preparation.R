# R code for the data preparation phase
df<-read.csv("dataset.csv")
# converti queste colonne in binario
df$external.link <- ifelse(grepl("^\\s*$",df$external.link), 0, 1)
df$pictures <- ifelse(grepl("^\\[\\]$",df$pictures), 0, 1)
df$videos<-ifelse(grepl("^\\[\\]$",df$videos), 0, 1)
df$gifs<-ifelse(grepl("^\\[\\]$",df$gifs), 0, 1)

# 1 se il tweet contiene almeno un'immagine, video o gifs
df$multimedial_content <- df$picture| df$videos|df$gifs
df$multimedial_content<-as.integer((df$multimedial_content))

tweets_df <- subset(df, select = -c(pictures, videos,gifs))

# TO DO
#   - compute eng-rate
#   - remove vars used for eng-rate
#   - convert some vars into binary
#   - define functions to count hashtags in a tweet and to get tweet_length
#   - something else...
