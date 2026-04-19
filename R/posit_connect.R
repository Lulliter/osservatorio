library(rsconnect)

rsconnect::accounts()
# name              server
# 1 lulliter connect.posit.cloud

# rsconnect::removeAccount(server="shinyapps.io" )

# rsconnect::writeManifest(
#   appDir = "docs", # cartella dove sta l'HTML
#   appFiles = "bilancio_2025.html",
#   appPrimaryDoc = "bilancio_2025.html"
# )

# Generate manifest.json in your project directory
writeManifest()

# has to be in the root 

rsconnect::deployApp(
  appDir = "docs",
  appPrimaryDoc = "bilancio_2025.html",
  appName = "bilancio_2025",
  server = "posit.cloud",
  account = "lmm76"
)
