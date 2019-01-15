# Prevendo Despesas Hospitalares

# Etapa 1 - Coletando os dados
despesas <- read.csv("despesas.csv")
View(despesas)

# Etapa 2: Explorando e Preparando os Dados
# Visualizando as variáveis
str(despesas)

# Medias de Tendência Central da variável gastos
summary(despesas$gastos)

# Construindo um histograma
hist(despesas$gastos, main = 'Histograma', xlab = 'Gastos')

# Tabela de contingência das regiões
table(despesas$regiao)

# Explorando relacionamento entre as variáveis: Matriz de Correlação
cor(despesas[c("idade", "bmi", "filhos", "gastos")])

# Visualizando relacionamento entre as variáveis: Scatterplot
pairs(despesas[c("idade", "bmi", "filhos", "gastos")])

# Scatterplot Matrix
install.packages("psych")
library(psych)

# Este gráfico fornece mais informações sobre o relacionamento entre as variáveis
pairs.panels(despesas[c("idade", "bmi", "filhos", "gastos")])

# Etapa 3: Treinando o Modelo
modelo <- lm(gastos ~ idade + filhos + bmi + sexo + fumante + regiao, data = despesas)

# Similar ao item anterior
modelo <- lm(gastos ~ ., data = despesas)

# Visualizando os coeficientes
modelo

# Prevendo despesas médicas 
previsao <- predict(modelo)
class(previsao)
head(previsao)


# Etapa 4: Avaliando a Performance do Modelo
# Mais detalhes sobre o modelo
summary(modelo)


# Etapa 5: Otimizando a Performance do Modelo

# Adicionando uma variável com o dobro do valor das idades
despesas$idade2 <- despesas$idade ^ 2

# Adicionando um indicador para BMI >= 30
despesas$bmi30 <- ifelse(despesas$bmi >= 30, 1, 0)

# Criando o modelo final
modelo_v2 <- lm(gastos ~ idade + idade2 + filhos + bmi + sexo +
                  bmi30 * fumante + regiao, data = despesas)

summary(modelo_v2)

