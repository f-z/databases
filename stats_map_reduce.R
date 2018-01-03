#Last2.R
#Last R code of semester - November 6, 2016
#Working with rmr2


#########################################################################
#R program to calculate squares

# create a list of 10 integers
ints <- 1:10
ints
# equivalent to ints <- c(1,2,3,4,5,6,7,8,9,10)
# compute the squares
result <- sapply(ints,function(x) x^2)
result

#########################################################################
#Using Map/Reduce to calculate squares

#install.packages(rmr2)
library(rmr2)
rmr.options(backend = "local") # local or hadoop
# load a list of 10 integers into HDFS
hdfs.ints = to.dfs(1:10)
# mapper for the key-value pairs to compute squares

mapper <- function(k,v) {
  key <- v
  value <- key^2
  keyval(key,value)
}

# run MapReduce
out = mapreduce(input = hdfs.ints, map = mapper)
# convert to a data frame
df1 = as.data.frame(from.dfs(out))
colnames(df1) = c('n', 'n^2')
#display the results
df1

##########################################################################


##########################################################################
#R program to calculate temperatures
library(readr)
url <-  "http://people.terry.uga.edu/rwatson/data/centralparktemps.txt"
t <- read_delim(url, delim=',')
head(t)
#convert and round temperature to an integer
t$temperature = round((t$temperature-32)*5/9,0)
head(t)
# tabulate frequencies
table(t$temperature)


##########################################################################
#Map Reduce job to calculate temperatures
library(rmr2)
library(readr)
rmr.options(backend = "local") #local or hadoop
url <-  "http://people.terry.uga.edu/rwatson/data/centralparktemps.txt"
t <- read_delim(url, delim=',')
# save temperature in hdfs file
hdfs.temp <-  to.dfs(t$temperature)

# mapper for conversion to C
mapper <-  function(k,v) {
  key <-  round((v-32)*5/9,0)
  value <-  1
  keyval(key,value)
}

# reducer to count frequencies
reducer <- function(k,v) {
  key <- k
  value = length(v)
  keyval(key,value)
}

out = mapreduce(
  input = hdfs.temp,
  map = mapper,
  reduce = reducer)

df2 = as.data.frame(from.dfs(out))
df2
colnames(df2) = c('temperature', 'count')
df3 <-  df2[order(df2$temperature),]
print(df3, row.names = FALSE) # no row names

####################################################################

####################################################################
# Basic stats using R

#install.packages(reshape)
#install.packages(sqldf)

library(sqldf)
options(sqldf.driver='SQLite')
url <-  "http://people.terry.uga.edu/rwatson/data/centralparktemps.txt"
t <- read.table(url, header=T, sep=',')
a1 <-  sqldf('SELECT year, max(temperature) as value from t GROUP BY year;')
a1$measure = 'max'
a1
a2 <-  sqldf('SELECT year, round(avg(temperature),1) as value from t GROUP BY year;')
colnames(a2) = c('year', 'value')
a2$measure = 'mean'
a3 <-  sqldf('SELECT year, min(temperature) as value from t GROUP BY year;')
a3$measure = 'min'
# stack the results
stack <-  rbind(a1,a2,a3)
library(reshape2)
# reshape with year, max, mean, min in one row
stats <-  dcast(stack,year ~ measure,value="value")
head(stats)

####################################################################
#Basic stats using MapReduce
library(rmr2)
library(reshape)
library(readr)
rmr.options(backend = "local") # local or hadoop
url <-  "http://people.terry.uga.edu/rwatson/data/centralparktemps.txt"
t <- read_delim(url, delim=',')
# convert to hdfs file
hdfs.temp <- to.dfs(data.frame(t))
# mapper for computing temperature measures for each year
mapper <- function(k,v) {
  key <- v$year
  value <- v$temperature
  keyval(key,value)
}

#reducer to report stats
reducer <- function(k,v) {
  key <- k #year
  value <- c(max(v),round(mean(v),1),min(v)) #v is list of values for a year
  keyval(key,value)
}

out = mapreduce(
  input = hdfs.temp,
  map = mapper,
  reduce = reducer)
df3 = as.data.frame(from.dfs(out))
df3
df3$measure <- c('max','mean','min')
# reshape with year, max, mean, min in one row
stats2 <- dcast(df3,key ~ measure,value.var="val")
head(stats2)

####################################################################


####################################################################
#R for a frequency count of words in a file
library(stringr)
# read as a single character string
t <- readChar("http://people.terry.uga.edu/rwatson/data/yogiquotes.txt", nchars=1e6)
t1 <- tolower(t[[1]]) # convert to lower case
t2 <- str_replace_all(t1,"[[:punct:]]","")
# get rid of punctuation
wordList <- str_split(t2, "\\s")
#split into strings
wordVector <- unlist(wordList)
# convert list to vector
table(wordVector)
####################################################################


####################################################################
#R for a frequency count of words in a file
library(rmr2)
library(stringr)
rmr.options(backend = "local") # local or hadoop
# read as a single character string
url <-  "http://people.terry.uga.edu/rwatson/data/yogiquotes.txt"
t <- readChar(url, nchars=1e6)
t
text.hdfs <- to.dfs(t)
mapper=function(k,v){
  t1 <- tolower(v) # convert to lower case
  t2 <- str_replace_all(t1,"[[:punct:]]","") # get rid of punctuation
  wordList <- str_split(t2, "\\s") #split into words
  wordVector <- unlist(wordList) # convert list to vector
  keyval(wordVector,1)
}

reducer = function(k,v) {
  keyval(k,length(v))
}

out <- mapreduce (input = text.hdfs,
                  map = mapper,
                  reduce = reducer,combine=T)
# convert output to a frame
df1 = as.data.frame(from.dfs(out))
colnames(df1) = c('word', 'count')
#display the results
print(df1, row.names = FALSE) # no row names

####################################################################
