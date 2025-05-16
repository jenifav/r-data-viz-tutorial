# Print diagnostic info
cat("Starting package installation\n")
cat("R version:", R.version$version.string, "\n")

# Install CRAN packages with more robust error handling
pkg_list <- c("tidyverse", "ggplot2", "dplyr", "RColorBrewer", 
              "reshape2", "corrplot", "patchwork", "devtools",
              "plotly", "vcd")

for (pkg in pkg_list) {
  cat("Attempting to install", pkg, "...\n")
  tryCatch({
    if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
      install.packages(pkg, repos = "https://cloud.r-project.org", dependencies = TRUE)
      if (require(pkg, character.only = TRUE, quietly = TRUE)) {
        cat(pkg, "successfully installed\n")
      } else {
        cat("WARNING:", pkg, "installation was attempted but package cannot be loaded\n")
      }
    } else {
      cat(pkg, "is already installed\n")
    }
  }, error = function(e) {
    cat("ERROR installing", pkg, ":", conditionMessage(e), "\n")
  })
}

# Install GitHub packages
cat("Attempting to install ggmosaic from GitHub...\n")
tryCatch({
  if (!require("ggmosaic", quietly = TRUE)) {
    if (!require("remotes", quietly = TRUE)) {
      install.packages("remotes", repos = "https://cloud.r-project.org")
    }
    remotes::install_github("haleyjeppson/ggmosaic", upgrade = "never")
    if (require("ggmosaic", quietly = TRUE)) {
      cat("ggmosaic successfully installed\n")
    } else {
      cat("WARNING: ggmosaic installation was attempted but package cannot be loaded\n")
    }
  } else {
    cat("ggmosaic is already installed\n")
  }
}, error = function(e) {
  cat("ERROR installing ggmosaic:", conditionMessage(e), "\n")
})

cat("Package installation complete\n")