#### carrega os pacotes ####
# devtools::install_github('wilsonfreitas/rbcb')
# devtools::install_github("tbrugz/ribge")
# install.packages("GetTDData")
# install.packages("httr")
install.packages()

library(rbcb)
library(ribge)
library(quantmod)
library(GetTDData)
library(httr)
library(jsonlite)
library(tidyverse)

#### carrega dados####
## IPCA
ipca <- as.data.frame(rbcb::get_series(c(IPCA = 433), last = 120, as = "xts"))
ipca$periodo <- row.names(ipca)

## PIB
pib <- precos_deflatorpib()
pib$ano_str2 <- paste0(as.character(pib$ano),"-","01","-","01")

## DESEMPREGO
desemp <- series_estatisticas_carrega_todas_localidades("PE62_RM_PERC", transpose = T)
desemp2 <- desemp[,c(1,20)]
names(desemp2) <- c("mes","total")
nrow(desemp2)
desemp2 <- desemp2[c(3:nrow(desemp2)),]

#### json ####
# query <- GET("https://servicodados.ibge.gov.br/api/v3/agregados/6380/periodos/201203|201204|201205|201206|201207|201208|201209|201210|201211|201212|201301|201302|201303|201304|201305|201306|201307|201308|201309|201310|201311|201312|201401|201402|201403|201404|201405|201406|201407|201408|201409|201410|201411|201412|201501|201502|201503|201504|201505|201506|201507|201508|201509|201510|201511|201512|201601|201602|201603|201604|201605|201606|201607|201608|201609|201610|201611|201612|201701|201702|201703|201704|201705|201706|201707|201708|201709|201710|201711|201712|201801|201802|201803|201804|201805|201806|201807|201808|201809|201810|201811|201812|201901|201902|201903|201904|201905|201906|201907|201908|201909|201910|201911|201912|202001|202002|202003|202004|202005|202006|202007|202008|202009|202010|202011|202012|202101|202102|202103/variaveis/4098?localidades=N1[all]")
# convert <- rawToChar(query$content)  
# class(convert)
# extract <- fromJSON(convert)
# desemp <- as.data.frame(extract)
# desemp2 <- as.data.frame(desemp[[4]])
# desemp3 <- as.data.frame(desemp2[[2]])

periodo <- colnames(desemp3) 

## TESOURO DIRETO
dl.folder ='TD Files'
download.TD.data(asset.codes = NULL, dl.folder = dl.folder, n.dl = 1)
Tesouro_Direto <- read.TD.files(dl.folder = dl.folder, maturity =)


#### tratamento de dados ####



#### teste grafico ####
chartSeries(ipca)
chartSeries(pib, yrange = T)





