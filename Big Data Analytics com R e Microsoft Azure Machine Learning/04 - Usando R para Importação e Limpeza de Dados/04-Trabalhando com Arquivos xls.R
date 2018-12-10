# Requer Java
# XLConnect
# xlsx
# rJava

# Requer Perl
# gdata

# readxl

install.packages('rJava', type='source')
install.packages('xlsx')
install.packages('XLConnect')
install.packages('readxl')
install.packages('gdata')
library(readxl)
library(rJava)
library(xlsx)
library(XLConnect)
library(gdata)

# Pacote readxl

# Lista as worksheet no arquivo Excel
excel_sheets('UrbanPop.xlsx')

# Lendo a planilha do Excel
read_excel('UrbanPop.xlsx')
head(read_excel('UrbanPop.xlsx'))
read_excel('UrbanPop.xlsx', sheet = 'Period2')
read_excel('UrbanPop.xlsx', sheet = 3)
read_excel('UrbanPop.xlsx', sheet = 4)

# Importando uma worksheet para um dataframe
df <- read_excel('UrbanPop.xlsx', sheet = 3)
head(df)

# Importando todos os worksheets
df_todas <- lapply(excel_sheets('UrbanPop.xlsx'), read_excel, path = 'UrbanPop.xlsx')
df_todas
class(df_todas)


# Pacote XLConnect
arq1 = loadWorkbook('UrbanPop.xlsx')
df1 = readWorksheet(arq1, sheet='Period1', header=T)
df1
class(df)


# Pacote xlsx
df2 <- read.xlsx('UrbanPop.xlsx', sheetIndex = 1)
df2

df3 <- read.xlsx2('UrbanPop.xlsx',
                  sheetIndex = 1,
                  startRow = 2,
                  colIndex = 2)
df3

df4 <- readWorksheetFromFile('UrbanPop.xlsx',
                             sheet = 1,
                             startRow=4,
                             enCol=2)
df4

write.xlsx(df4, 'df4.xlsx', sheetName = 'Data Frame')
dir()


# Pacote gdata
arq1 <- xls2csv('df4.xlsx',
                sheet = 1,
                na.strings = 'EMPTY')
arq1
