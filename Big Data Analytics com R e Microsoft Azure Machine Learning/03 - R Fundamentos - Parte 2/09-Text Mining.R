# Exemplo 1
install.packages(c('tm', 'SnowballC', 'wordcloud', 'RColorBrewer'))
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

# Carregando o dataset
df <- read.csv('questoes.csv', stringsAsFactors = F)
head(df)

# Criando um Corpus
dfCorpus <- Corpus(VectorSource(df$Question))
class(dfCorpus)


# Remove pontuação
dfCorpus <- tm_map(dfCorpus, removePunctuation)

# Remover palavras específicas do inglês
dfCorpus <- tm_map(dfCorpus, removeWords, stopwords('english'))

dfCorpus <- tm_map(dfCorpus, stemDocument)

# Removendo palavras específicas
dfCorpus <- tm_map(dfCorpus, removeWords, c('the', 'this', stopwords('english')))

# wordcloud
wordcloud(dfCorpus, max.words = 100, random.order = F)


# Exemplo 2

# Lendo o arquivo
arquivo <- 'http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt'
texto <- readLines(arquivo)

# Carregando os dados como Corpus
docs <- Corpus(VectorSource(texto))

# Pré-processamento
inspect(docs)
toSpace <- content_transformer(function(x, pattern) gsub(pattern, ' ', x))
docs <- tm_map(docs, toSpace, '/')
docs <- tm_map(docs, toSpace, '@')
docs <- tm_map(docs, toSpace, '\\|')

# Converte o texto para minúsculo
docs <- tm_map(docs, content_transformer(tolower))

# Remove números
docs <- tm_map(docs, removeNumbers)

# Remove as palavras mais comuns do idioma inglês
docs <- tm_map(docs, removeWords, stopwords('english'))

# Você pode definir um vetor de palavras (stopwords) a serem removidas do texto
docs <- tm_map(docs, removeWords, c('blabla1', 'blabla2'))

# Remove pontuação
docs <- tm_map(docs, removePunctuation)

# Elimina espaços extras
docs <- tm_map(docs, stripWhitespace)

# Text Steming
docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = T)
d <- data.frame(word=names(v), freq=v)
head(d, 10)

# wordcloud
set.seed(1234)
wordcloud(words=d$word, freq=d$freq, min.freq=1,
          max.words=200, random.order=F, rot.per=0.35,
          colors=brewer.pal(8, 'Dark2'))

# Tabela de frequência
findFreqTerms((dtm, lowfreq=4))
findAssocs(dtm, terms='freedom', corlimit = 0.3)
head(d, 10)

# Gráficos de barras com as palavras mais frequentes
barplot(d[1:10,]$freq, las=2, names.arg=d[1:10,]$word,
        col='lightblue', main='Most frequent words',
        ylab='Word frequencies')


# Exemplo 3
reviews <- read.csv('reviews.csv', stringsAsFactors = F)
str(reviews)
review_text <- paste(reviews$text, collapse=' ')
review_source <- VectorSource(review_text)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords('english'))
stopwords('english')
stm <- DocumentTermMatrix(corpus)
dtm2 <- as.matrix(dtm)
frequency <- colSums(dtm2)
frequency <- sort(frequency, decreasing = T)
head(frequency)
words <- names(frequency)
wordcloud(words[1:100], frequency[1:100])
