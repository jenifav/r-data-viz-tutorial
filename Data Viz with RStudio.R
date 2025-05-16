# ============================================================================
# R Data Visualization Demo
# May 19, 2025
# Jennifer Favaloro, jennifer.h.favaloro@gmail.com
# ============================================================================

# ============================================================================
# Part 1: Introduction to Data Visualization in R
# ============================================================================

# This script provides an introduction to data visualization in R,
# comparing base R plotting with ggplot2 and other packages.

### install packages into library
### only needs to be done once, but packages need to be updated periodically
### to run, select the line of code and press Ctrl + Enter
install.packages('pacman')

pacman::p_load('tidyverse',	'ggplot2',	'dplyr',	'RColorBrewer',	
               'reshape2',	'corrplot',	'patchwork', 'devtools',
               'plotly', 'vcd')

devtools::install_github("haleyjeppson/ggmosaic", upgrade = "never") 
library(ggmosaic)

# -----------------------------------------------------------------------------
# 1. Base R Plotting System
# -----------------------------------------------------------------------------
# R comes with a built-in plotting system that is simple but powerful

# Load the built-in mtcars dataset
data(mtcars)
head(mtcars)

mtcars$cyl <- as.factor(mtcars$cyl)  # Convert cylinders to factor
mtcars$am <- as.factor(mtcars$am)

# Simple scatter plot with base R
plot(mtcars$wt, mtcars$mpg, 
     main = "Car Weight vs. Fuel Efficiency",
     xlab = "Weight (1000 lbs)",
     ylab = "Miles Per Gallon",
     pch = 19,
     col = "blue")

# Add a regression line
abline(lm(mpg ~ wt, data = mtcars), col = "red", lwd = 2)

# Simple histogram with base R
hist(mtcars$mpg, 
     main = "Distribution of Fuel Efficiency",
     xlab = "Miles Per Gallon",
     col = "lightblue",
     border = "black")

# Simple boxplot with base R
boxplot(mpg ~ cyl, data = mtcars,
        main = "Fuel Efficiency by Number of Cylinders",
        xlab = "Number of Cylinders",
        ylab = "Miles Per Gallon",
        col = c("lightgreen", "lightblue", "lightpink"))

# -----------------------------------------------------------------------------
# 2. Introduction to ggplot2
# -----------------------------------------------------------------------------
# ggplot2 is based on the Grammar of Graphics, a systematic approach to 
# describing and building graphs

# The same scatter plot with ggplot2
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Car Weight vs. Fuel Efficiency",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon") +
  theme_minimal()

# The same histogram with ggplot2
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(fill = "lightblue", color = "black", bins = 10) +
  labs(title = "Distribution of Fuel Efficiency",
       x = "Miles Per Gallon",
       y = "Count") +
  theme_minimal()

# The same boxplot with ggplot2
ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot() +
  scale_fill_manual(values = c("lightgreen", "lightblue", "lightpink")) +
  labs(title = "Fuel Efficiency by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon",
       fill = "Cylinders") +
  theme_minimal()

# -----------------------------------------------------------------------------
# 3. Key Differences and Advantages
# -----------------------------------------------------------------------------
# ggplot2 advantages:
# - Consistent syntax based on layers
# - Better defaults for aesthetics
# - Easier to create complex visualizations
# - Better support for grouping and faceting
# - Extensive theming capabilities

# Base R advantages:
# - Simpler for quick, one-off plots
# - No additional packages required
# - More direct control over plot elements
# - Sometimes faster for large datasets

# -----------------------------------------------------------------------------
# 4. Other Visualization Packages in R
# -----------------------------------------------------------------------------
# Brief mention of other packages we'll explore:
# - plotly: for interactive visualizations
# - corrplot: for correlation matrices
# - RColorBrewer: for color palettes
# - patchwork: for combining plots

# -----------------------------------------------------------------------------
# 5. Datasets for this Demo
# -----------------------------------------------------------------------------
# Preview of the datasets we'll be using throughout the demo

# Iris dataset
data(iris)
head(iris)

# Diamonds dataset from ggplot2
data(diamonds, package = "ggplot2")
head(diamonds)

# Economics dataset from ggplot2
data(economics, package = "ggplot2")
head(economics)


# ============================================================================
# Part 2: Getting Started with ggplot2
# ============================================================================

# This script covers the fundamentals of ggplot2 and demonstrates how to create
# basic plots with customizations.

# -----------------------------------------------------------------------------
# 1. Grammar of Graphics Concept
# -----------------------------------------------------------------------------
# ggplot2 is based on the Grammar of Graphics, which breaks down visualizations
# into semantic components:
# - Data: The dataset being plotted
# - Aesthetics: Mapping of variables to visual properties
# - Geometries: The actual shapes representing data
# - Facets: For creating small multiples
# - Statistics: Statistical transformations
# - Coordinates: The coordinate system
# - Themes: Controlling the display

