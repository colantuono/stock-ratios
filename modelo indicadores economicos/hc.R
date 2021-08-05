rm(list=ls())

wd <- as.vector(getwd())
file <- as.vector("/datamart/manip.csv")
df <- read.csv(paste0(wd,file), sep=";")
source("decimal_ponto.R")
df <- as.data.frame(
	cbind(
		df[,1:2], 
		df[,3:ncol(df)] <- decimal_ponto(df[,3:ncol(df)])))
summary(df)
rm(file, wd)

df2 <- df[, c(4,5,7)]
class(df$dta)
row.names(df2) <- df$dta
df2 <- as.xts(df2)

highchart(type = "stock") %>%
	hc_chart(zoomType = "x") %>%
	hc_add_series(name ="IPCA", data = df2$ipca, type="line", color = "green") %>%
	hc_add_series(name ="Desemp", data =  df2$desemp, type="line", color = "red") %>%
	hc_add_series(name ="PIB", data =  df2$pib, type="line", color = "black") 


