# Osservatorio Dati Sociali

Sito Quarto per la raccolta e condivisione di dati e analisi sociali.

## Struttura

```
osservatorio/
├── _quarto.yml           # Configurazione sito Quarto
├── index.qmd             # Home page
├── questions.qmd         # Domande e approfondimenti
├── posts.qmd              # Listing page del blog
├── posts/                # Post del blog
├── docs/                 # Output renderizzato (per GitHub Pages)
├── data_in/              # Dati di input (ignorati da git)
├── data_out/             # Dati di output (ignorati da git)
└── R/                    # Funzioni R
```

## Workflow

1. Renderizza il sito:
```bash
quarto render
```

2. Commit e push:
```bash
git add -A
git commit -m "Aggiorna sito"
git push
```

## GitHub Pages

Servito da `docs/` su <https://lulliter.github.io/osservatorio/>

Configurazione: Settings → Pages → Deploy from branch `master` `/docs`

## Dati

Tutte le fonti dati utilizzate sono pubbliche e open access (ISTAT, BES, Eurostat, ecc.). I file in `data_in/` e `data_out/` sono ignorati da git (tranne `.md` e `.pdf`).
