library(scales)
library(plotrix)
library(ggplot2)
library(dplyr)
library(ggrepel)
library(tidyverse)
library(ggmap) 


#Pega a base de dados e arruma pra ficar só as 5 maiores

dados <- read.csv("dados_RVOP009.csv")
df_temp <- data.frame(matrix(ncol = 0, nrow = 5))
contador <- 1

for (i in 2:ncol(dados)) {
  dados_ordenados <- dados[order(dados[, i], decreasing = TRUE), ]
  numero_reads <- head(dados_ordenados[, i], 5)
  lista_nomes <- dados_ordenados[dados_ordenados[, i] %in% numero_reads, 1]
  dados_amostras <- data.frame(lista_nomes)
  nomes_amostras <- paste0(colnames(dados)[i], "_A", contador)
  
  colnames(dados_amostras) <- nomes_amostras
  df_temp <- cbind(df_temp, dados_amostras)
  
  df_temp <- cbind(df_temp, setNames(data.frame(numero_reads), paste0("numero_reads_A", contador)))
  
  contador <- contador + 1
  print(dados_amostras)
}

write.table(df_temp, "output.tsv", sep="\t", row.names = FALSE)


#-------------------------------------------------------------------------------
#Pega a planilha, ajeita de uma foma específica e gera o gráfico de tudo junto bonitão

dados <- read.table("output.tsv", sep="\t", header=TRUE)

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
new_dataset$frequencia <- as.numeric(new_dataset$frequencia)
new_dataset <- transform(new_dataset, prop = frequencia / tapply(frequencia, my_class, sum)[my_class])

#Gráfico
ggplot(new_dataset) +
  aes(x = my_class, fill = variable, weight = frequencia) +
  scale_fill_manual(values = c("Influenza A virus" = "#74d600",
                               "Influenza B virus" = "#028900",
                               "Rhinovirus A" = "#7fcdff",
                               "Rhinovirus B" = "#1da2d8",
                               "Rhinovirus C" = "#064273",
                               "Severe acute respiratory syndrome-related coronavirus" = "#c30101",
                               "Outros" = "#979aaa")) +
  geom_bar(position = "fill") +
  geom_text(aes(label = paste0(round(prop * 100), "%"), y = prop), position = position_fill(vjust = 0.5)) +
  scale_x_discrete(labels = row.names(new_dataset)) +
  labs(x = "Amostras", y = "Frequência", fill = "Organismos mais relevantes", title = "Resultados RVOP Lote009") +
  theme_bw()





