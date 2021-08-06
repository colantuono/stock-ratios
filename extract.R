#### LIMPEZA ####
#  rm(list=ls()) ## limpa enviroment
# if(!is.null(dev.list())) dev.off() ## limpa plots
gc() ## limpa memória do PC
cat("\014") ## limpa console

#### carrega os pacotes ####
# devtools::install_github('wilsonfreitas/rbcb')
# devtools::install_github("tbrugz/ribge")
# install.packages("GetTDData")
# install.packages("patchwork")

library(rbcb)
library(ribge)
library(GetTDData)
library(ggplot2)
library(patchwork)


#### carrega dados####
dados_econ <- rbcb::get_series(c(IPCA = 433, 
							   PIB = 4385,
							   SELIC= 4390,
							   DESEMP = 10777
							   ), last = 173, as = "data.frame")

# ## TESOURO DIRETO
# dl.folder ='TD Files'
# download.TD.data(asset.codes = NULL, dl.folder = dl.folder, n.dl = 1)
# Tesouro_Direto <- read.TD.files(dl.folder = dl.folder, maturity =)
# df.yield <- get.yield.curve()
# str(df.yield)

#### tratamento de dados ####
dados <- dados_econ[["IPCA"]]
dados <- cbind(dados, 
			   dados_econ[["SELIC"]][,2],
			   dados_econ[["DESEMP"]][,2],
			   dados_econ[["PIB"]][,2])
names(dados) <- c("data", "ipca", "selic", "desemp", "pib")

dados$pib_shift <- dados$pib
dados$pib_shift <- c(NA, head(dados["pib_shift"], dim(dados)[1] - 1)[[1]])
dados$pib_variacao <- round(((dados$pib - dados$pib_shift) / dados$pib), 5)

#### teste grafico ####
p0 <-	ggplot() +
		geom_line(data = dados, aes(x = data, y = ipca, color = "IPCA")) + 
		geom_line(data = dados, aes(x = data, y = selic, color = "SELIC")) +
		geom_line(data = dados, aes(x = data, y = desemp, color = "DESEMP")) +
		geom_line(data = dados, aes(x = data, y = pib_variacao, color = "PIB")) +
		geom_point(data = dados, aes(x = data, y = ipca, color = "IPCA"), size=1) + 
		geom_point(data = dados, aes(x = data, y = selic, color = "SELIC"), size=1) +
		geom_point(data = dados, aes(x = data, y = desemp, color = "DESEMP"), size=1) +
		geom_point(data = dados, aes(x = data, y = pib_variacao, color = "PIB"), size=1) +
		scale_y_continuous(breaks = round(seq(min(dados$ipca), max(dados$desemp), by = 1), 1)) +
		scale_x_continuous(breaks = seq(min(dados$data), max(dados$data), by = 360)) +
		scale_color_manual(name = "Séries", values = c("IPCA" = "red", 
													   "SELIC" = "blue",
													   "DESEMP" = "black",
													   "PIB" = "green")) +
		labs(x = "Data", y = "Mudança Percentual") + 
		theme(legend.position = "right") + 
		theme_dark()



p1 <-	ggplot() +
	geom_line(data = dados, aes(x = data, y = ipca, color = "IPCA")) + 
	geom_line(data = dados, aes(x = data, y = selic, color = "SELIC")) +
	geom_line(data = dados, aes(x = data, y = pib_variacao, color = "PIB")) +
	geom_point(data = dados, aes(x = data, y = ipca, color = "IPCA"), size=1) + 
	geom_point(data = dados, aes(x = data, y = selic, color = "SELIC"), size=1) +
	geom_point(data = dados, aes(x = data, y = pib_variacao, color = "PIB"), size=1) +
	scale_y_continuous(breaks = round(seq(min(dados$ipca), max(dados$ipca), by = 0.3), 1)) +
	scale_x_continuous(breaks = seq(min(dados$data), max(dados$data), by = 360)) +
	scale_color_manual(name = "Séries", values = c("IPCA" = "red", 
												   "SELIC" = "blue",
												   "PIB" = "green")) +
	labs(x = "Data", y = "Mudança Percentual") + 
	theme(legend.position = "right") + 
	theme_dark()

p2 <-	ggplot() +

	geom_line(data = dados, aes(x = data, y = desemp, color = "DESEMP")) +
	geom_point(data = dados, aes(x = data, y = desemp, color = "DESEMP"), size=1) +

	scale_y_continuous(breaks = round(seq(min(dados$desemp), max(dados$desemp), by = 1), 1)) +
	scale_x_continuous(breaks = seq(min(dados$data), max(dados$data), by = 360)) +
	scale_color_manual(name = "Séries", values = c("DESEMP" = "black")) +
	labs(x = "Data", y = "Mudança Percentual") + 
	theme(legend.position = "right") + 
	theme_dark()

p0
p1
p2


seq(min(dados$data), max(dados$data), by = 360)
