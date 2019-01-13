# Variavel que controla a execucao do script
Azure <- F

if(Azure){
  source("src/Tools.R")
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
}else{
  bikes <- bikes
}

dim(bikes)
any(is.na(bikes))

# Criando um modelo para identificar os atributos com maior importancia para o modelo preditivo
require(randomForest)

# Avalidando a importância de todas as variaveis
modelo <- randomForest(cnt ~ . , 
                       data = bikes, 
                       ntree = 100, nodesize = 10,
                       importance = TRUE)

# Removendo variaveis colineares
modelo <- randomForest(cnt ~ . - count
                       - mnth
                       - hr
                       - workingday
                       - isWorking
                       - dayWeek
                       - xformHr
                       - workTime
                       - holiday
                       - windspeed
                       - monthCount
                       - weathersit, 
                       data = bikes, 
                       ntree = 100, nodesize = 10,
                       importance = TRUE)

# Plotando as variaveis por grau de importancia
varImpPlot(modelo)

# Gravando o resultado
df_saida <- bikes[, c("cnt", rownames(modelo$importance))]


if(Azure) maml.mapOutputPort("df_saida ")