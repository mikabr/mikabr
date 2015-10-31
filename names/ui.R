library(shiny)
library(shinythemes)


shinyUI(fluidPage(
  
  theme = shinytheme("spacelab"),
  
  br(),
  textInput("names", label = "Graph these comma-separated names:",
            value = "Alice,Bob,Charlie"),
  plotOutput("bias_plot"),
  helpText("All data is from the", a("U.S. Social Security Administration", href = "http://www.ssa.gov/oact/babynames/limits.html"),
           align = "center")
  
))