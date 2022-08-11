install.packages("ggplot2")
library(DBI)
library(RMySQL)
library(ggplot2)


MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)
dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage order by Language")

dbDisconnect(MyDataBase)
DataDB

country.spanish <-  DataDB %>% filter(Language == "Spanish") %>%  select('CountryCode','Percentage')  # Ciudades del país de México con más de 50,000 habitantes

class(country.spanish)
class(country.spanish$CountryCode)
class(country.spanish$Percentage)
head(country.spanish$Percentage)

graph <- ggplot(country.spanish, 
                 aes( Percentage, CountryCode)) + geom_bar(stat="identity", colour="gray") 
print(graph)

