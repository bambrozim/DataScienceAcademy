Azure <- F


if(Azure){
  Pesquisa <- maml.mapInputPort(1)
  install.packages("src/tibble_1.4.2.zip", lib = ".", repos = NULL, verbose = TRUE)
  install.packages("src/tidyr_0.8.2.zip", lib = ".", repos = NULL, verbose = TRUE)
  install.packages("src/rlang_0.1.1.zip", lib = ".", repos = NULL, verbose = TRUE)
  require(tibble, lib.loc = ".")
  require(tidyr, lib.loc = ".")
  require(rlang, lib.loc = ".")
}else{
  Pesquisa <- read.csv("pesquisa.csv", sep = ",", header = T, stringsAsFactors = F )
  require(tidyr)
}

df <- spread(Pesquisa, Questao, Resposta)
df

Pesquisa2 <- gather(df, Resposta, value, 2:6)
Pesquisa2

if(Azure) maml.mapOutputPort("df")