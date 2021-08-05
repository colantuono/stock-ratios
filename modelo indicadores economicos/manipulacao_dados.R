#### carrega pacotes ####
# library(rbcb)
# library(ribge)
# library(GetTDData)
# library(httr)
# library(jsonlite)


library(quantmod)
library(ggplot2)
library(data.table)
library(ggplot2)
library(reshape2)
library(corrplot)


#### carrega dados ####
wd <- as.vector(getwd())
file <- as.vector("/datamart/manip.csv")
df <- read.csv(paste0(wd,file), sep=";")
rm(file, wd)

#### manipula dados ####
## nome das colunas
names(df)
summary(df)

## data as.Date
df$dta <- as.Date(df$dta)
df$periodo <- as.yearqtr(df$dta)

## valores as.numeric e decimal como ponto
source("decimal_ponto.R")
df <- as.data.frame(
	cbind(
		df[,1:2], 
		df[,3:ncol(df)] <- decimal_ponto(df[,3:ncol(df)])))
summary(df)

#### gráfico ####
df2 <- df[, c(4,5,7)]
class(df$dta)
row.names(df2) <- df$dta
df2$pib <- df2$pib.pibant
df2 <- as.xts(df2)

highchart(type = "stock") %>%
	hc_chart(zoomType = "x") %>%
	hc_add_series(name ="IPCA", data = df2$ipca, type="line", color = "green") %>%
	hc_add_series(name ="Desemp", data =  df2$desemp, type="line", color = "red") %>%
	hc_add_series(name ="PIB", data =  df2$pib, type="line", color = "black") 

#### modelling ####
names(df)

reg_model <- lm(df2$ipca ~ df2$pib)
a <- coefficients(reg_model)[1]
b <- coefficients(reg_model)[2]
reg_model
par(mfrow=c(2,2))
plot(reg_model)


summary(reg_model)


