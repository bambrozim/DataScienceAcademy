# Variável que controla a exercução do script
Azure <- FALSE

# Execução de acordo com o valor da variável Azure
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
print('Dimensões do dataframe antes das operações de transformação:')
print(dim(Bikes))

# Filtrando o dataframe
Bikes <- Bikes %>% filter(cnt > 100)

print('Dimensões do dataframe após as operações de transformação:')
print(dim(Bikes))

# ggplot2
require(ggplot2)
qplot(dteday, cnt, data=subset(Bikes, hr==9), geom = 'line')

# Resultado
if(Azure) maml.mapOutputPort('Bikes')