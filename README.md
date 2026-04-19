# Input per Bilancio di Missione 2025

Sito Quarto per la condivisione interna di dati e analisi per il Bilancio di Missione 2025.

## Struttura

```
bilancio_missione/
├── _quarto.yml           # Configurazione sito Quarto
├── index.qmd             # Home page
├── bilancio_2025.qmd     # Report principale
├── docs/                 # Output renderizzato (per GitHub Pages)
├── data_in/              # Dati di input (ISTAT, BES, ecc.)
├── data_out/             # Dati di output (grafici, tabelle)
└── R/                    # Funzioni R
```

## Workflow

1. Renderizza il sito:
```bash
quarto render
```

2. Copia su OneDrive e renderizza:
```bash
./_render_copy2onedrive.sh
```

3. Commit e push:
```bash
git add -A
git commit -m "Aggiorna report"
git push
```

## Output

- **GitHub Pages**: servito da `docs/` su [https://lulliter.github.io/bilancio_missione/](https://lulliter.github.io/bilancio_missione/)
- **OneDrive**: `2025_bil-missione.docx` + cartelle `data_in/` e `data_out/`

## GitHub Pages

Configurazione: Settings → Pages → Deploy from branch `master` `/docs`

## Dati

Tutte le fonti dati utilizzate sono pubbliche e open access (ISTAT, BES, Eurostat, ecc.). Le citazioni sono incluse nel documento e nella bibliografia (`CRP_bil_miss.bib`).

