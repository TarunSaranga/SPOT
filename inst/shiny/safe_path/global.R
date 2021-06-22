# library(plotly)
# library(shinydashboard)
# library(shiny)
# library(dplyr)
# library(data.table)
# library(dashboardthemes)
# library(shinyjs)
# library(shinyWidgets)
# library(beepr)
# library(reticulate)

pkg_list <- c("plotly", "shinydashboard", "shiny", "dplyr", "data.table", "dashboardthemes", "shinyjs",
              "shinyWidgets", "beepr", "reticulate")

for (pkg in pkg_list){
  if (!require(pkg,character.only = TRUE)){
    install.packages(pkg, dependencies = T)
  }
  library(pkg, character.only = TRUE)
}

py_path <- .path
#py_path <- "/Users/apurvpriyam/opt/anaconda3/bin/python"

source("util/function.R")

# your python executable path
# reticulate::use_python(py_path, required = T)

py_found <- tryCatch(reticulate::use_python(py_path, required = T),
              error = function(c) "error",
              warning = function(c) "warning",
              message = function(c) "message"
)

if (py_found != "error"){
  reticulate::source_python("util/pyfunction.py")
}

us_data <- read.csv("data/Year_State_Acc.csv", stringsAsFactors = F)
line_data <- read.csv("data/df_line.csv", stringsAsFactors = F)
line_data$Month <- factor(line_data$Month, levels = month.name)

bar_data <- data.table::fread("data/Year_Month_Weekday_State.csv")
bar_data$text <- paste0(bar_data$NumOfAccidents, " accidents in year ", bar_data$Year, " and in state ", bar_data$State)

state_abb <- sort(c("AL", "AZ", "AR", "CA", "CO", "CT", "DC", "DE", "FL",
               "GA", "ID", "IL", "IN", "IA", "KS", "KY", "LA",
               "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE",
               "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK",
               "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT",
               "VA", "WA", "WV", "WI", "WY"))
#destination <- c(33.779853, -84.384140)

accidents <- data.table::fread("data/US_Accidents_fil.csv")

