# R code for the data preparation phase
tweets_df=read.csv2("../../datasets/tweets&users-data.csv",header=T,sep=',')

# TO DO
#   - compute eng-rate
#   - remove vars used for eng-rate
#   - convert some vars into binary
#   - define functions to count hashtags in a tweet and to get tweet_length
#   - something else...