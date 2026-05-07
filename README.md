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

## Bibliografia e citazioni

La bibliografia del sito è un unico file BibTeX gestito da Zotero: `bib/CRP_osservatorio.bib`. È dichiarato in `_quarto.yml` con path relativo al project root, quindi viene ereditato automaticamente da tutti i post e dalle pagine.

**Regola:** non dichiarare `bibliography:` nel YAML locale dei post — lascia che erediti dal `_quarto.yml`. Se proprio serve un override locale, usa sempre un path relativo al project root (`bibliography: bib/altro.bib`), **mai** relativo al file
(`../../bib/...`): spezza `citr` e altri strumenti R. 

**Inserimento citazioni con `citr::insert_citation()`:** il file `.Rprofile` del progetto imposta `options(citr.bibliography_path = ...)` così `citr` usa sempre il `.bib` del progetto, da qualsiasi `.qmd` a qualsiasi profondità di cartelle. Perché funzioni occorre aprire il progetto come RStudio Project (aprendo il `.Rproj`).
