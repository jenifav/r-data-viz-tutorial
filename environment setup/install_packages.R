if (!require("pacman")) install.packages("pacman")
pacman::p_load('tidyverse', 'ggplot2', 'dplyr', 'RColorBrewer',
              'reshape2', 'corrplot', 'patchwork', 'devtools',
              'plotly', 'vcd')

if (!require("ggmosaic")) {
  devtools::install_github("haleyjeppson/ggmosaic", upgrade = "never")
}