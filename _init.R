# _init.R

# Install Packages ----

# Prefer using `install.packages` and `library()` instead of `pacman::p_load()`;
# This enforces the last library having priority, in this case tidyverse
# 
# List of required CRAN packages
# ✖ dplyr::filter()     masks plotly::filter(), stats::filter()
# ✖ dplyr::group_rows() masks kableExtra::group_rows()
# ✖ dplyr::ident()      masks dbplyr::ident()
# ✖ dplyr::lag()        masks stats::lag()
# ✖ dplyr::sql()        masks dbplyr::sql()

## Cran Packages ----

required_packages <- c(
  "maps", "janitor", "ggthemes", "unvotes", "countdown", "conflicted", "devtools", "ggswissmaps", "kableExtra", "dbplyr", "RPostgres", "DBI", "plotly", 
  "patchwork", "ggridges", "naniar", "gt", "fivethirtyeight", 
  "skimr", "palmerpenguins", "tidyverse"
)

# Check and install missing packages from CRAN
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    message(paste("Installing package:", pkg))
    install.packages(pkg)
  }
  # After installation, load the package
  library(pkg, character.only = TRUE)
}

# Install the GitHub package (requires remotes package)
if (!requireNamespace("remotes", quietly = TRUE)) {
  message("Installing remotes package")
  install.packages("remotes")
}

## Conflict resolution ----
conflicted::conflicts_prefer(dplyr::filter())
conflicted::conflicts_prefer(config::get())
conflicted::conflicts_prefer(palmerpenguins::penguins)


## Github packages ----

# GitHub package installation using remotes
devtools::install_github("davidsjoberg/ggsankey")

# Load the GitHub package (ggsankey)
library(ggsankey)

# Helper functions ----
# Displaying nice gt tables with opt_stylize()
uFunc_nice_table <- function(df, style = 6, colour = "gray", tfs = NULL) {
  df |>
    gt() |>
    tab_style(
      style = cell_text(weight = "bold"),
      locations = cells_column_labels()
    ) |>
    opt_stylize(style = style, color = colour) |> 
    tab_options(table.font.size = tfs)
}


# Parameters ----

# DWH Postgres
db_ref <- "DWH_soz"

