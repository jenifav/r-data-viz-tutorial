# Use a CRAN mirror that works well globally
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install R packages needed for the tutorial
cat("Installing required packages...\n")
install.packages(c("tidyverse", "ggplot2", "dplyr", "RColorBrewer",
                   "reshape2", "corrplot", "patchwork", "devtools",
                   "plotly", "vcd"))

if(!require(devtools)) {
  install.packages("devtools")
}

if(!require(ggmosaic)) {
  devtools::install_github("haleyjeppson/ggmosaic", upgrade = "never")
}