# -----------------------------------------------------------------------------
# 2. Basic ggplot2 Syntax and Structure
# -----------------------------------------------------------------------------


# Basic structure of a ggplot2 plot
# ggplot(data, aes(x, y)) + geom_function()

# Empty plot with just the axes
ggplot(mtcars, aes(x = wt, y = mpg))

# Adding points to create a scatter plot
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# -----------------------------------------------------------------------------
# 3. Creating Basic Plot Types
# -----------------------------------------------------------------------------

# Scatter plot
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  labs(title = "Car Weight vs. Fuel Efficiency",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon")

# Bar chart
# Using the built-in diamonds dataset
ggplot(diamonds, aes(x = cut)) +
  geom_bar() +
  labs(title = "Count of Diamonds by Cut Quality",
       x = "Cut Quality",
       y = "Count")

# Bar chart with calculated values
mtcars_summary <- mtcars %>%
  group_by(cyl) %>%
  summarize(avg_mpg = mean(mpg))

ggplot(mtcars_summary, aes(x = cyl, y = avg_mpg)) +
  geom_col() +
  labs(title = "Average MPG by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Average MPG")

# Line graph
# Using the economics dataset
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line() +
  labs(title = "US Unemployment Over Time",
       x = "Date",
       y = "Unemployment (thousands)")

# Histogram
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(bins = 10) +
  labs(title = "Distribution of Fuel Efficiency",
       x = "Miles Per Gallon",
       y = "Count")

# Density plot
ggplot(mtcars, aes(x = mpg)) +
  geom_density(fill = "blue", alpha = 0.5) +
  labs(title = "Density of Fuel Efficiency",
       x = "Miles Per Gallon",
       y = "Density")

# -----------------------------------------------------------------------------
# 4. Customizing Plot Aesthetics
# -----------------------------------------------------------------------------

# Adding color
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  labs(title = "Car Weight vs. Fuel Efficiency by Cylinders",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders")

# Adding shape
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl, shape = as.factor(am))) +
  geom_point(size = 3) +
  labs(title = "Car Weight vs. Fuel Efficiency",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders",
       shape = "Transmission (0 = auto, 1 = manual)")

# Customizing colors
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  scale_color_manual(values = c("red", "green", "blue")) +
  labs(title = "Car Weight vs. Fuel Efficiency by Cylinders",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders")

# Adding a smoothing line
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Car Weight vs. Fuel Efficiency with Trend Line",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon")

# Customizing the theme
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  labs(title = "Car Weight vs. Fuel Efficiency by Cylinders",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 12),
    legend.position = "bottom"
  )

# -----------------------------------------------------------------------------
# 5. Saving and Exporting Visualizations
# -----------------------------------------------------------------------------

# Create a plot to save
p <- ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  labs(title = "Car Weight vs. Fuel Efficiency by Cylinders",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders") +
  theme_minimal()

# Save as PNG
# ggsave("my_plot.png", p, width = 8, height = 6, dpi = 300)

# Save as PDF
# ggsave("my_plot.pdf", p, width = 8, height = 6)

# Save as SVG
# ggsave("my_plot.svg", p, width = 8, height = 6)


# ============================================================================
# Part 3: Advanced ggplot2 Techniques
# ============================================================================

# This script demonstrates advanced ggplot2 techniques for creating more
# sophisticated and customized visualizations.

# -----------------------------------------------------------------------------
# 1. Working with Multiple Variables
# -----------------------------------------------------------------------------

# Let's reduce the number of clarity categories
diamonds <- diamonds %>%
  mutate(Clarity = case_when(
    clarity %in% c("SI1", "SI2") ~ "SI",
    clarity %in% c("VS1", "VS2") ~ "VS",
    clarity %in% c("VVS1", "VVS2") ~ "VVS",
    .default = clarity
  ))
# check
table(diamonds$clarity, diamonds$Clarity, useNA="ifany")

# Visualizing multiple variables with color, size, and shape
ggplot(diamonds[sample(nrow(diamonds), 1000), ], aes(x = carat, y = price)) +
  geom_point(aes(color = cut, size = depth, shape = Clarity)) +
  labs(title = "Diamond Price vs. Carat with Multiple Variables",
       x = "Carat",
       y = "Price (USD)",
       color = "Cut Quality",
       size = "Depth %",
       shape = "Clarity") +
  theme_minimal()

# -----------------------------------------------------------------------------
# 2. Faceting and Small Multiples
# -----------------------------------------------------------------------------

# Faceting by a single variable (cut)
ggplot(diamonds[sample(nrow(diamonds), 5000), ], aes(x = carat, y = price)) +
  geom_point(alpha = 0.5, color = "blue") +
  facet_wrap(~ cut) +
  labs(title = "Diamond Price vs. Carat by Cut",
       x = "Carat",
       y = "Price (USD)") +
  theme_light()

# Faceting by two variables (cut and color)
ggplot(diamonds[sample(nrow(diamonds), 5000), ], aes(x = carat, y = price)) +
  geom_point(alpha = 0.5, color = "purple") +
  facet_grid(color ~ cut) +
  labs(title = "Diamond Price vs. Carat by Cut and Color",
       x = "Carat",
       y = "Price (USD)") +
  theme_light()

# -----------------------------------------------------------------------------
# 3. Combining Multiple Geoms
# -----------------------------------------------------------------------------

# Combining points and smoothing lines
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl, group = cyl)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Car Weight vs. Fuel Efficiency by Cylinders",
       subtitle = "With Linear Regression Lines",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders") +
  theme_minimal()

