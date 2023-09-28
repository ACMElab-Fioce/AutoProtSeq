library(scales)
library(plotrix)
library(ggplot2)
library(dplyr)
library(ggrepel)
library(tidyverse)
library(ggmap) 
library(tidyverse)
library(forcats)

setwd("C:/Users/pedro/OneDrive/Área de Trabalho/Pedro/extras/hibridização/vsp")

#Pega a base de dados e arruma pra ficar só as 5 maiores
dados <- read.csv("combined_sample_taxon_results_NR.r.csv", sep=';')

colunas <- sort(colnames(dados), decreasing = TRUE)
dados <- dados[, colunas]

df_temp <- data.frame(matrix(ncol = 0, nrow = 5))
contador <- 1

for (i in 2:ncol(dados)) {
  dados_ordenados <- dados[order(dados[, i], decreasing = TRUE), ]
  numero_reads <- head(dados_ordenados[, i], 5)
  lista_nomes <- head(dados_ordenados$Taxon.Name, 5)
  dados_amostras <- data.frame(lista_nomes)
  nomes_amostras <- paste0(colnames(dados)[i], "_A", contador)
  colnames(dados_amostras) <- nomes_amostras
  df_temp <- cbind(df_temp, dados_amostras)
  df_temp <- cbind(df_temp, setNames(data.frame(numero_reads), paste0("numero_reads_A", contador)))
  contador <- contador + 1
  print(dados_amostras)
}

write.table(df_temp, "output.csv", sep=";", row.names = FALSE)


#-------------------------------------------------------------------------------
#Pega a planilha e ajeita de uma forma específica para as análises posteriore
dados <- read.table("output.csv", sep=";", header=TRUE)

odd_columns <- colnames(dados)[seq(1, ncol(dados), by = 2)]
samples <- unique(odd_columns)
repetitions <- 5
new_dataset <- data.frame(my_class = rep(samples, each = repetitions), stringsAsFactors = FALSE)

#Organimsos de cada amostra
column_data <- dados[, seq(1, ncol(dados), by = 2)]
variable_data <- unlist(column_data)

new_dataset$variable <- variable_data

#Quantitativo do número de reads
column_data <- dados[, seq(2, ncol(dados), by = 2)]
frequencia_data <- unlist(column_data)

new_dataset$frequencia <- frequencia_data

new_dataset$my_class <- factor(new_dataset$my_class)
new_dataset$frequencia <- gsub("\\.", "", new_dataset$frequencia)
new_dataset$frequencia <- as.numeric(new_dataset$frequencia)
new_dataset <- transform(new_dataset, prop = frequencia / tapply(frequencia, my_class, sum)[my_class])

new_dataset$my_class <- factor(new_dataset$my_class, levels = samples)

write.table(new_dataset, "new_output.csv", sep=";", row.names = FALSE)





