#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate plot
        ggplot2::ggplot() + ggplot2::geom_point(mapping = ggplot2::aes(1:100, log(1:100))) +
            ggplot2::geom_point(mapping = ggplot2::aes(input$time, log(input$time), 
                                                       size = 20, color = "red"))

    })

})