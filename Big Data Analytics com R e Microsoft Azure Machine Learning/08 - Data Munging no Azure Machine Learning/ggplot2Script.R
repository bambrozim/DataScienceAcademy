Azure <- F

if(Azure){
  source('src/Tools.R')
  Bikes <- maml.mapInputPort(1)
  Bikes$dteday <- set.asPOSIXct(Bikes)
}else{
  source('Tools.R')
  Bikes <- read.csv('bikes.csv', sep=',', header=T, stringsAsFactors = F)
  Bikes$dteday <- char.toPOSIXct(Bikes)
}

require(dplyr)
Bikes <- Bikes %>% filter(hr == 9)

require(ggplot2)
ggplot(Bikes, aes(x=dteday, y=cnt)) +
  geom_line() +
  ylab('Número de Bikes') +
  xlab('Linha do Tempo') +
  ggtitle('Demanda por Bikes as 09:00') +
  theme(text = element_text(size = 20))