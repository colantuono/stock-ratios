#### limpeza ####
# rm(list=ls()) ## limpa enviroment
if(!is.null(dev.list())) dev.off() ## limpa plots
gc() ## limpa memória do PC
cat("\014") ## limpa console

#### Carrega Pacotes ####
if(!require(devtools)){install.packages("devtools");library(devtools)}
if(!require(quantmod)){install.packages("quantmod");library(quantmod)}
if(!require(tidyverse)){install.packages("tidyverse");library(tidyverse)}
if(!require(rbcb)){devtools::install_github("wilsonfreitas/rbcb");library(rbcb)}

#### MAGIC ####
## create the tickers
tickers = c('^BVSP', 'CSNA3.SA')
startDate <- "2016-01-01" ## analysis period
endDate <- Sys.Date()

## downloading historical series 
getSymbols(tickers, from = startDate, to = endDate, src = "yahoo")

## calculating benchmark return
stock_ret <- as.data.frame(monthlyReturn(CSNA3.SA))
benchmark_ret <- as.data.frame(monthlyReturn(BVSP))

## calculating ratios
juros <- as.data.frame(rbcb::get_series(c(11), last = 1, as = "xts"))[1,1] ## interest rate

sharpe <- function(mean, interest, stdev){
(mean - interest) / stdev
} ## sharpe function

benchmark_mean <- mean(benchmark_ret$monthly.returns)
benchmark_variance <- var(benchmark_ret$monthly.returns)
benchmark_stdev <- sd(benchmark_ret$monthly.returns)
benchmark_sharpe <- sharpe(benchmark_mean, juros, benchmark_stdev)

stock_mean <- mean(stock_ret$monthly.returns)
stock_variance <- var(stock_ret$monthly.returns)
stock_stdev <- sd(stock_ret$monthly.returns)
stock_sharpe <- sharpe(stock_mean, juros, stock_stdev)

benchmark_vec <- benchmark_ret[1:nrow(stock_ret),]
covar <- cov(benchmark_vec, stock_ret$monthly.returns)

Beta <- (covar - benchmark_variance) / stock_sharpe
Alpha <- (stock_mean - juros - Beta * (benchmark_mean - juros)) * 100

#### limpeza ####
gc() ## limpa memória do PC
cat("\014") ## limpa console

#### Results ####
tickers[2:length(tickers)]
benchmark_sharpe # average return in excess of risk-free rate
stock_sharpe # average return in excess of risk-free rate
Beta # volatility of a stock compared to the benchmark index
Alpha # excess returns above benchmark
