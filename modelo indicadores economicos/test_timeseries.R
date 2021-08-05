#### carrega pacotes ####
# library(rbcb)
# library(ribge)
# library(GetTDData)
# library(httr)
# library(jsonlite)

library(xts)
library(quantmod)
library(tidyverse)
library(stringr)
library(stringi)
library(tseries)
library(graphics)
library(highcharter)
library(lubridate)
library(ggplot2)

#### carrega dados ####
wd <- as.vector(getwd())
file <- as.vector("/datamart/test.csv")
econ_data <- read.csv(paste0(wd,file), sep=";", header = F)

#### manipula dados ####
## nome das colunas
names(econ_data)

## valores as.numeric e decimal como ponto
econ_data$V1 <- str_replace(econ_data$V1, ",",".")
econ_data$V1 <- as.numeric(econ_data$V1)

## cria ts
econ_ts <- ts(econ_data, start = c(2012,1), frequency = 4)
print(econ_ts)
plot(econ_ts)
summary(econ_ts)

chart_Series(econ_ts)

#### plota gráficos ####
# plot(econ_data$dta, econ_data$pib, col="blue", type="l",
# 	 main = "PIB - Trimestral", xlab = "Tempo", ylab = "Valor ($)")
# plot(econ_data$dta, econ_data$ipca, col="blue", type="l",
# 	 main = "IPCA - Trimestral", xlab = "Tempo", ylab = "Valor (%)")
# plot(econ_data$dta, econ_data$desemp, col="blue", type="l",
# 	 main = "Desemprego - Trimestral", xlab = "Tempo", ylab = "Valor (%)")