# Combining boxplot and jittered points
ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl, group = cyl)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.7) +
  labs(title = "Fuel Efficiency by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon",
       fill = "Cylinders") +
  theme_minimal()

# Violin plot with boxplot inside
ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl, group = cyl)) +
  geom_violin(alpha = 0.5) +
  geom_boxplot(width = 0.2, alpha = 0.8) +
  labs(title = "Fuel Efficiency Distribution by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon",
       fill = "Cylinders") +
  theme_minimal()

# -----------------------------------------------------------------------------
# 4. Custom Themes and Styling
# -----------------------------------------------------------------------------

# Built-in themes
p <- ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  labs(title = "Car Weight vs. Fuel Efficiency",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders")

p

# Default theme
p + theme_gray() + ggtitle("theme_gray() - Default")

# Minimal theme
p + theme_minimal() + ggtitle("theme_minimal()")

# Classic theme
p + theme_classic() + ggtitle("theme_classic()")

# Black and white theme
p + theme_bw() + ggtitle("theme_bw()")

# Light theme
p + theme_light() + ggtitle("theme_light()")

# Dark theme
p + theme_dark() + ggtitle("theme_dark()")

# Creating a custom theme
my_theme <- theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "darkgray"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.position = "bottom",
    legend.title = element_text(size = 10, face = "bold"),
    panel.grid.major = element_line(color = "lightgray", size = 0.5),
    panel.grid.minor = element_line(color = "lightgray", size = 0.25, linetype = "dashed")
  )

# Apply custom theme
p + my_theme + ggtitle("Custom Theme")

# -----------------------------------------------------------------------------
# 5. Using Color Effectively with RColorBrewer
# -----------------------------------------------------------------------------

# Display available color palettes
# display.brewer.all()

