# Path al file .bib del progetto, usato da citr::insert_citation()
# Così citr funziona da qualsiasi post/*.qmd senza dover dichiarare
# bibliography: nel YAML locale
local({
  bib <- file.path(getwd(), "bib", "CRP_osservatorio.bib")
  if (file.exists(bib)) {
    options(citr.bibliography_path = bib)
  }
})
