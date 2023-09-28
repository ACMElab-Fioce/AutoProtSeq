# install.packages("ggplot2")
# install.packages("ggrepel")
# install.packages("tidyverse")
library(ggplot2)
library(ggrepel)
library(tidyverse)

setwd("C:/Users/pedro/OneDrive/Área de Trabalho/Pedro/extras/hibridização/vsp")

dados <- read.csv("output.csv",sep=";")
numero_colunas <- ncol(dados)
coluna_maxima <- numero_colunas - 2
dados <- dados[, 1:coluna_maxima]


for (j in seq(2, coluna_maxima, by=2)) {
  
  i <- j-1
  
  temp_df <- dados[, i:j]
  nome_amostra <- colnames(temp_df)[1]
  colnames(temp_df)[1] <- "group"
  colnames(temp_df)[2] <- "bruto"
  # Get the positions
  df2 <- temp_df %>%
    mutate(value = round(bruto/sum(bruto), digits = 4)*100,
           csum = rev(cumsum(rev(value))),
           pos = value/2 + lead(csum, 1),
           pos = if_else(is.na(pos), value/2, pos))
  
  nome_grafico <- paste0(nome_amostra, ".jpg")
  
  grafico <- ggplot(df2, aes(x = "" , y = value, fill = fct_inorder(group))) +
    ggtitle(nome_amostra)+
    geom_col(width = 1, color = 1) +
    coord_polar(theta = "y") +
    scale_fill_brewer(palette = "Pastel1") +
    geom_label_repel(data = df2,
                     aes(y = pos, label = paste0(bruto," (",value, "%",")")),
                     size = 4.5, nudge_x = 1, show.legend = FALSE) +
    guides(fill = guide_legend(title = "Organismo")) +
    theme_void()+
    theme(panel.background = element_rect(fill = 'white', color = 'white'))

  ggsave(nome_grafico, plot = grafico, width = 16, height = 8, dpi = 600)
  

}

