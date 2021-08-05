## Aula 11 - QuantMod
library(quantmod)

##### importar dados ####
# getSymbols("GOOG", src = "yahoo")

##### definir periodo #####
startDate <- as.Date("2020-01-01")
endDate <- as.Date(Sys.Date()+1)

##### tickers ####
tickers <- c("^BVSP", "BTC-USD", "PETR4.SA")

##### captura de dados ####
getSymbols(tickers, src ="yahoo", from = startDate, to = endDate)
names(BVSP) <- c("Open", "High", "Low", "Close", "Volume", "Ajustado")

##### gráficos ####
chartSeries(BVSP)
chartSeries(BVSP, multi.col = T, theme = "white")

chartSeries(to.daily(BVSP), TA=NULL, 
             up.col = "white" , dn.col = "black", subset = "last 4 months")

##### timeframe mensal ####
chartSeries(to.monthly(BVSP), TA=NULL, 
            subset = "last 4 months", up.col = "white" , dn.col = "black")

##### indicadores tecnicos ####
library(TTR)
# chartSeries(PETR4.SA, TA = NULL) # retira o volume
addADX(8, SMA, F)
addBBands(20, 2, SMA) ## bollinger
addTRIX(7,4) ## trix
addCCI() ## cci
addOBV() ## obv
addSMI() ## stochastic
addSMA(25, on = 1) # simple moving average
add_DEMA() # > 1 exp moving average
add_VWAP() # vwap
addRSI() # rsi
addMACD() # macd


#### Grafico Na ####

tickers <- c("^BVSP")
getSymbols(tickers, src ="yahoo", from = startDate, to = endDate)
chartSeries(to.daily(BVSP), TA=NULL, 
            up.col = "white" , dn.col = "black", subset = "last 4 months")

addBBands(23, 2.38)
addCCI(50)
addCCI(8)
addMACD() 
addEMA(9, 1, col = "green")
addEMA(23, 1, col = "red")

#### limpeza ####
# rm(list=ls()) ## limpa enviroment
# dev.off(dev.list()["RStudioGD"]) ## limpa plots
# cat("\014") ## limpa console