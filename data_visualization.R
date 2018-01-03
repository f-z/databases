
#install.packages("ggvis")

library(ggvis)
library(readr)
url <- 'http://people.terry.uga.edu/rwatson/data/carbonMeans.txt'
carbon <- read_delim(url, delim=',')

# Select year(x) and CO2(y) to create a x-y point plot
# Specify red points, as you find that aesthetically pleasing
carbon %>% ggvis(~year,~CO2) %>% layer_points(fill:= 'red')
# Notice how ‘%>%’ is used for creating a pipeline of commands

carbon %>% ggvis(~year,~CO2) %>% layer_points(fill:='red') %>% 
  scale_numeric('y',zero=T)

# Compute a new column containing the relative change in CO2
carbon$relCO2 = (carbon$CO2-280)/280
carbon %>% ggvis(~year,~relCO2) %>% layer_lines(stroke:='blue') %>% 
  scale_numeric('y',zero=T) %>%   
  add_axis('y', title = "CO2 ppm of the atmosphere", title_offset=50) %>%   
  add_axis('x', title ='Year', format = '####')


library(ggvis)
library(readr)
library(measurements)
url <-  'http://people.terry.uga.edu/rwatson/data/centralparktemps.txt'
t <- read_delim(url, delim=',')
#View(t)
t$C <- round(conv_unit(t$temperature,'F','C'),1)
#View(t)
t %>% ggvis(~C) %>% layer_histograms(width = 2, fill:='cornflowerblue') %>% 
  add_axis('x',title='Celsius') %>% 
  add_axis('y',title='Frequency')

library(ggvis)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
# Query the database and create file for use with R
d <- dbGetQuery(conn,"SELECT productLine from Products;") 
#View(d)
# Plot the number of product lines by specifying the appropriate column name
d %>% ggvis(~productLine) %>% layer_bars(fill:='chocolate') %>%
  add_axis('x',title='Product line') %>% 
  add_axis('y',title='Count')


library(ggvis)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
#Alternate source if statement above fails
#conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
# Get the monthly value of orders
d <- dbGetQuery(conn,"SELECT MONTH(orderDate) AS orderMonth, sum(quantityOrdered*priceEach) AS orderValue FROM Orders, OrderDetails WHERE Orders.orderNumber = OrderDetails.orderNumber GROUP BY orderMonth;") 
#View(d)
# Plot data orders by month
# Show the points and the line
#head(d)
d %>% ggvis(~orderMonth, ~orderValue/1000000)%>%  
  layer_lines(stroke:='blue') %>%
  layer_points(fill:='red') %>%
  add_axis('x', title = 'Month') %>%
  add_axis('y',title='Order value (millions)', title_offset=30)


library(ggvis)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
d <- dbGetQuery(conn,"SELECT YEAR(orderDate) AS orderYear, MONTH(orderDate) AS Month, sum((quantityOrdered*priceEach)) AS Value FROM Orders, OrderDetails WHERE Orders.orderNumber = OrderDetails.orderNumber GROUP BY orderYear, Month;")
#View(d)
# Plot data orders by month and display by year
# ggvis expects grouping variables to be a factor, so convert
d$Year <-   as.factor(d$orderYear)
d %>% group_by(Year) %>% ggvis(~Month,~Value/1000, stroke = ~Year) %>%
  layer_lines() %>% 
  add_axis('x', title = 'Month') %>%
  add_axis('y',title='Order value (thousands)', title_offset=50)


d %>% group_by(Year) %>% ggvis( ~Month, ~Value/100000, fill = ~Year) %>% layer_bars() %>% 
  add_axis('x', title = 'Month') %>%
  add_axis('y',title='Order value (thousands)', title_offset=50) 