# Sequential palette (Blues)
ggplot(mtcars, aes(x = wt, y = mpg, color = qsec)) +
  geom_point(size = 3) +
  scale_color_distiller(palette = "Blues", direction = 1) +
  labs(title = "Car Weight vs. Fuel Efficiency",
       subtitle = "Sequential Color Palette (Blues)",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Quarter Mile Time") +
  theme_minimal()

# Diverging palette (Spectral)
ggplot(mtcars, aes(x = wt, y = mpg, color = qsec)) +
  geom_point(size = 3) +
  scale_color_distiller(palette = "Spectral", direction = 1) +
  labs(title = "Car Weight vs. Fuel Efficiency",
       subtitle = "Diverging Color Palette (Spectral)",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Quarter Mile Time") +
  theme_minimal()

# Qualitative palette (Set1)
ggplot(mtcars, aes(x = wt, y = mpg, color = as.factor(cyl))) +
  geom_point(size = 3) +
  scale_color_brewer(palette = "Set1") +
  labs(title = "Car Weight vs. Fuel Efficiency",
       subtitle = "Qualitative Color Palette (Set1)",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders") +
  theme_minimal()

# -----------------------------------------------------------------------------
# 6. Annotations and Labels
# -----------------------------------------------------------------------------

# Adding text labels to points
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(size = 2) +
  geom_text(aes(label = rownames(mtcars)), hjust = -0.2, vjust = 0.5, size = 3) +
  labs(title = "Car Weight vs. Fuel Efficiency",
       subtitle = "With Car Model Labels",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon") +
  theme_minimal() +
  xlim(1, 6.5)  # Extend x-axis to make room for labels

# Adding annotations
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(aes(color = cyl), size = 3) +
  annotate("rect", xmin = 3, xmax = 4, ymin = 15, ymax = 20, 
           alpha = 0.2, fill = "yellow") +
  annotate("text", x = 3.5, y = 21, label = "Mid-weight, mid-efficiency cars", 
           fontface = "bold") +
  annotate("segment", x = 3.5, y = 20.5, xend = 3.5, yend = 20, 
           arrow = arrow(length = unit(0.2, "cm"))) +
  labs(title = "Car Weight vs. Fuel Efficiency",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Cylinders") +
  theme_minimal()

# -----------------------------------------------------------------------------
# 7. Coordinate Systems and Transformations
# -----------------------------------------------------------------------------

# Flipping coordinates
ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_boxplot(aes(fill = cyl, group = cyl)) +
  labs(title = "Fuel Efficiency by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon",
       fill = "Cylinders") +
  theme_minimal()

ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_boxplot(aes(fill = cyl, group = cyl)) +
  labs(title = "Fuel Efficiency by Number of Cylinders (Flipped)",
       x = "Number of Cylinders",
       y = "Miles Per Gallon",
       fill = "Cylinders") +
  coord_flip() +
  theme_minimal()

# Polar coordinates
ggplot(mtcars, aes(x = factor(cyl), fill = factor(cyl), group = cyl)) +
  geom_bar() +
  labs(title = "Count of Cars by Number of Cylinders (Polar)",
       x = "Number of Cylinders",
       y = "Count",
       fill = "Cylinders") +
  coord_polar() +
  theme_minimal()

# Log transformation
ggplot(diamonds[sample(nrow(diamonds), 1000), ], aes(x = carat, y = price)) +
  geom_point(alpha = 0.5) +
  labs(title = "Diamond Price vs. Carat (Standard Scale)",
       x = "Carat",
       y = "Price (USD)") +
  theme_minimal()

ggplot(diamonds[sample(nrow(diamonds), 1000), ], aes(x = carat, y = price)) +
  geom_point(alpha = 0.5) +
  labs(title = "Diamond Price vs. Carat (Log Scale)",
       x = "Carat",
       y = "Price (USD) - Log Scale") +
  scale_y_log10() +
  theme_minimal()

# ============================================================================
# Part 4: Specialized Visualizations
# ============================================================================

# This script demonstrates specialized visualization techniques in R,
# including statistical visualizations, correlation plots, and heatmaps.

# -----------------------------------------------------------------------------
# 1. Statistical Visualizations
# -----------------------------------------------------------------------------

# Box plots
ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl, group = cyl)) +
  geom_boxplot() +
  labs(title = "Fuel Efficiency by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon",
       fill = "Cylinders") +
  theme_minimal()

# Violin plots
ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl, group = cyl)) +
  geom_violin(trim = FALSE) +
  labs(title = "Fuel Efficiency Distribution by Number of Cylinders",
       x = "Number of Cylinders",
       y = "Miles Per Gallon",
       fill = "Cylinders") +
  theme_minimal()

# Box plot + Violin plot comparison
p1 <- ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl, group = cyl)) +
  geom_boxplot() +
  labs(title = "Box Plot",
       x = "Cylinders",
       y = "MPG") +
  theme_minimal() +
  theme(legend.position = "none")

p2 <- ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl, group = cyl)) +
  geom_violin(trim = FALSE) +
  labs(title = "Violin Plot",
       x = "Cylinders",
       y = "MPG") +
  theme_minimal() +
  theme(legend.position = "none")

# Using patchwork to combine plots
p1 + p2 + plot_annotation(
  title = "Comparison of Box Plot and Violin Plot",
  subtitle = "Visualizing the same data with different techniques"
)

# Density plots
ggplot(mtcars, aes(x = mpg, fill = cyl, group = cyl)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density of Fuel Efficiency by Number of Cylinders",
       x = "Miles Per Gallon",
       y = "Density",
       fill = "Cylinders") +
  theme_minimal()

# QQ plots
ggplot(mtcars, aes(sample = mpg)) +
  geom_qq() +
  geom_qq_line() +
  labs(title = "QQ Plot of Fuel Efficiency",
       x = "Theoretical Quantiles",
       y = "Sample Quantiles") +
  theme_minimal()

# QQ plots by group
ggplot(mtcars, aes(sample = mpg, color = cyl, group = cyl)) +
  geom_qq() +
  geom_qq_line() +
  labs(title = "QQ Plot of Fuel Efficiency by Number of Cylinders",
       x = "Theoretical Quantiles",
       y = "Sample Quantiles",
       color = "Cylinders") +
  theme_minimal()

# -----------------------------------------------------------------------------
# 2. Visualizing Relationships
# -----------------------------------------------------------------------------

# Correlation matrix
mtcars_numeric <- mtcars[, c("mpg", "disp", "hp", "drat", "wt", "qsec")]
cor_matrix <- cor(mtcars_numeric)
print(cor_matrix)

