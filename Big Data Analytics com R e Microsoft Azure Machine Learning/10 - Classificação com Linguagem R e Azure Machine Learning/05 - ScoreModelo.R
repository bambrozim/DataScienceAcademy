## Previsoes com um modelo de classificacao baseado em randomForest
require(randomForest)
options(warn = -1)

# Gerando previsoes nos dados de teste
result_previsto <- data.frame(actual = Credit$CreditStatus,
                              previsto = predict(modelo, newdata = dados_teste))


# Visualizando o resultado
head(result_previsto)