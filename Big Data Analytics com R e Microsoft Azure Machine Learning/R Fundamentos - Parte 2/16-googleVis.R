# googleVis

install.packages('googleVis')
library(googleVis)
?googleVis

# Criando um Dataframe
df = data.frame(País = c('BR', 'CH', 'AR'),
                Exportações = c(10, 13, 14),
                Importações = c(23, 12, 32))

# Gráfico de Linha
Line <- gvisLineChart(df)
plot(Line)

# Gráfico de Barras
Column <- gvisColumnChart(df)
plot(Column)

# Gráfico de Barras Horizontais
Bar <- gvisBarChart(df)
plot(Bar)

# Gráfico de Pizza
Pie <- gvisPieChart(CityPopularity)
plot(Pie)

# Gráficos Combinados
Combo <- gvisComboChart(df, xvar = 'País',
                        yvar = c('Exportações', 'Importações'),
                        options = list(seriesType = 'bars',
                                       series = '{1:{type:"line"}}'))
plot(Combo)

# Gráfico de Dispersão
Scatter <- gvisScatterChart(women,
                            options=list(
                              legend='none',
                              lineWidth=2, pointSize=0,
                              title='Women', vAxis='{title:"weight (lbs)"}',
                              hAxis='{title:"height (in)"}',
                              width=300, height=300
                            ))
plot(Scatter)

# Gráfico de Bolhas
Bubble <- gvisBubbleChart(Fruits, idvar='Fruit',
                          xvar='Sales', yvar='Expenses',
                          colorvar='Year', sizevar='Profit',
                          options=list(
                            hAxis='{minValue:75, maxValue:125'
                          ))
plot(Bubble)

# Customizando
M <- matrix(nr=6, nc=6)
M[col(M)==row(M)] <- 1:6
dat <- data.frame(X=1.6, M)
SC <- gvisScatterChart(dat,
                       options=list(
                         title='Customizing points',
                         legend='right',
                         pointSize=30,
                         series='{
                         0: { pointShape: "circle" },
                         1: { pointShape: "triangle" },
                         2: { pointShape: "square" },
                         3: { pointShape: "diamond" },
                         4: { pointShape: "star" },
                         5: { pointShape: "polygon" },
                         }'
                       ))

plot(SC)

# Gauge
Gauge <- gvisGauge(CityPopularity,
                   options=list(
                     min=0,
                     max=800,
                     greenFrom=500,
                     greenTo=800,
                     yellowFrom=300,
                     yellowTo=500,
                     redFrom=0,
                     redTo=300,
                     width=400,
                     height=300
                   ))
plot(Gauge)

# Mapas
Intensity <- gvisIntensityMap(df)
plot(Intensity)

# Geo Chart
Geo <- gvisGeoChart(Exports, locationvar='Country',
                    colorvar='Profit',
                    options=list(projection='kavrayskiy-vii'))
plot(Geo)

# Google Maps
AndrewMap <- gvisMap(Andrew, 'LatLong', 'Tip',
                     options=list(showTip=T,
                                  showLine=T,
                                  enableScrollWheel=T,
                                  mapType='terrain',
                                  useMapTypeControl=T))
plot(AndrewMap)

# Dados em Gráfico. Nível de analfabetismo nos EUA
require(datasets)
states <- data.frame(state.name, state.x77)
GeoStates <- gvisGeoChart(states, 'state.name', 'Illiteracy',
                          options=list(region='US',
                                       deployMode='regions',
                                       resolution='provinces',
                                       width=600, height=400))
plot(GeoStates)
