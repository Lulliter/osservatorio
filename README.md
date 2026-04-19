# Osservatorio dei dati sociali

Sito Quarto per raccogliere domande e approfondimenti dell'Osservatorio dei dati sociali.

## Struttura

```
osservatorio/
├── _quarto.yml           # Configurazione sito Quarto
├── index.qmd             # Home page
├── questions.qmd         # Domande e approfondimenti
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

- **GitHub Pages**: servito da `docs/` su [https://lulliter.github.io/osservatorio/](https://lulliter.github.io/osservatorio/)
- **OneDrive**: `2025_bil-missione.docx` + cartelle `data_in/` e `data_out/`

## GitHub Pages

Configurazione: Settings → Pages → Deploy from branch `master` `/docs`

## Dati

Tutte le fonti dati utilizzate sono pubbliche e open access (ISTAT, BES, Eurostat, ecc.). Le citazioni sono incluse nel documento e nella bibliografia (`CRP_bil_miss.bib`).