# Correlation plot with corrplot
corrplot(cor_matrix, 
         method = "circle", 
         type = "upper", 
         order = "hclust",
         tl.col = "black",
         tl.srt = 45,
         addCoef.col = "black",
         number.cex = 0.7,
         title = "Correlation Matrix of Car Features",
         mar = c(0, 0, 2, 0))

# Heatmap of correlation matrix
melted_cor <- melt(cor_matrix) # melt turns cor_matrix into long format

ggplot(melted_cor, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), space = "Lab", 
                       name = "Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  coord_fixed() +
  labs(title = "Correlation Heatmap of Car Features",
       x = "",
       y = "")

# Scatter plot matrix
pairs(mtcars_numeric, 
      main = "Scatter Plot Matrix of Car Features",
      pch = 21,
      bg = rainbow(nrow(mtcars_numeric))[rank(mtcars$cyl)])

# -----------------------------------------------------------------------------
# 3. Time Series Visualizations
# -----------------------------------------------------------------------------

# Basic time series plot
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line(color = "blue") +
  labs(title = "US Unemployment Over Time",
       x = "Date",
       y = "Unemployment (thousands)") +
  theme_minimal()

# Multiple time series
economics_long <- economics %>%
  select(date, unemploy, psavert) %>%
  rename(Unemployment = unemploy, 
         "Personal Savings Rate" = psavert) %>%
  melt(id.vars = "date", variable.name = "series")

ggplot(economics_long, aes(x = date, y = value, color = series)) +
  geom_line() +
  labs(title = "US Economic Indicators Over Time",
       x = "Date",
       y = "Value",
       color = "Indicator") +
  theme_minimal() +
  facet_wrap(~ series, scales = "free_y", ncol = 1)

# Seasonal decomposition visualization
# Note: This would typically use the decompose() or stl() function
# For demonstration, we'll create a simulated seasonal time series

# Create a simulated seasonal time series
set.seed(123)
time <- seq(as.Date("2010-01-01"), as.Date("2019-12-31"), by = "month")
trend <- seq(1, length(time)) * 0.1
seasonal <- sin(2 * pi * seq(1, length(time)) / 12) * 5
random <- rnorm(length(time), 0, 1)
value <- trend + seasonal + random

ts_data <- data.frame(
  date = time,
  value = value,
  trend = trend,
  seasonal = seasonal,
  random = random
)

# Plot the components
p1 <- ggplot(ts_data, aes(x = date, y = value)) +
  geom_line() +
  labs(title = "Original Time Series",
       x = "",
       y = "Value") +
  theme_minimal()

p2 <- ggplot(ts_data, aes(x = date, y = trend)) +
  geom_line(color = "blue") +
  labs(title = "Trend Component",
       x = "",
       y = "Trend") +
  theme_minimal()

p3 <- ggplot(ts_data, aes(x = date, y = seasonal)) +
  geom_line(color = "green") +
  labs(title = "Seasonal Component",
       x = "",
       y = "Seasonal") +
  theme_minimal()

p4 <- ggplot(ts_data, aes(x = date, y = random)) +
  geom_line(color = "red") +
  labs(title = "Random Component",
       x = "Date",
       y = "Random") +
  theme_minimal()

# Combine the plots using patchwork
(p1 / p2 / p3 / p4) + 
  plot_annotation(
    title = "Time Series Decomposition",
    subtitle = "Breaking down a time series into its components"
  )

# -----------------------------------------------------------------------------
# 4. Combining Plots with patchwork
# -----------------------------------------------------------------------------

# Create some basic plots
p1 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Weight vs. MPG",
       x = "Weight (1000 lbs)",
       y = "Miles Per Gallon") +
  theme_minimal()

p2 <- ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Horsepower vs. MPG",
       x = "Horsepower",
       y = "Miles Per Gallon") +
  theme_minimal()

p3 <- ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(bins = 10, fill = "skyblue", color = "black") +
  labs(title = "MPG Distribution",
       x = "Miles Per Gallon",
       y = "Count") +
  theme_minimal()

p4 <- ggplot(mtcars, aes(x = factor(cyl), y = mpg, fill = factor(cyl), group = cyl)) +
  geom_boxplot() +
  labs(title = "MPG by Cylinders",
       x = "Cylinders",
       y = "Miles Per Gallon") +
  theme_minimal() +
  theme(legend.position = "none")

# Side by side arrangement
p1 + p2

# Stacked arrangement
p1 / p2

# Grid arrangement
(p1 + p2) / (p3 + p4)

# Complex layout
layout <- "
AABB
AACC
"
p1 + p2 + p3 + plot_layout(design = layout)

