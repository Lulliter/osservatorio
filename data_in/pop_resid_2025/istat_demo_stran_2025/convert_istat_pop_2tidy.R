# Conversione dati popolazione straniera residente per età in formato tidy ----
# Carica librerie ----
library(tidyverse)
library(readxl)
library(here)
library(fs)

# 1) Import dati PARMA ----
input_dir <- here("data_in", "istat_demo_stran_2025", "raw")
output_dir <- here("data_in", "istat_demo_stran_2025")

file_path <- fs::path(input_dir, "pop_stran_resid_PR.xlsx")

# Leggi dati ----
raw_data <- read_excel(file_path, sheet = "Sheet1") |>
  filter(!is.na(Età))

# Crea fasce quinquennali ----
resid_stran_eta5_sex_PR <- raw_data |>
  mutate(
    # Converti età in numerico, gestendo "100 e oltre"
    eta_num = case_when(
      Età == "100 e oltre" ~ 100,
      TRUE ~ as.numeric(Età)
    ),
    # Crea fasce quinquennali che corrispondono a resident_prov_eta5_sex
    fascia_eta = case_when(
      eta_num >= 90 ~ "90 e oltre",
      TRUE ~ paste0(
        floor(eta_num / 5) * 5,
        "-",
        floor(eta_num / 5) * 5 + 4
      )
    )
  ) |>
  # Aggrega per fasce quinquennali
  group_by(fascia_eta) |>
  summarise(
    Maschi = sum(Maschi, na.rm = TRUE),
    Femmine = sum(Femmine, na.rm = TRUE),
    Totale = sum(Totale, na.rm = TRUE),
    .groups = "drop"
  ) |>
  # Converti in formato lungo (tidy)
  pivot_longer(
    cols = c(Maschi, Femmine, Totale),
    names_to = "genere",
    values_to = "residenti"
  ) |>
  # Aggiungi colonna territorio
  mutate(
    territorio = "Parma",
    anno = 2025
  ) |>
  # Riordina colonne
  select(territorio, anno, fascia_eta, genere, residenti) |>
  # Ordina le fasce di età per corrispondere a resident_prov_eta5_sex
  arrange(
    match(fascia_eta, c(
      "0-4", "5-9", "10-14", "15-19", "20-24", "25-29",
      "30-34", "35-39", "40-44", "45-49", "50-54", "55-59",
      "60-64", "65-69", "70-74", "75-79", "80-84", "85-89",
      "90 e oltre"
    ))
  )

# Verifica risultato ----
glimpse(resid_stran_eta5_sex_PR)
head(resid_stran_eta5_sex_PR, 20)

# Salva dati in formato RDS e XLSX ----
saveRDS(resid_stran_eta5_sex_PR,
        file = fs::path(output_dir, "resid_stran_eta5_sex_PR.rds"))

writexl::write_xlsx(resid_stran_eta5_sex_PR,
                    path = fs::path(output_dir, "resid_stran_eta5_sex_PR.xlsx"))

cat("\n✓ Dati salvati in:", output_dir, "\n")

# ___________________________ --------------------------------------------------
# 2) Import dati ER ----

file_path_ER <- fs::path(input_dir, "pop_stran_resid_ER.xlsx")

# Leggi dati ----
raw_data_ER <- read_excel(file_path_ER, sheet = "Sheet1") |>
  filter(!is.na(Età))

# Crea fasce quinquennali ----
resid_stran_eta5_sex_ER <- raw_data_ER |>
  mutate(
    # Converti età in numerico, gestendo "100 e oltre"
    eta_num = case_when(
      Età == "100 e oltre" ~ 100,
      TRUE ~ as.numeric(Età)
    ),
    # Crea fasce quinquennali che corrispondono a resident_prov_eta5_sex
    fascia_eta = case_when(
      eta_num >= 90 ~ "90 e oltre",
      TRUE ~ paste0(
        floor(eta_num / 5) * 5,
        "-",
        floor(eta_num / 5) * 5 + 4
      )
    )
  ) |>
  # Aggrega per fasce quinquennali
  group_by(fascia_eta) |>
  summarise(
    Maschi = sum(Maschi, na.rm = TRUE),
    Femmine = sum(Femmine, na.rm = TRUE),
    Totale = sum(Totale, na.rm = TRUE),
    .groups = "drop"
  ) |>
  # Converti in formato lungo (tidy)
  pivot_longer(
    cols = c(Maschi, Femmine, Totale),
    names_to = "genere",
    values_to = "residenti"
  ) |>
  # Aggiungi colonna territorio
  mutate(
    territorio = "Emilia-Romagna",
    anno = 2025
  ) |>
  # Riordina colonne
  select(territorio, anno, fascia_eta, genere, residenti) |>
  # Ordina le fasce di età per corrispondere a resident_prov_eta5_sex
  arrange(
    match(fascia_eta, c(
      "0-4", "5-9", "10-14", "15-19", "20-24", "25-29",
      "30-34", "35-39", "40-44", "45-49", "50-54", "55-59",
      "60-64", "65-69", "70-74", "75-79", "80-84", "85-89",
      "90 e oltre"
    ))
  )

# Verifica risultato ----
glimpse(resid_stran_eta5_sex_ER)
head(resid_stran_eta5_sex_ER, 20)

# Salva dati in formato RDS e XLSX ----
saveRDS(resid_stran_eta5_sex_ER,
        file = fs::path(output_dir, "resid_stran_eta5_sex_ER.rds"))

writexl::write_xlsx(resid_stran_eta5_sex_ER,
                    path = fs::path(output_dir, "resid_stran_eta5_sex_ER.xlsx"))

cat("\n✓ Dati ER salvati in:", output_dir, "\n")

