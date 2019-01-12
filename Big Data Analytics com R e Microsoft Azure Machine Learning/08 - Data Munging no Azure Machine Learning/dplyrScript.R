Azure = F

if(Azure){
  restaurantes <- maml.mapInputPort(1)
  ratings <- maml.mapInputPort(2)
}else{
  restaurantes <- read.csv('Restaurant features data.csv',
                           sep=',', header=T, stringsAsFactors = F)
  ratings <- read.csv('Restaurant ratings.csv',
                      sep=',', header=T, stringsAsFactors = F)
}

restaurantes <- restaurantes[restaurantes$franchise ==  'f' & restaurantes$alcohol != 'No_Alcohol_Served', ]

require(dplyr)
df <- as.data.frame(restaurantes %>%
                      inner_join(ratings, by = 'placeID') %>%
                      select(name, rating) %>%
                      group_by(name) %>%
                      summarize(ave_Rating = mean(rating)) %>%
                      arrange(desc(ave_Rating)))

df

if(Azure) maml.mapOutputPort('df')