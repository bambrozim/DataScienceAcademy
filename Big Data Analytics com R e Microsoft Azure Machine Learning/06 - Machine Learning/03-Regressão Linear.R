# Regressão Linear

# Carregando o dataset
df <- read.csv2('http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/ML/estudantes.csv')

# Explorando os dados
head(df)
summary(df)
str(df)
any(is.na(df))

install.packages('ggthemes')
library(ggplot2)
library(ggthemes)
library(dplyr)

# Obtendo apenas as colunas numéricas
colunas_numericas <- sapply(df, is.numeric)
colunas_numericas

# Filtrando as colunas numéricas para correlação
data_cor <- cor(df[,colunas_numericas])
data_cor
head(data_cor)

# Pacotes para visualizar a análise de correlação
install.packages('corrgram')
install.packages('corrplot')
library(corrplot)
library(corrgram)

# Criando um corrplot
corrplot(data_cor, method='color')

# Criando um corrgram
corrgram(df)
corrgram(df, order=T, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

# Criando um histograma
ggplot(df, aes(x = G3)) +
  geom_histogram(bins=20,
                 alpha=0.5, fill = 'blue') +
  theme_minimal()

# Treinando e Testando o Modelo
# Import Library
install.packages('caTools')
library(caTools)

# Criando as amostras de forma randômica
set.seed(101)
?sample.split
amostra <- sample.split(df$age, SplitRatio = 0.70)

# Criando dados de treino - 70% dos dados
treino <- subset(df, amostra==T)

# Criando dados de teste - 30% dos dados
teste = subset(df, amostra==F)

# Gerando o Modelo (Usando todos os atributos)
modelo_v1 <- lm(G3 ~ ., treino)
modelo_v2 <- lm(G3 ~ G2 + G1, treino)
modelo_v3 <- lm(G3 ~ absences, treino)
modelo_v4 <- lm(G3 ~ Medu, treino)

# Interpretando o Modelo
summary(modelo_v1)
summary(modelo_v2)
summary(modelo_v3)
summary(modelo_v4)

# Visualizando o Modelo e fazendo previsões

# Obtendo os resíduos
res <- residuals(modelo_v1)

# Convertendo o objeto para um dataframe
res <- data.frame(res)
head(res)

# Histograma dos resíduos
ggplot(res, aes(res)) +
  geom_histogram(fill='blue',
                 alpha=0.5,
                 binwidth=1)

# Fazendo as predições
modelo_v1 <- lm(G3 ~ ., treino)
prevendo_G3 <- predict(modelo_v1, teste)
prevendo_G3

# Visualizando os valores previstos e observados
resultados <- cbind(prevendo_G3, teste$G3)
colnames(resultados) <- c('Previsto', 'Real')
resultados <- as.data.frame(resultados)
resultados
min(resultados)

# Tratando os valores negativos
trata_zero <- function(x){
  if (x<0){
    return(0)
  }else{
    return(x)
  }
}

# Aplicando a função para tratar valores negativos em nossa previsão
resultados$Previsto <- sapply(resultados$Previsto, trata_zero)

# Calculando o erro médio
# MSE
mse <- mean((resultados$Real - resultados$Previsto)^2)
print(mse)

# Calculando R Squared
SSE <- sum((resultados$Previsto - resultados$Real)^2)
SST <- sum((mean(df$G3) - resultados$Real)^2)

# R-Squared
R2 <- 1 - (SSE/SST)
R2

