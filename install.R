# Install CRAN packages
cran_packages <- c('tidyverse', 'ggplot2', 'dplyr', 'RColorBrewer',
                  'reshape2', 'corrplot', 'patchwork', 'devtools',
                  'plotly', 'vcd')

for (pkg in cran_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

# Install GitHub packages
if (!require("ggmosaic")) {
  if (require("devtools")) {
    devtools::install_github("haleyjeppson/ggmosaic", upgrade = "never")
  } else {
    warning("devtools not available, cannot install ggmosaic")
  }
}