# With annotations
(p1 + p2) / (p3 + p4) +
  plot_annotation(
    title = "Car Performance Analysis Dashboard",
    subtitle = "Multiple visualizations of the mtcars dataset",
    caption = "Source: 1974 Motor Trend US magazine",
    tag_levels = "A"
  )


# ============================================================================
# Part 5: Plotly Examples
# ============================================================================

# Using the built-in mtcars dataset
scatter_plot <- plot_ly(data = mtcars, 
                        x = ~wt, 
                        y = ~mpg, 
                        color = ~factor(cyl),
                        size = ~hp,
                        text = ~paste("Car: ", rownames(mtcars), 
                                     "<br>Weight: ", wt, 
                                     "<br>MPG: ", mpg,
                                     "<br>Cylinders: ", cyl,
                                     "<br>Horsepower: ", hp),
                        hoverinfo = "text",
                        type = "scatter",
                        mode = "markers") %>%
  layout(title = "Car Weight vs. Fuel Efficiency",
         xaxis = list(title = "Weight (1000 lbs)"),
         yaxis = list(title = "Miles Per Gallon"),
         legend = list(title = list(text = "Cylinders")))

# Display the plot
scatter_plot

# Example 2: Bar Chart
# -------------------
# Create a bar chart with custom colors

# Summarize mtcars data by cylinder
cyl_summary <- mtcars %>%
  group_by(cyl) %>%
  summarize(avg_mpg = mean(mpg),
            count = n())

bar_plot <- plot_ly(data = cyl_summary,
                    x = ~factor(cyl),
                    y = ~avg_mpg,
                    type = "bar",
                    marker = list(color = c("#1f77b4", "#ff7f0e", "#2ca02c")),
                    text = ~paste("Cylinders: ", cyl,
                                 "<br>Average MPG: ", round(avg_mpg, 1),
                                 "<br>Count: ", count),
                    hoverinfo = "text") %>%
  layout(title = "Average Fuel Efficiency by Number of Cylinders",
         xaxis = list(title = "Number of Cylinders"),
         yaxis = list(title = "Average MPG"))

# Display the plot
bar_plot

# Example 3: Line Chart with Multiple Series
# -----------------------------------------
# Create a line chart with multiple series using economics data

# Load the economics dataset from ggplot2
data(economics, package = "ggplot2")

# Create a subset of the data
econ_subset <- tail(economics, 120)  # Last 10 years of data

line_plot <- plot_ly(data = econ_subset, x = ~date) %>%
  add_trace(y = ~unemploy, name = "Unemployment",
            type = "scatter", mode = "lines",
            line = list(color = "#1f77b4", width = 2)) %>%
  add_trace(y = ~uempmed, name = "Median Unemployment Duration",
            type = "scatter", mode = "lines",
            line = list(color = "#ff7f0e", width = 2)) %>%
  layout(title = "US Unemployment Trends",
         xaxis = list(title = "Date"),
         yaxis = list(title = "Value"),
         legend = list(x = 0.1, y = 0.9))

# Display the plot
line_plot

# Example 4: Heatmap
# -----------------
# Create a correlation heatmap

# Calculate correlation matrix
cor_matrix <- cor(mtcars[, c("mpg", "disp", "hp", "drat", "wt", "qsec")])

# Convert to a format suitable for plotly
cor_data <- as.data.frame(cor_matrix)
cor_data$variable1 <- rownames(cor_data)
cor_long <- tidyr::pivot_longer(cor_data, 
                               cols = c("mpg", "disp", "hp", "drat", "wt", "qsec"),
                               names_to = "variable2", 
                               values_to = "correlation")

heatmap_plot <- plot_ly(data = cor_long,
                        x = ~variable1,
                        y = ~variable2,
                        z = ~correlation,
                        type = "heatmap",
                        colorscale = "RdBu",
                        zmin = -1, zmax = 1,
                        text = ~paste("Variables: ", variable1, " & ", variable2,
                                     "<br>Correlation: ", round(correlation, 2)),
                        hoverinfo = "text") %>%
  layout(title = "Correlation Matrix of Car Features",
         xaxis = list(title = ""),
         yaxis = list(title = ""))

# Display the plot
heatmap_plot

# Example 5: 3D Scatter Plot
# -------------------------
# Create a 3D scatter plot

scatter_3d <- plot_ly(data = mtcars,
                      x = ~wt,
                      y = ~hp,
                      z = ~mpg,
                      color = ~factor(cyl),
                      size = ~qsec,
                      text = ~paste("Car: ", rownames(mtcars),
                                   "<br>Weight: ", wt,
                                   "<br>Horsepower: ", hp,
                                   "<br>MPG: ", mpg,
                                   "<br>Cylinders: ", cyl),
                      hoverinfo = "text",
                      type = "scatter3d",
                      mode = "markers") %>%
  layout(title = "3D Visualization of Car Features",
         scene = list(
           xaxis = list(title = "Weight (1000 lbs)"),
           yaxis = list(title = "Horsepower"),
           zaxis = list(title = "Miles Per Gallon")
         ))

