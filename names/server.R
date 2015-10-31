library(shiny)
library(dplyr)
library(ggplot2)
library(directlabels)
library(langcog)
library(stringr)
font <- "Open Sans"

input <- list(names = "Addison, Adrian, Ainsley, Alex, Alexis, Angel, Arden, Ashley, Aubrey, Avery, Bailey, Beverly, Blair, Brett, Cameron, Casey, Cassidy, Chance, Chase, Cherokee, Cody, Cory, Courtney, Dakota, Dale, Dana, Darby, Darcy, Devon, Dominique, Drew, Dylan, Elliott, Ellis, Emerson, Emery, Evelyn, Finley, Fran, Gale, Grayson, Hadley, Harlow, Harper, Hayden, Hayley, Hillary, Hollis, Hunter, Iman, Jamie, Jayden, Jocelyn, Jordan, Joyce, Kai, Keegan, Kelly, Kelsey, Kendall, Kennedy, Kim, Kimberly, Lee, Leslie, Lindsay, Logan, London, Luca, Lynn, Mackenzie, Madison, Marlowe, Meredith, Micah, Morgan, Murphy, Noel, Noor, Parker, Paris, Peyton, Phoenix, Quinn, Randy, Reese, Reilly, Remy, River, Robin, Rory, Rowan, Ryan, Sage, Sawyer, Shannon, Shelby, Shirley, Sheridan, Shiloh, Sidney, Sky, Skyler, Stacy, Teagan, Terry, Taylor, Tracy, Vivian, Whitney")
shinyServer(function(input, output) {
  
  names <- reactive({
    unlist(lapply(unlist(strsplit(input$names, ",")), str_trim))
  })
  
  output$bias_plot <- renderPlot({
    ggplot(filter(name_data, name %in% names()),
           aes(x = year, y = femaleness, colour = name, label = name)) +
    geom_line() +
    #geom_dl(method = list(dl.trans(x = x + 0.2), "last.qp", cex = 1,
    #                      fontfamily = font)) +
    scale_x_continuous(name = "", limits = c(1880, 2020),
                       breaks = seq(1880, 2000, by = 20)) +
    scale_y_continuous(name = "", limits = c(0, 1), breaks = c(0, 0.5, 1),
                       labels = c("All Boys", "Equal", "All Girls")) +
    scale_colour_solarized(guide = FALSE) +
    theme_bw(base_size = 14) +
    theme(text = element_text(family = font))
  })

#   output$count_plot <- renderPlot({
#     ggplot(filter(name_data, name %in% names()),
#            aes(x = year, y = total, colour = name, label = name)) +
#       geom_line() +
#       geom_dl(method = list(dl.trans(x = x + 0.2), "last.qp", cex = 1)) +
#       scale_x_continuous(name = "", limits = c(1880, 2020),
#                          breaks = seq(1880, 2010, by = 20)) +      
#       scale_y_continuous(limits = c(0, 100000)) +
#       scale_colour_solarized(guide = FALSE) +
#       theme_bw(base_size = 14)
#   })
  
})