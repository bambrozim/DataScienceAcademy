# Caret

# Instalando os pacotes
install.packages('caret')
install.packages('randomForest')

# Carregando os pacotes
library(caret)
library(datasets)

# Usando o dataset mtcars
data(mtcars)

# Função do Caret para divisão dos dados
?createDataPartition
split <- createDataPartition(y=mtcars$mpg, p=0.7, list=F)

# Criando dados de treino e de teste
dados_treino <- mtcars[split,]
dados_teste <- mtcars[-split,]

# Treinando o modelo
?train
names(getModelInfo())

# Regressão linear
modelo <- train(mpg~., data=dados_treino, method='lm')

# Regressão logística
modelo2 <- train(mpg~., data=dados_treino, method='glm')

# Random forest
modelo3 <- train(mpg~., data=dados_treino, method='rf')

# Resumo do modelo
summary(modelo)
summary(modelo2)
summary(modelo3)

# Ajustando o modelo
?expand.grid
?trainControl
controle1 <- trainControl(method='cv', number=10)

modelo_v2 <- train(mpg ~., data=mtcars, method='lm',
                   trControl=controle1,
                   metric='Rsquared')

# Resumo do modelo
summary(modelo_v2)

# Coletando os resíduos
residuals <- resid(modelo)

# Previsões
?predict
predictedValues <- predict(modelo)
plot(dados_treino$mpg, predictedValues)

# Mostrando a importância das variáveis
?varImp
varImp(modelo)

# Plot
plot(varImp(modelo))