# Display the plot
scatter_3d

# Example 6: Box Plot
# ------------------
# Create a box plot grouped by cylinder

box_plot <- plot_ly(data = mtcars,
                    x = ~factor(cyl),
                    y = ~mpg,
                    color = ~factor(cyl),
                    type = "box",
                    boxpoints = "all",
                    jitter = 0.3,
                    pointpos = 0) %>%
  layout(title = "Distribution of Fuel Efficiency by Cylinder Count",
         xaxis = list(title = "Number of Cylinders"),
         yaxis = list(title = "Miles Per Gallon"),
         showlegend = FALSE)

# Display the plot
box_plot

# Example 7: Histogram with Multiple Traces
# ----------------------------------------
# Create overlapping histograms

hist_plot <- plot_ly(alpha = 0.6) %>%
  add_histogram(x = mtcars$mpg[mtcars$cyl == 4],
                name = "4 Cylinders",
                marker = list(color = "#1f77b4")) %>%
  add_histogram(x = mtcars$mpg[mtcars$cyl == 6],
                name = "6 Cylinders",
                marker = list(color = "#ff7f0e")) %>%
  add_histogram(x = mtcars$mpg[mtcars$cyl == 8],
                name = "8 Cylinders",
                marker = list(color = "#2ca02c")) %>%
  layout(title = "Distribution of MPG by Cylinder Count",
         xaxis = list(title = "Miles Per Gallon"),
         yaxis = list(title = "Count"),
         barmode = "overlay")

# Display the plot
hist_plot

# Example 8: Bubble Chart
# ----------------------
# Create a bubble chart with custom hover text

bubble_plot <- plot_ly(data = mtcars,
                       x = ~wt,
                       y = ~mpg,
                       size = ~disp,
                       color = ~factor(am),
                       colors = c("#1f77b4", "#ff7f0e"),
                       text = ~paste("Car: ", rownames(mtcars),
                                    "<br>Weight: ", wt,
                                    "<br>MPG: ", mpg,
                                    "<br>Displacement: ", disp,
                                    "<br>Transmission: ", ifelse(am == 0, "Automatic", "Manual")),
                       hoverinfo = "text",
                       type = "scatter",
                       mode = "markers",
                       marker = list(opacity = 0.7, sizemode = "diameter")) %>%
  layout(title = "Car Weight vs. Fuel Efficiency (Bubble Size = Displacement)",
         xaxis = list(title = "Weight (1000 lbs)"),
         yaxis = list(title = "Miles Per Gallon"),
         legend = list(title = list(text = "Transmission")))

# Display the plot
bubble_plot

# Saving Plotly Visualizations
# ---------------------------
# You can save plotly visualizations as HTML files for sharing

# Example of saving a plot to an HTML file
# htmlwidgets::saveWidget(as_widget(scatter_plot), "scatter_plot.html")

# You can also export to static image formats
# orca(scatter_plot, "scatter_plot.png")
# Note: This requires the orca package to be installed
# install.packages("processx")
# plotly::orca_install()

# ============================================================================
# Part 6: ggmosaic Examples
# ============================================================================

# Example 1: Basic Mosaic Plot
# ---------------------------
# Create a simple mosaic plot showing the relationship between two categorical variables

# Using the Titanic dataset from vcd package
data("Titanic")
titanic_df <- as.data.frame(Titanic)

