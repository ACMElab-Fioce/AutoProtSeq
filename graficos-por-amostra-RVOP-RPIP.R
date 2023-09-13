#Gráfico de proporção - amostras juntas
new_dataset <- read.csv("new_output.csv", sep=";")
grafico <- ggplot(new_dataset) +
  aes(x = my_class, fill = variable, weight = frequencia) +
  geom_bar(position = "fill") +
  #geom_text(aes(label = paste0(round(prop * 100), "%"), y = prop), position = position_fill(vjust = 0.5)) +
  scale_x_discrete(labels = row.names(new_dataset)) +
  labs(x = "Amostras", y = "Frequência", fill = "Organismos mais relevantes", title = "Resultados RPIP Lote004 - Reads Totais") +
  theme_bw() +
  scale_fill_manual(values = c("Escherichia marmotae" = "#d896ff",
                               "Rhodococcus sp. p52" = "#d896ff",
                               "Sphingomonas echinoides" = "#d896ff",
                               "Sphingomonas sp. AAP5" = "#d896ff",
                               "Escherichia coli" = "#d896ff",
                               "Aeromonas sp. ASNIH2" = "#d896ff",
                               "Burkholderia" = "#be29ec",
                               "Corynebacterium" = "#be29ec",
                               "Acinetobacter" = "#be29ec",
                               "Pseudomonas" = "#be29ec",
                               "Stenotrophomonas maltophilia" = "#be29ec",
                               "Klebsiella oxytoca" = "#be29ec",
                               "Burkholderia stabilis" = "#be29ec",
                               "Achromobacter xylosoxidans" = "#be29ec",
                               "Moraxella osloensis" = "#be29ec",
                               "Rothia dentocariosa" = "#be29ec",
                               "Staphylococcus" = "#be29ec",
                               "Ureaplasma parvum" = "#be29ec",
                               "Ureaplasma sp." = "#be29ec",
                               "Fusobacterium" = "#be29ec",
                               "Delftia acidovorans" = "#be29ec",
                               "Klebsiella variicola" = "#be29ec",
                               "Rhodococcus" = "#be29ec",
                               "Citrobacter koseri" = "#660066",
                               "Klebsiella quasipneumoniae" = "#660066",
                               "Staphylococcus aureus" = "#660066",
                               "Streptococcus pneumoniae" = "#660066",
                               "Klebsiella pneumoniae" = "#660066",
                               "Salmonella" = "#660066",
                               "Enterococcus faecium" = "#660066",
                               "Proteus mirabilis" = "#660066",
                               "Enterococcus faecalis" = "#660066",
                               "Burkholderia cepacia" = "#660066",
                               "Ureaplasma urealyticum" = "#660066",
                               "Candida albicans" = "#66b2b2",
                               "Candida tropicalis"= "#66b2b2",
                               "Aspergillus sydowii"= "#66b2b2",
                               "Acremonium sp. 11665 DLW-2010"= "#66b2b2",
                               "Aspergillus sp."= "#66b2b2",
                               "Influenza B virus" = "#4ebcff",
                               "SARS-CoV-2" = "#ff0000",
                               "Outros" = "#979aaa")) +
                               
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    axis.text = element_text(face = "bold", size = 12),
    axis.title = element_text(face = "bold", size = 16),
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 8, face = "bold"),
    axis.text.x = element_text(size = 8),
    axis.text.y = element_text(size = 8),
    axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))


ggsave("RPIP004-NS-5-EXEMPLAR1.jpg", plot = grafico, width = 16, height = 8, dpi = 600)

#-------------------------------------------------------------------------------


new_dataset <- read.csv("new_output.csv", sep=";")
new_dataset$patogen <- factor(new_dataset$patogen, levels= c("BAC_NAO_PAT", "BAC_POS_PAT", 
                                                             "BAC_PAT", "FUN_NAO_PAT", "Influenza B virus", 
                                                             "SARS-CoV-2"))
#Gráfico de proporção - amostras juntas
grafico <- ggplot(new_dataset) +
  aes(x = my_class, fill = patogen, weight = frequencia) +
  geom_bar(position = "fill") +
  #geom_text(aes(label = paste0(round(prop * 100), "%"), y = prop), position = position_fill(vjust = 0.5)) +
  scale_x_discrete(labels = row.names(new_dataset)) +
  labs(x = "Amostras", y = "Frequência", fill = "Organismos mais relevantes", title = "Resultados MiSeq - RPIP Lote005") +
  theme_bw() +
  scale_fill_manual(values = c("BAC_NAO_PAT" = "#d896ff",
                               "BAC_POS_PAT" = "#be29ec",
                               "BAC_PAT" = "#660066",
                               "FUN_NAO_PAT" = "#66b2b2",
                               "Influenza B virus" = "#4ebcff",
                               "SARS-CoV-2" = "#ff0000")) +
  theme(
    panel.border = element_rect(color = "black", fill = NA, size = 1),
    axis.text = element_text(face = "bold", size = 12),
    axis.title = element_text(face = "bold", size = 16),
    legend.title = element_text(size = 8, face = "bold"),
    legend.text = element_text(size = 6, face = "bold"),
    axis.text.x = element_text(size = 8),
    axis.text.y = element_text(size = 8),
    axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))


ggsave("RPIP005-MS-EXEMPLAR1.png", plot = grafico, width = 16, height = 8, dpi = 600)
  ggsave(paste0(nomes_amostras,".png"), width = 20, height = 20, units = "cm")
  
}

write.table(df_temp, "output.tsv", sep="\t", row.names = FALSE) #Resultado exportado
