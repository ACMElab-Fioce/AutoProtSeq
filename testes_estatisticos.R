dados <- read.csv("planilha.csv", sep=";")
amostra <- na.omit(dados$cov_133)

## Testes de normalidade
#H0: Os dados seguem uma distribuição normal
#H1: Os dados não seguem uma distribuição normal


# Shapiro-Wilk (n < 10)
shapiro.test(amostra)

#Kolmogorov-smirnov (n < 50)
ks.test(amostra, "pnorm", mean = mean(amostra), sd = sd(amostra))

# Anderson-Darling (n = 50 - 1000)
install.packages("nortest")
library(nortest)
ad.test(amostra)