# Variavel que controla a execucao do script
Azure <- F

if(Azure){
  source("src/Tools.R")
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
}else{
  bikes <- bikes
}

str(bikes)

# Verificando a correlacao entre as variaveis preditoras
bikes$count <- bikes$cnt - predict(lm(cnt ~ dteday, data = bikes), newdata = bikes)

cols <- c("mnth", "hr", "holiday", "workingday",
          "weathersit", "temp", "hum", "windspeed",
          "isWorking", "monthCount", "dayWeek", 
          "workTime", "xformHr", "count")

# Metodos de Correlacao
# Pearson - coeficiente usado para medir o grau de relacionamento entre duas variaveis com relacao linear
# Spearman - eh um teste nao parametrico, para medir o grau de relacionamento entre duas variaveis
# Kendall - eh um teste nao parametrico, para medir a forca de dependencia entre duas variaveis
metodos <- c("pearson", "spearman")

cors <- lapply( metodos, function(method) 
  (cor(bikes[, cols], method = method)))

head(cors)

require(lattice)
plot.cors <- function(x, labs){
  diag(x) <- 0.0 
  plot( levelplot(x, 
                  main = paste("Plot de Correlação usando Método", labs),
                  scales = list(x = list(rot = 90), cex = 1.0)) )
}

Map(plot.cors, cors, metodos)

## Gera saida no Azure ML
if(Azure) maml.mapOutputPort('bikes')