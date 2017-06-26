library(tidyverse)
library(stringr)

hcdm <- read_tsv("hcdm.tsv")
gene_info <- read_tsv("~/Project/gene-trend/data/current/Homo_sapiens.gene_info")

hcdm %>%
    left_join(gene_info, by = c('NCBI_NAME' = 'Symbol')) %>%
    dplyr::select(CD_NAME, NCBI_NAME, GeneID, Synonyms, map_location,
                  description, Other_designations) %>%
    mutate(Synonyms = map_chr(Synonyms,
                              ~str_replace_all(.x, '\\|', ' '))) %>%
    mutate(Other_designations = map_chr(Other_designations,
                                        ~str_replace_all(.x, '\\|', '; '))) %>%
    write_csv("hcdm.csv", na = '-')
