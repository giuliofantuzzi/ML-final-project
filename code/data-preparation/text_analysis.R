library(textclean)
library(tm)
library(dplyr)

# Remove emoji
tweets_df$text<- replace_emoji(tweets_df$text)

# Create a corpus
corpus <- Corpus(VectorSource(tweets_df$text))

# Perform text pre-processing
corpus <- tm_map(corpus, PlainTextDocument)
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stemDocument)

# Create a document-term matrix
dtm <- DocumentTermMatrix(corpus,control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE)))
sparse <- removeSparseTerms(dtm, 0.98) 

# Convert dtm to a data frame
frequencies <- as.data.frame(as.matrix(sparse))

# Bind the dtm data frame with the rest of the variables (NB: we can remove text now!)
tweets_df <- cbind(frequencies, dplyr::select(tweets_df, -c("text")))
#tweets_df <- tweets_df %>% subset(., select=which(!duplicated(names(.)))) 
