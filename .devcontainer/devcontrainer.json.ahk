```json
{
  "name": "R Data Visualization Tutorial",
  "image": "ghcr.io/rocker-org/devcontainer/tidyverse:4.2",
  "features": {
    "ghcr.io/rocker-org/devcontainer-features/r-packages:1": {
      "packages": "RColorBrewer,reshape2,corrplot,patchwork,devtools,plotly,vcd,ggmosaic"
    }
  },
  "postCreateCommand": "Rscript install_packages.R",
  "customizations": {
    "vscode": {
      "extensions": [
        "reditorsupport.r",
        "REditorSupport.r-lsp"
      ]
    }
  }
}