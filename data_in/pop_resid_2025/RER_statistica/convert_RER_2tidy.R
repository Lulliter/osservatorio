# Conversione dati residenti per provincia in formato tidy ----
# Carica librerie ----
library(tidyverse)
library(readxl)
library(here)
library(fs)

# 1) Import dati popol x PROV----
input_dir <- here("data_in", "pop_resid_2025","RER_statistica", "raw")
output_dir <- here("data_in", "pop_resid_2025","RER_statistica")

file_path <- fs::path(input_dir, "resident_newProvMascFemmTota.xlsx")

# Leggi prima riga per estrarre fasce età ----
fasce_eta <- read_excel(file_path, sheet = "resident_newProvClasMascFemmTot", 
                        n_max = 1, col_names = FALSE) |>
  slice(1) |> select(-1) |> unlist() |> as.character() |> na.omit() |>
  str_remove("anni") |> str_trim()

# Leggi dati veri saltando prima riga header ----
raw_data <- read_excel(file_path, sheet = "resident_newProvClasMascFemmTot", 
                       skip = 1)

# Genera nomi colonne completi ----
col_names <- c("provincia", 
               map(fasce_eta, ~c(paste0(.x, "_M"), paste0(.x, "_F"), 
                                 paste0(.x, "_Tot"))) |> unlist())

# Controlla se raw_data ha 3 colonne in più rispetto a col_names (Ovvero i tot_tutte_età, oltre le singole fasce)
# Se si, vengono chiamate "Totale_*" e interpretate come totale fasce età 
if (ncol(raw_data) == length(col_names) + 3) {
  col_names <- c(col_names, "Totale_M", "Totale_F", "Totale_Tot")
}

# Assegna nomi colonne e converti in formato tidy ----
resident_prov_eta5_sex <- raw_data |>
  set_names(col_names[1:ncol(raw_data)]) |>
  filter(!is.na(provincia)) |>
  pivot_longer(cols = -provincia, names_to = "variabile", 
               values_to = "residenti") |>
  separate(variabile, into = c("fascia_eta", "genere"), sep = "_") |>
  mutate(
    residenti = as.numeric(residenti),
    genere = case_when(genere == "M" ~ "Maschi", genere == "F" ~ "Femmine",
                       genere == "Tot" ~ "Totale", TRUE ~ genere)
  ) |>
  mutate(fascia_eta =  case_when(
    fascia_eta == "Totale" ~ "Tutte_eta",
    TRUE ~ fascia_eta
  )) |>
  select(provincia, fascia_eta, genere, residenti)

# Verifica risultato ----
# glimpse(data_tidy)
# head(data_tidy, 20)

# Salva dati in formato RDS e XLSX ----
saveRDS(resident_prov_eta5_sex, 
        file = fs::path(output_dir, "resident_prov_eta5_sex.rds"))

writexl::write_xlsx(resident_prov_eta5_sex, 
                    path = fs::path(output_dir, "resident_prov_eta5_sex.xlsx"))


# ___ ------------
# 2) Import dati popol x DISTRETTO ----
file_path <- fs::path(input_dir, "resident_newDistClasMascFemmTota.xlsx")

# Leggi prima riga per estrarre fasce età ----
fasce_eta <- read_excel(file_path, sheet = "resident_newDistClasMascFemmTot", 
                        n_max = 1, col_names = FALSE) |>
  slice(1) |> select(-1) |> unlist() |> as.character() |> na.omit() |>
  str_remove("anni") |> str_trim()

# Leggi dati veri saltando prima riga header ----
raw_data <- read_excel(file_path, sheet = "resident_newDistClasMascFemmTot", 
                       skip = 1)

# Genera nomi colonne completi ----
col_names <- c("provincia", 
               map(fasce_eta, ~c(paste0(.x, "_M"), paste0(.x, "_F"), 
                                 paste0(.x, "_Tot"))) |> unlist())

# Controlla se raw_data ha 3 colonne in più rispetto a col_names (Ovvero i tot_tutte_età, oltre le singole fasce)
# Se si, vengono chiamate "Totale_*" e interpretate come totale fasce età 
if (ncol(raw_data) == length(col_names) + 3) {
  col_names <- c(col_names, "Totale_M", "Totale_F", "Totale_Tot")
}

# Assegna nomi colonne e converti in formato tidy ----
resident_distr_eta_sex <- raw_data |>
  set_names(col_names[1:ncol(raw_data)]) |>
  filter(!is.na(provincia)) |>
  mutate(provincia = provincia |>
    str_replace_all("Ï", "ì") |>
    str_replace_all("‡", "à") |>
    str_replace_all("Ë", "è") |>
    str_replace_all("È", "é") |>
    str_replace_all("˜", "ò") |>
    str_replace_all("Û", "ó") |>
    str_replace_all("¸", "ù") |>
    str_replace_all("˘", "ú")
  ) |>
  pivot_longer(cols = -provincia, names_to = "variabile",
               values_to = "residenti") |>
  separate(variabile, into = c("fascia_eta", "genere"), sep = "_") |>
  mutate(
    residenti = as.numeric(residenti),
    genere = case_when(genere == "M" ~ "Maschi", genere == "F" ~ "Femmine",
                       genere == "Tot" ~ "Totale", TRUE ~ genere)
  ) |>
  mutate(fascia_eta =  case_when(
    fascia_eta == "Totale" ~ "Tutte_eta",
    TRUE ~ fascia_eta
  )) |>
  select(provincia, fascia_eta, genere, residenti)

# Verifica risultato ----
# glimpse(data_tidy)
# head(data_tidy, 20)

# Salva dati in formato RDS e XLSX ----
saveRDS(resident_distr_eta_sex, 
        file = fs::path(output_dir, "resident_distr_eta_sex.rds"))

writexl::write_xlsx(resident_distr_eta_sex, 
                    path = fs::path(output_dir, "resident_distr_eta_sex.xlsx"))
