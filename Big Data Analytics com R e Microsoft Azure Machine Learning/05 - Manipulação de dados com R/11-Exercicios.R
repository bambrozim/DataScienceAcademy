# Exercicios Capitulo 5

# Exercicio 1 -Encontre e faça a correção do erro na instrução abaixo:
url <-'http://espn.go.com/nfl/superbowl/history/winners'
pagina <-read_html(url)
tabela <-html_nodes(pagina, 'table')
tab <-tab[-(1:2), ]
names(tab) <-c("number", "date", "site", "result","score")

url <-'http://espn.go.com/nfl/superbowl/history/winners'
pagina <-read_html(url)
tabela <-html_nodes(pagina, 'table')
tab <-tab[-(1:2), ]
names(tab) <-c("number", "date", "site", "result")

# Exercicio 2 -Encontre e faça a correção do erro na instrução abaixo:
library(ggplot2)
data(mpg)
data <-mpg[,c(1,7:9)]
str(data)
ddply(data, (manufacturer), summarize, avgcty = mean(cty))

library(ggplot2)
data(mpg)
data <-mpg[,c(1,7:9)]
str(data)
ddply(data, .(manufacturer), summarize, avgcty = mean(cty))


# Exercicio 3 -Encontre e faça a correção do erro na instrução abaixo:
ibrary(reshape2)
df = data.frame(nome = c("Zico", "Pele"), chuteira = c(40, 42),
                idade = c(34,NA), peso = c(93, NA), altura = c(175, 178))
dfdf_wide = mel(df, id = c("nome", "chuteira"))
df_wide

library(reshape2)
df = data.frame(nome = c("Zico", "Pele"), chuteira = c(40, 42),
                idade = c(34,NA), peso = c(93, NA), altura = c(175, 178))
df_wide = melt(df, id = c("nome", "chuteira"))
df_wide

# Exercicio 4 -Encontre e faça a correção do erro na instrução abaixo:
library(zoo)
precos <-c(134.50, 135.89, 130.00, 129.80, 132.97)
datas <-as.Date(('2010-01-04', '2010-01-05', '2010-01-06', '2010-01-07', '2010-01-08'))
tsdata <-zoo(precos, datas)

library(zoo)
precos <-c(134.50, 135.89, 130.00, 129.80, 132.97)
datas <-as.Date('2010-01-04', '2010-01-05', '2010-01-06', '2010-01-07', '2010-01-08')
tsdata <-zoo(precos, datas)
