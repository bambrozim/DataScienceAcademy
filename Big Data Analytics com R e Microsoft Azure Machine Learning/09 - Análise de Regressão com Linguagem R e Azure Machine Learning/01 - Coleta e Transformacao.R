# Variável que controla a execução do script
Azure <- F

# Execução de acordo com o valor da variável Azure
if(Azure){
  source("src/Tools.R")
  bikes <- maml.mapInputPort(1)
  bikes$dteday <- set.asPOSIXct(bikes)
}else{
  source("src/Tools.R")
  bikes <- read.csv("bikes.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE )
  
  cols <- c("dteday", "mnth", "hr", "holiday",
            "workingday", "weathersit", "temp",
            "hum", "windspeed", "cnt")
  
  bikes <- bikes[, cols]
  
  bikes$dteday <- char.toPOSIXct(bikes)
  bikes <- na.omit(bikes)
  
  ## Normalizar as variaveis preditoras numericas 
  cols <- c("temp", "hum", "windspeed") 
  bikes[, cols] <- scale(bikes[, cols])  
}

str(bikes)
View(bikes)

## Criar uma nova variável para indicar dia da semana (workday)
bikes$isWorking <- ifelse(bikes$workingday & !bikes$holiday, 1, 0)  

## Adicionar uma coluna com a quantidade de meses, o que vai ajudar a criar o modelo
bikes <- month.count(bikes)

## Criar um fator ordenado para o dia da semana, comecando por segunda-feira
## Neste fator eh convertido para ordenado numerico para ser compativel com os tipos de dados do Azure ML
bikes$dayWeek <- as.factor(weekdays(bikes$dteday))

# ==> Analise o dataframe bikes. 
# Se os nomes dos dias da semana estiverem em português na coluna bikes$dayWeek, 
# execute o Bloco1 abaixo, caso contrátio, execute o Bloco2 com os nomes em inglês. 
# Execute um bloco ou o outro.
str(bikes$dayWeek)

# Bloco1
# Se o seu sistema operacional estiver em portugês, execute o comando abaixo.
bikes$dayWeek <- as.numeric(ordered(bikes$dayWeek, 
                                    levels = c("segunda-feira", 
                                               "terça-feira", 
                                               "quarta-feira", 
                                               "quinta-feira", 
                                               "sexta-feira", 
                                               "sábado", 
                                               "domingo")))

# Bloco2
# Se o seu sistema operacional estiver em inglês, execute o comando abaixo.
bikes$dayWeek <- as.numeric(ordered(bikes$dayWeek, 
                                    levels = c("Monday", 
                                               "Tuesday", 
                                               "Wednesday", 
                                               "Thursday", 
                                               "Friday", 
                                               "Saturday", 
                                               "Sunday")))

# Agora os dias da semana devem estar como valores numéricos
# Se estiverem como valores NA, volte e verifique se você seguiu as instruções acima.
str(bikes$dayWeek)
str(bikes)

## Adiciona uma variavel com valores unicos para o horario do dia para dias da semana e dias de fim de semana
## Com isso diferenciamos as horas dos dias da semana, das horas em dias de fim de semana
bikes$workTime <- ifelse(bikes$isWorking, bikes$hr, bikes$hr + 24) 

## Transforma os valores de hora na madrugada, quando a demanda por bibicletas eh praticamente nula 
bikes$xformHr <- ifelse(bikes$hr > 4, bikes$hr - 5, bikes$hr + 19)

## Adiciona uma variavel com valores unicos para o horario do dia para dias da semana e dias de fim de semana
bikes$xformWorkHr <- ifelse(bikes$isWorking, bikes$xformHr, bikes$xformHr + 24) 

# str(bikes)

## Gera saida no Azure ML
if(Azure) maml.mapOutputPort('bikes')