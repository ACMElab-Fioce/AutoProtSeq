library(scales)
library(plotrix)
library(ggplot2)
library(dplyr)
library(ggrepel)
library(tidyverse)
library(ggmap) 


#Pega a base de dados e arruma pra ficar só as 5 maiores

dados <- read.csv("combined_sample_taxon_results_NR.r.csv", sep=";")
df_temp <- data.frame(matrix(ncol = 0, nrow = 5))

for (i in 2:ncol(dados)) {
  dados_ordenados <- dados[order(dados[, i], decreasing = TRUE), ]
  numero_reads <- head(dados_ordenados[, i], 5)
  lista_nomes <- dados_ordenados[dados_ordenados[, i] %in% numero_reads, 1]
  dados_amostras <- data.frame(lista_nomes)
  nomes_amostras <- paste0(colnames(dados)[i], "_A", i-1)
  
  colnames(dados_amostras) <- nomes_amostras
  df_temp <- cbind(df_temp, dados_amostras)
  print(nomes_amostras)
  df_temp <- cbind(df_temp, setNames(data.frame(numero_reads), paste0("numero_reads_A", i-1)))
  df_taxon_reads <- cbind(dados_amostras, setNames(data.frame(numero_reads), paste0("numero_reads_A", i-1)))
  # print(df_taxon_reads)
  colnames(df_taxon_reads) <- c("taxon", "reads")
  df_taxon_reads$reads_log10 <- log10(df_taxon_reads$reads)
  
  df_log <- df_taxon_reads %>%
    mutate(csum = rev(cumsum(rev(reads_log10))),
           pos = reads_log10/2 + lead(csum, 1),
           pos = if_else(is.na(pos), reads_log10/2, pos),
           perc = (reads_log10/sum(reads_log10))*100)
  
  ggplot(df_log, aes(x = "" , y = reads_log10, fill = fct_inorder(taxon))) +
    geom_col(width = 1, color = 1) +
    coord_polar(theta = "y") +
    scale_fill_brewer(palette = "Pastel1") +
    geom_label_repel(data = df_log,
                     aes(y = pos, label = paste0(perc, "%")),
                     size = 4.5, nudge_x = 1, show.legend = FALSE) +
    guides(fill = guide_legend(title = "Taxons")) +
    theme_void() +
    theme(plot.background = element_rect(fill = "white"))+
    labs(title = paste0(nomes_amostras,"_log10"))
  ggsave(paste0(nomes_amostras,"_log10.png"), width = 20, height = 20, units = "cm")
  df <- df_taxon_reads %>% 
    mutate(csum = rev(cumsum(rev(reads))), 
           pos = reads/2 + lead(csum, 1),
           pos = if_else(is.na(pos), reads/2, pos),
           perc = (reads/sum(reads))*100)
  
  ggplot(df, aes(x = "" , y = reads, fill = fct_inorder(taxon))) +
    geom_col(width = 1, color = 1) +
    coord_polar(theta = "y") +
    scale_fill_brewer(palette = "Pastel1") +
    geom_label_repel(data = df,
                     aes(y = pos, label = paste0(perc, "%")),
                     size = 4.5, nudge_x = 1, show.legend = FALSE) +
    guides(fill = guide_legend(title = "Taxons")) +
    theme_void()+
    theme(plot.background = element_rect(fill = "white"))+
    labs(title = nomes_amostras)
  ggsave(paste0(nomes_amostras,".png"), width = 20, height = 20, units = "cm")
  
}

write.table(df_temp, "output.tsv", sep="\t", row.names = FALSE) #Resultado exportado