# Basic mosaic plot showing survival by class
basic_mosaic <- ggplot(data = titanic_df) +
  geom_mosaic(aes(weight = Freq, x = product(Survived, Class), fill = Survived)) +
  labs(title = "Titanic Survival by Passenger Class",
       subtitle = "Mosaic plot showing the relationship between survival and passenger class",
       x = "Passenger Class",
       y = "Survival") +
  scale_fill_manual(values = c("No" = "#E41A1C", "Yes" = "#4DAF4A")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Display the plot
print(basic_mosaic)

# Example 2: Multi-variable Mosaic Plot
# -----------------------------------
# Create a more complex mosaic plot with three variables

# Mosaic plot showing survival by class and sex
multi_var_mosaic <- ggplot(data = titanic_df) +
  geom_mosaic(aes(weight = Freq, x = product(Sex, Class), fill = Survived)) +
  labs(title = "Titanic Survival by Sex and Passenger Class",
       subtitle = "Mosaic plot showing the relationship between survival, sex, and passenger class",
       x = "Sex and Passenger Class",
       y = "Survival") +
  scale_fill_manual(values = c("No" = "#E41A1C", "Yes" = "#4DAF4A")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Display the plot
print(multi_var_mosaic)

# Example 3: Four-variable Mosaic Plot
# ----------------------------------
# Create a complex mosaic plot with four variables

# Mosaic plot showing survival by class, sex, and age
four_var_mosaic <- ggplot(data = titanic_df) +
  geom_mosaic(aes(weight = Freq, 
                  x = product(Sex, Class, Age), 
                  fill = Survived)) +
  labs(title = "Titanic Survival by Sex, Class, and Age",
       subtitle = "Mosaic plot showing the relationship between multiple variables",
       x = "Sex, Class, and Age",
       y = "Survival") +
  scale_fill_manual(values = c("No" = "#E41A1C", "Yes" = "#4DAF4A")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Display the plot
print(four_var_mosaic)

# Example 4: Using Different Datasets
# ---------------------------------
# Create a mosaic plot with a different dataset

# Using the HairEyeColor dataset
data(HairEyeColor)
hair_eye_df <- as.data.frame(HairEyeColor)

# Mosaic plot showing relationship between hair color and eye color
hair_eye_mosaic <- ggplot(data = hair_eye_df) +
  geom_mosaic(aes(weight = Freq, x = product(Hair), fill = Eye)) +
  labs(title = "Relationship Between Hair Color and Eye Color",
       subtitle = "Mosaic plot showing the distribution of eye colors across hair colors",
       x = "Hair Color",
       y = "Eye Color") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal()

# Display the plot
print(hair_eye_mosaic)

# Example 5: Mosaic Plot with Facets
# --------------------------------
# Create a mosaic plot with faceting

# Mosaic plot showing hair and eye color, faceted by sex
faceted_mosaic <- ggplot(data = hair_eye_df) +
  geom_mosaic(aes(weight = Freq, x = product(Hair), fill = Eye)) +
  facet_grid(. ~ Sex) +
  labs(title = "Relationship Between Hair Color and Eye Color by Sex",
       subtitle = "Mosaic plots faceted by sex",
       x = "Hair Color",
       y = "Eye Color") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal()

# Display the plot
print(faceted_mosaic)

# Example 6: Customized Mosaic Plot
# -------------------------------
# Create a highly customized mosaic plot

# Using the Titanic dataset again
# Customized mosaic plot with different aesthetics
custom_mosaic <- ggplot(data = titanic_df) +
  geom_mosaic(aes(weight = Freq, 
                  x = product(Class, Sex), 
                  fill = Survived),
              divider = mosaic("v"), # vertical divider
              na.rm = TRUE,
              offset = 0.02) +  # spacing between tiles
  labs(title = "Titanic Survival Patterns",
       subtitle = "Customized mosaic plot showing survival by class and sex",
       x = "Passenger Class and Sex",
       y = "Survival") +
  scale_fill_manual(values = c("No" = "#882255", "Yes" = "#117733"),
                    name = "Survived",
                    labels = c("No" = "Did not survive", "Yes" = "Survived")) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12, color = "darkgray"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.position = "bottom",
    legend.title = element_text(size = 10, face = "bold")
  )

# Display the plot
print(custom_mosaic)

# Example 7: Interactive Mosaic Plot with plotly
# -------------------------------------------
# Combine ggmosaic with plotly for interactive plots

# Create a ggplot mosaic plot
interactive_base <- ggplot(data = titanic_df) +
  geom_mosaic(aes(weight = Freq, 
                  x = product(Class), 
                  fill = Survived,
                  text = paste("Class:", Class,
                              "<br>Survived:", Survived,
                              "<br>Count:", Freq,
                              "<br>Percentage:", round(Freq/sum(Freq)*100, 1), "%"))) +
  labs(title = "Titanic Survival by Passenger Class",
       x = "Passenger Class",
       y = "Survival") +
  scale_fill_manual(values = c("No" = "#E41A1C", "Yes" = "#4DAF4A")) +
  theme_minimal()

# Convert to an interactive plotly plot
interactive_mosaic <- ggplotly(interactive_base, tooltip = "text")

# Display the interactive plot
interactive_mosaic

# Notes on ggmosaic
# ---------------
# 1. The product() function is used to specify the variables for the mosaic plot
# 2. The weight parameter is used to specify the frequency or count variable
# 3. The divider parameter controls how the plot is divided (h = horizontal, v = vertical)
# 4. ggmosaic integrates with the ggplot2 ecosystem, allowing for customization
# 5. For large datasets with many categories, consider aggregating data first
# 6. The order of variables in product() affects the visualization structure

