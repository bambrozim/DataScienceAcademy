# Importação de outros Softwares Estatísticos

install.packages('haven')
library(haven)

# SAS
vendas <- read_sas('http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte4/vendas.sas7bdat')
?read_sas
class(vendas)
print(vendas)
str(vendas)


# Stata
df_stata <- read_dta('http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte4/mov.dta')
class(df_stata)
str(df_stata)


# Convertendo valores na coluna Date para datas
df_stata$Date <- as.Date(as_factor(df_stata$Date))
str(df_stata)
plot(df_stata)


# SPSS
pessoas <- read_sav('http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte4/pessoas.sav')
class(pessoas)
head(pessoas)



# Foreign
install.packages('foreign')
library(foreign)

# Stata
florida <- read.dta('http://datascienceacademy.com.br/blog/alunos/RFundamentos/Datasets/Parte4/florida.dta')
tail(florida)

# SPSS
dados <- read.spss('http://datascienceacademy.com.br/blog/alunos/RFundamentos/Datasets/Parte4/international.sav')
class(dados)
head(dados)
df <- data.frame(dados)
df
head(df)

# Criando um boxplot
boxplot(df$gdp)

