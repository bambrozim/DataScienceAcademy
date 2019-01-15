# Prevendo a Ocorrência de Câncer

## Etapa 1 - Coletando os Dados

# O diagnóstico é codificado como "M" para indicar maligno ou "B" para indicar benigno.
dados <- read.csv("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/ML/bc_data.csv", stringsAsFactors = FALSE)
str(dados)
head(dados)


## Etapa 2 - Explorando os Dados

# Excluindo a coluna ID
dados <- dados[-1]
str(dados)
any(is.na(dados))

# Transformando para factor
table(dados$diagnosis)
dados$diagnosis <- factor(dados$diagnosis, levels = c("B", "M"), labels = c("Benigno", "Maligno"))
str(dados$diagnosis)

# Verificando a proporção
round(prop.table(table(dados$diagnosis)) * 100, digits = 1) 

# Medidas de Tendência Cetral
summary(dados[c("radius_mean", "area_mean", "smoothness_mean")])

# Criando um função de normalização
normalizar <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# Normalizando os dados
dados_norm <- as.data.frame(lapply(dados[2:31], normalizar))

# Confirmando que a normalização funcionou
summary(dados[c("radius_mean", "area_mean", "smoothness_mean")])
summary(dados_norm[c("radius_mean", "area_mean", "smoothness_mean")])


## Etapa 3: Treinando o modelo

# Carregando o pacote library
library(class)

# Criando dados de treino e dados de teste
dados_treino <- dados_norm[1:469, ]
dados_teste <- dados_norm[470:569, ]

# Criando os labels para os dados de treino e de teste
dados_treino_labels <- dados[1:469, 1]
dados_teste_labels <- dados[470:569, 1]
length(dados_treino_labels)
length(dados_teste_labels)

# Criando o modelo
modelo <- knn(train = dados_treino, 
              test = dados_teste,
              cl = dados_treino_labels, 
              k = 21)


## Etapa 4: Avaliando e Interpretando o Modelo

# Carregando o gmodels
install.packages("gmodels")
library(gmodels)

# Criando uma tabela cruzada dos dados previstos x dados atuais
# Usaremos amostra com 100 observações: length(dados_teste_labels)
CrossTable(x = dados_teste_labels, y = modelo, prop.chisq = FALSE)


## Etapa 5: Otimizando a performance do modelo

# Usando a função scale() para padronizar o z-score 
dados_z <- as.data.frame(scale(dados[-1]))

# Confirmando transformação realizada com sucesso
summary(dados_z$area_mean)

# Criando novos datasets de treino e de teste
dados_treino <- dados_z[1:469, ]
dados_teste <- dados_z[470:569, ]

dados_treino_labels <- dados[ 1: 469, 1] 
dados_teste_labels <- dados[ 470: 569, 1]

# Reclassificando
modelo_v2 <- knn(train = dados_treino, 
                 test = dados_teste,
                 cl = dados_treino_labels, 
                 k = 21)

# Criando uma tabela cruzada dos dados previstos x dados atuais
CrossTable(x = dados_teste_labels, y = modelo_v2, prop.chisq = FALSE)

# Testando diferentes valores para k
# Criando dados de treino e dados de teste
dados_treino <- dados_norm[1:469, ]
dados_teste <- dados_norm[470:569, ]

# Criando os labels para os dados de treino e de teste
dados_treino_labels <- dados[1:469, 1]
dados_teste_labels <- dados[470:569, 1]

# Valores diferentes para k
modelo_v3 <- knn(train = dados_treino, 
                 test = dados_teste, 
                 cl = dados_treino_labels, 
                 k = 1)
CrossTable(x = dados_teste_labels, y = modelo_v3, prop.chisq = FALSE)

modelo_v4 <- knn(train = dados_treino, 
                 test = dados_teste, 
                 cl = dados_treino_labels, 
                 k = 5)
CrossTable(x = dados_teste_labels, y = modelo_v4, prop.chisq = FALSE)

modelo_v5 <- knn(train = dados_treino, 
                 test = dados_teste, 
                 cl = dados_treino_labels, 
                 k = 11)
CrossTable(x = dados_teste_labels, y = modelo_v5, prop.chisq=FALSE)

modelo_v6 <- knn(train = dados_treino, 
                 test = dados_teste, 
                 cl = dados_treino_labels, 
                 k = 15)
CrossTable(x = dados_teste_labels, y = modelo_v6, prop.chisq = FALSE)

modelo_v7 <- knn(train = dados_treino, 
                 test = dados_teste, 
                 cl = dados_treino_labels, 
                 k = 27)
CrossTable(x = dados_teste_labels, y = modelo_v7, prop.chisq = FALSE)

modelo_v2 <- knn(train = dados_treino, 
                 test = dados_teste,
                 cl = dados_treino_labels, 
                 k = 21)
CrossTable(x = dados_teste_labels, y = modelo_v2, prop.chisq = FALSE)


## Calculando a taxa de erro
prev = NULL
taxa_erro = NULL

suppressWarnings(
  for(i in 1:20){
    set.seed(101)
    prev = knn(train = dados_treino, test = dados_teste, cl = dados_treino_labels, k = i)
    taxa_erro[i] = mean(dados$diagnosis != prev)
  })

# Obtendo os valores de k e das taxas de erro
library(ggplot2)
k.values <- 1:20
df_erro <- data.frame(taxa_erro, k.values)
df_erro

# À medida que aumentamos k, diminuímos a taxa de erro do modelo
ggplot(df_erro, aes(x = k.values, y = taxa_erro)) + geom_point()+ geom_line(lty = "dotted", color = 'red')
