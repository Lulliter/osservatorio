#!/bin/bash

# Render + Copy files to OneDrive ----------------------------------------------

# 1) Set source and destination folders ----------------------------------------
SOURCE="/Users/luisamimmi/Github/bilancio_missione"
DEST="/Users/luisamimmi/Library/CloudStorage/OneDrive-FondazioneCassadiRisparmiodiParmaeMontediCreditosuPegnodiBusseto/Input_bil_missione_2025"
mkdir -p "$DEST"

# 2) Render website (outputs to docs/) -----------------------------------------
quarto render

# 2b) Render DOCX separately ---------------------------------------------------
quarto render bilancio_2025.qmd --to docx

# 3.a) Copy DOCX file ----------------------------------------------------------
cp -v "$SOURCE/docs/bilancio_2025.docx" "$DEST/2025_bil-missione.docx"

# 3.b) Copy data folders -------------------------------------------------------
cp -Rv "$SOURCE/data_out" "$DEST/"
cp -Rv "$SOURCE/data_in" "$DEST/"


# Make it executable (run only once) -------------------------------------------
# chmod +x /Users/luisamimmi/Github/bilancio_missione/_render_copy2onedrive.sh
# ------------------------------------------------------------------------------
# Then 
# ./_render_copy2onedrive.sh
# -------------------------------------------------------------------------------
#
# [After running the script, you can commit and push the changes to GitHub:]
# git add -A && git commit -m "min flip" && git push