# Script tested on October 29 2016

# CO2 parts per million for 2000-2009
co2 =  c(369.40,371.07,373.17,375.78,377.52,379.76,381.85,383.71,385.57,384.78)
year <-  (2000:2009) # a range of values

# show values
co2
year

#compute mean and standard deviation
mean(co2)
sd(co2)
plot(year,co2)


# Data in R format
year <-  (2007:2012)
year

sqft <-  c(14214216, 14359041, 14752886, 15341886, 15573100, 15740742)
sqft

kwh <-  c(2141705, 2108088, 2150841, 2211414, 2187164, 2057364)
kwh

x <- kwh/sqft
x

g <- plot(year,x)
g


#Create a matrix containing the values 1 through 12 and put values in a 4-column, 3-row matrix
m <-  matrix(1:12, nrow=4,ncol=3)
m
m[4,3]
m

#Answer to exercise in slideshow
n <- matrix(1:18,nrow=6,ncol=3)
n
n[5,2] <- 23
n

a <-  array(1:24, c(4,3,2))
a     #Display the values in the array
a[1,1,1]



#Reading in data of two different types into two vectors, then creating a data frame containing the data
gender <- c("m","f","f")
age <- c(5,8,3)
df <-  data.frame(gender,age)

df    #display values in df

df[2,2]  #display the value in row 2, column 2

df[1,2]
df[1,]   #display the values in the entire first row
df[,2]   #display the values in the entire second column


#Install birk from CRAN if it does not already appear in the list of packages

#install.packages("birk")   - check the birk checkbox 

library(birk)  #tell R that the following statements will use the birk package

conv_unit(100,'F', 'C')
conv_unit(100,'m','ft')


#Install measurements from CRAN to avoid getting error messages, then check the measurements package

library(measurements)

#execute the statements again using measurements and note that no error messages are displayed
conv_unit(100,'F', 'C')
conv_unit(100,'m','ft')


#dependencies of the knitr package - install each, in the order in which they are listed
#install.packages("stringi")
#install.packages("stringr")
#install.packages('knitr')

#Check the stringi, stringr, and knitr packages

library(stringi)
library(stringr)
library(knitr)


#dependencies of the readr package - install each, in the order in which they are listed
#install.packages(c("Rcpp","RJSONIO","bitops","digest","functional","reshape2","stringr","plyr","caTools"))
#The commented statement above contains a nested function call within an outer function call.
#Executing the statement may not result in the successful installation of all packages.

#Install the packages in the following order and then check their checkboxes.
#install.packages("Rcpp")
#install.packages("RJSONIO")
#install.packages("bitops")
#install.packages("digest")
#install.packages("functional")
#install.packages("reshape2")
#install.packages("stringr")
#install.packages("plyr")
#install.packages("caTools")

#install.packages("readr")
#You only have to install a package in your account once, but you have to check it before you want to use it.

library(readr)

# Read a file with a URL
url <-  'http://people.terry.uga.edu/rwatson/data/centralparktemps.txt'
t <- read_delim(url,delim=',')


head(t)
tail(t)
str(t)

t$temperature  #display all the values of the temperature column in the data frame named t
meanTemp <- mean(t$temperature)


library(reshape2)
library(readr)
url <-  'http://people.terry.uga.edu/rwatson/data/meltExample.csv'
# no column names and tab as delimiter
s <- read_delim(url,col_names=F,delim='\t')
head(s)
colnames(s) <-  c('year', 1:12)
head(s)   #Note that the default column names have been replaced.

# melt (normalization) - see slide #71 of Chapter 14 slideshow for graphic of how melting works
m<-melt(s,id='year')
head(m)
tail(m)
str(m)

library(measurements)
library(readr)
url <- 'http://people.terry.uga.edu/rwatson/data/centralparktemps.txt'
t <- read_delim(url, delim=',')
head(t)


# compute Celsius and round to one decimal place
t$Ctemp = round(conv_unit(t$temperature,'F','C'),1)
head(t)

colnames(t)[3] <-  'Ftemp' # rename third column to indicate Fahrenheit
head(t)
write_csv(t,"centralparktempsCF.txt")
View(t)

library(sqldf)
options(sqldf.driver = "SQLite") # to avoid a conflict with RMySQL

sqldf("SELECT * FROM t")

avgTemp <- sqldf("SELECT year, AVG(Ftemp) FROM t GROUP BY year")
head(avgTemp)
View(avgTemp)

data1900 <- sqldf("SELECT * FROM t WHERE year = 1900 ORDER BY month")
View(data1900)


options(sqldf.driver = "SQLite") # to avoid a conflict with RMySQL
url <-  'http://people.terry.uga.edu/rwatson/data/centralparktemps.txt'
t <- read_delim(url, delim=',')
# average monthly temp for each year
a <- sqldf("select year, avg(temperature) as mean from t group by year")
View(a)

# read yearly carbon data (source: ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt)
url <-  'http://people.terry.uga.edu/rwatson/data/carbonMeans.txt'
carbon <- read_delim(url, delim=',') 
m <-  sqldf("select a.year, CO2, mean from a, carbon where a.year = carbon.year")
View(m)

cor.test(m$mean,m$CO2)

mod <- lm(m$mean ~ m$CO2)
summary(mod)

#install.packages(RMySQL) - install and check RMySQL

library(readr)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="Weather", user="db2", password="student")
# Query the database and create file t for use with R
b <- dbGetQuery(conn,"SELECT timestamp, airTemp from record;")
head(b)
View(b)

library(readr)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="Weather", user="db2", password="student")
# Query the database and create file b for use with R
b <- dbGetQuery(conn,"SELECT * from record;")
head(b)
View(b)


library(readr)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "mistsql.terry.uga.edu", dbname="ClassicModels", user="demo", password="godawgs1")
# Query the database and create file b for use with R
c <- dbGetQuery(conn,"SELECT * from Offices;")
head(c)
View(c)

library(readr)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "mistsql.terry.uga.edu", dbname="ClassicModels", user="demo", password="godawgs1")
# Query the database and create file b for use with R
d <- dbGetQuery(conn,"SELECT * from Customers;")
View(d)


# Database access with confidential information in a separate file
library(readr)
library(DBI)
login <-  'dbinfo.txt'
d <-  read_csv(login)
conn <- dbConnect(RMySQL::MySQL(), d$url, dbname=d$dbname, user=d$user, password=d$password)
t <- dbGetQuery(conn,"SELECT * from Customers;")
View(t)
warnings()

#Missing values

sum(c(1,NA,2))

sum(c(1,NA,2),na.rm=T)  #Remove missing values = True

gender <- c("m","f","f","f")
age <- c(5,8,3,NA)
df <-  data.frame(gender,age)
df2 <-  na.omit(df)
View(df)


#Merging files
library(sqldf)
options(sqldf.driver = "SQLite") # to avoid a conflict with RMySQL
url <-  'http://people.terry.uga.edu/rwatson/data/centralparktemps.txt'
t <- read_delim(url, delim=',')
View(t)

# average monthly temp for each year
a <-  sqldf("select year, avg(temperature) as mean from t group by year")
# read yearly carbon data (source: ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt)
url <-  'http://people.terry.uga.edu/rwatson/data/carbonMeans.txt'
carbon <- read_delim(url, delim=',') 
View(carbon)
m <-  sqldf("select a.year, CO2, mean from a join carbon on a.year = carbon.year")
View(m)