library(ggvis)
library(DBI)
library(sqldf)
options(sqldf.driver = "SQLite") # to avoid conflict with RMySQL
# Load the driver
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
orders <- dbGetQuery(conn,"SELECT 'Orders' as Category, MONTH(orderDate) AS month, sum((quantityOrdered*priceEach)) AS value FROM Orders, OrderDetails WHERE Orders.orderNumber = OrderDetails.orderNumber and YEAR(orderDate) = 2004 GROUP BY Month;")
#View(orders)
payments <-  dbGetQuery(conn,"SELECT 'Payments' as Category, MONTH(paymentDate) AS month, SUM(amount) AS value FROM Payments WHERE YEAR(paymentDate) = 2004 GROUP BY MONTH;")
#View(payments)
# concatenate the two files
m <-  sqldf("select month, Category, value from orders UNION select month, Category, value from payments")
#View(m)
m %>% group_by(Category) %>% ggvis(~month, ~value, stroke = ~ Category) %>% 
  layer_lines() %>% 
  add_axis('x',title='Month') %>% 
  add_axis('y',title='Value',title_offset=70) 


library(sqldf)
options(sqldf.driver = "SQLite") # to avoid conflict with RMySQL
url <-  "http://people.terry.uga.edu/rwatson/data/centralparktemps.txt"
t <- read_delim(url, delim=',')
#View(t)
t8 <- sqldf('select * from t where month = 8')
#View(t8)
t8 %>% ggvis(~year,~temperature) %>% 
  layer_lines(stroke:='red') %>% 
  layer_smooths(se=T, stroke:='blue') %>%
  add_axis('x',title='Year',format = '####') %>% 
  add_axis('y',title='Temperature (F)', title_offset=30)

library(ggvis)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
d <- dbGetQuery(conn,"SELECT amount from Payments;")
#View(d)
# Boxplot of amounts paid
d %>% ggvis(~factor(0),~amount) %>% layer_boxplots() %>%
  add_axis('x',title='Checks') %>% 
  add_axis('y',title='')


library(ggvis)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
d <- dbGetQuery(conn,"SELECT month(paymentDate) as month, amount from Payments;")
#View(d)
# Boxplot of amounts paid
d %>% ggvis(~month,~amount) %>% layer_boxplots() %>%
  add_axis('x',title='Month', values=c(1:12)) %>%
  add_axis('y',title='Amount', title_offset=70)


library(ggvis)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
d <- dbGetQuery(conn,'SELECT count(*) as Frequency, productLine as Line, productScale as Scale from Products group by productLine, productScale')
#View(d)
d %>% ggvis( ~Scale, ~Line, fill= ~Frequency) %>% 
  layer_rects(width = band(), height = band()) %>%
  layer_text(text:=~Frequency, stroke:='white', align:='left', baseline:='top') # add frequency to each cell


#dynamic visualization
#install.packages(shiny)
library(ggvis)
library(shiny)
carbon$relCO2 = (carbon$CO2-280)/280
carbon %>% ggvis(~year,~relCO2) %>%
  layer_lines(stroke:=input_select(c("red", "green", "blue"))) %>% 
  scale_numeric('y',zero=T) %>% 
  add_axis('y', title = "CO2 ppm of the atmosphere", title_offset=50) %>% 
  add_axis('x', title ='Year', format='####')

#dynamic visualization
library(shiny)
carbon$relCO2 = (carbon$CO2-280)/280
slider <- input_slider(1, 5, label = "Width")
select_color <- input_select(label='Color',c("red", "green", "blue")) 
carbon %>% ggvis(~year,~relCO2) %>% 
  layer_lines(stroke:=select_color, strokeWidth:=slider) %>%
  scale_numeric('y',zero=T) %>% 
  add_axis('y', title = "CO2 ppm of the atmosphere", title_offset=50) %>% 
  add_axis('x', title ='Year', format='####')


