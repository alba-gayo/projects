
library(shiny)
library(shinydashboard)
library(ggplot2)
 
ui <- dashboardPage(
    dashboardHeader(title = "Comercial Agropres S.L."),
    dashboardSidebar(
        sidebarMenu(
            menuItem(text = "Grafico de clientes", tabName = "g_clientes", icon = icon("tree")),
            menuItem(text = "Grafico de operarios", tabName = "g_operarios", icon = icon("dashboard"))
            
        )
    ),
    dashboardBody(
        tabItems(
            tabItem("g_clientes", "Grafico de clientes",
                fluidPage(
                    box(
                        selectInput("features", "Seleccione una categoria:", 
                                    names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)), 
                        width = 4)),
                    box(
                        plotOutput("Correlation_plot", height = 700), width = 13, height = 800)
             ),
             tabItem("g_operarios", "Grafico de operarios",
                    fluidPage(
                        box(
                            selectInput("seleccion1", "Seleccione primera variable:", 
                                        names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)), 
                            width = 4),
                        box(
                            selectInput("seleccion2", "Seleccione segunda variable:", 
                                        names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)), 
                            width = 4),
                        box(plotOutput("comp_ope", height = 700), width = 13, height = 800)
                    )
             )
)))


server <- function(input, output){
    output$Correlation_plot <- renderPlot({
        ggplot2::ggplot(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410) +
        ggplot2::geom_count(mapping = ggplot2::aes(Cliente, .data[[input$features]], color = Cliente)) + 
            ggplot2::theme(axis.text.x = element_text(angle = 65, vjust = 1, hjust = 1), legend.position = "top") 
        })
    output$comp_ope <- renderPlot({
        ggplot2::ggplot(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410) +
        ggplot2::geom_count(mapping = ggplot2::aes(.data[[input$seleccion1]], .data[[input$seleccion2]], color = Operario)) + 
            ggplot2::theme(axis.text.x = element_text(angle = 65, vjust = 1, hjust = 1), legend.position = "right") 
        
        })
}

shinyApp(ui, server)