#No plots from these statements - not supposed to have plots 
#The sqldf statements are compared to dplyr functions
library(dplyr)
library(readr)
library(sqldf)
options(sqldf.driver = "SQLite") # to avoid conflict with DBI
url <-  'http://people.terry.uga.edu/rwatson/data/centralparktemps.txt'
t <- read_delim(url, delim=',')
#View(t)
# filter
sqldf("select * from t where year = 1999")
filter(t,year==1999)
# select
sqldf("select temperature from t")
select(t,temperature)
# a combination of filter and select
sqldf("select * from t where year > 1989 and year < 2000")
select(t,year, month, temperature) %>% filter(year > 1989 & year < 2000)
# arrange
sqldf("select * from t order by year desc, month")
arrange(t, desc(year),month)
# mutate -- create a new column
t_SQL <- sqldf("select year, month, temperature, (temperature-32)*5/9 as CTemp from t")
t_dplyr <-  mutate(t,CTemp = (temperature-32)*5/9)
# summarize
sqldf("select avg(temperature) from t")
summarize(t,mean(temperature))


library(shiny)
library(ggvis)
library(dplyr)
library(readr)
url <-  'http://people.terry.uga.edu/rwatson/data/centralparktemps.txt'
t <- read_delim(url, delim=',')
View(t)
slider <- input_slider(1, 12,label="Month")
t %>% 
  ggvis(~year,~temperature) %>% 
  filter(month == eval(slider)) %>% 
  layer_points() %>%
  add_axis('y', title = "Temperature", title_offset=50) %>% 
  add_axis('x', title ='Year', format='####')

#No plot
#install.packages(ggplot2)
#install.packages(ggmap)
#install.packages(mapproj)
#install.packages(DBI)
library(ggplot2)
library(ggmap)
library(mapproj)
library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
# Google maps requires lon and lat, in that order, to create markers
d <- dbGetQuery(conn,"SELECT y(officeLocation) AS lon, x(officeLocation) AS lat FROM Offices;")
#View(d)
# show offices in the United States
# vary zoom to change the size of the map
map <-  get_googlemap('united states',marker=d,zoom=4)
ggmap(map) + labs(x = 'Longitude', y = 'Latitude') + ggtitle('US offices')



library(ggplot2)
library(ggmap)
library(mapproj)
library(readr)
url <-  'http://people.terry.uga.edu/rwatson/data/pumps.csv'
pumps <- read_delim(url, delim=',')
#View(pumps)
url <-  'http://people.terry.uga.edu/rwatson/data/deaths.csv'
deaths <- read_delim(url, delim=',')
#View(deaths)
map <-  get_googlemap('broadwick street, london, united kingdom',markers=pumps,zoom=15)
ggmap(map) + labs(x = 'Longitude', y = 'Latitude') + ggtitle('Pumps and deaths') + 
  geom_point(aes(x=longitude,y=latitude,size=count),color='blue',data=deaths) +
  xlim(-.14,-.13) + ylim(51.51,51.516)


#install.packages(leaflet)
library(leaflet)
location <- geocode("university of georgia, athens, usa")
m<-leaflet() %>% addTiles() %>% addMarkers(lng=location$lon, lat=location$lat, popup="UGA")
m

#install.packages(leaflet)
library(leaflet)
location <- geocode("university of georgia, cortona, italy")
m<-leaflet() %>% addTiles() %>% addMarkers(lng=location$lon, lat=location$lat, popup="UGA")
m

#install.packages(leaflet)
library(leaflet)
location <- geocode("university of georgia, griffin, usa")
m<-leaflet() %>% addTiles() %>% addMarkers(lng=location$lon, lat=location$lat, popup="UGA")
m

#install.packages(ggmap)
library(ggmap)
hdf <- get_map("Athens, GA, USA")
ggmap(hdf)

library(DBI)
conn <- dbConnect(RMySQL::MySQL(), "richardtwatson.com", dbname="ClassicModels", user="db1", password="student")
d <- dbGetQuery(conn,"SELECT y(officeLocation) AS lon, x(officeLocation) AS lat FROM Offices;")
#View(d)
map<-leaflet() %>% addTiles()
map %>% addCircles(data=d, lat=~d$lat, lng=~d$lon)

