
library(graphics)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(readxl)


ui <- dashboardPage(
    dashboardHeader(title = "Comercial Agropres S.L."),
    dashboardSidebar(
        sidebarMenu(
            menuItem(text = "Introduccion de datos", tabName = 'intr_datos', icon = icon('file-import')),
            menuItem(text = "Filtrado", tabName = 'filtrado', icon = icon('filter')),
            menuItem(text = "Grafico de clientes", tabName = "g_clientes", icon = icon("chart-bar")),
            menuItem(text = "Grafico de operarios", tabName = "g_operarios", icon = icon("chart-area")),
            menuItem(text = 'Grafico interactivo', tabName = 'g_inter', icon = icon('pencil-alt'))
            
        )
    ),
    dashboardBody(
        tabItems(
            tabItem('intr_datos',
                    fluidPage(
                        theme = shinytheme("cosmo"),
                        titlePanel("Introduccion de datos"),
                        
                        fileInput(inputId = "ABC", label = "Selecione un archivo:", multiple = FALSE, accept = NULL,
                                  width = NULL, buttonLabel = "Buscar...",
                                  placeholder = "Ningun archivo seleccionado"),
                        
                        actionButton(inputId = "submit", label = "Mostrar todos los datos"),
                        hr(),
                        
                        dataTableOutput("XX")
                    )
            ),
            tabItem('filtrado',
                      fluidPage(
                          theme = shinytheme("cosmo"),
                          titlePanel("Filtrado"),
                          
                          fluidRow(
                              column(4,
                                     selectInput("client",
                                                 "Cliente:",
                                                 c("Todos", unique(obtener_clientes(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)), "Empresa"))
                              ),
                              column(4,
                                     selectInput("ope",
                                                 "Operario:",
                                                 c("Todos", unique(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410$Operario)))
                              ),
                              column(4,
                                     selectInput("ape",
                                                 "Apero:",
                                                 c("Todos", unique(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410$Apero)))
                                     
                              )),
                          actionButton('fact', label = "Facturacion"),
                          
                          dateRangeInput("dates", label = ("Date range:"), format = "dd-mm"),
                          
                          actionButton(inputId = "filtrar", label = "Filtrar"),
                          hr(),
                          
                          dataTableOutput("table")
                      )
            ),

            tabItem("g_clientes", 
                fluidPage(
                    theme = shinytheme("cosmo"),
                    titlePanel("Grafico de clientes"),
                    
                    box(
                        selectInput("features", "Seleccione una categoria:", 
                                    names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)), 
                        width = 13)),
                    box(
                        plotOutput("Correlation_plot", height = 700), width = 13, height = 800)
             ),
             tabItem("g_operarios", 
                    fluidPage(
                        theme = shinytheme("cosmo"),
                        titlePanel("Grafico de operarios"),
                        
                        box(
                            selectInput("seleccion1", "Seleccione primera variable:", 
                                        names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)), 
                            width = 6),
                        box(
                            selectInput("seleccion2", "Seleccione segunda variable:", 
                                        names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)), 
                            width = 6),
                        box(plotOutput("comp_ope", height = 700), width = 13, height = 800)
                    )
             ),
            tabItem('g_inter',
                    fluidPage(
                        theme = shinytheme('cosmo'),
                        titlePanel("Grafico interactivo"),
                        box(
                            helpText(),
                            selectInput('x', 'Variable 1 a analizar:',
                                        choices = names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)[-1]),
                            selectInput('y', 'Variable 2 a analizar:',
                                        choices = names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)[-1]),
                            selectInput('z', 'Variable 3 a analizar:',
                                        choices = names(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410)[-1]),
                            actionButton('show', label = "Analizar")
                        )),
                    box(
                        mainPanel(
                            plotOutput("plot"),
                            width = 13
                            
                        )
                    ))
)))


server <- function(input, output){
    observeEvent(input$submit, {
        data <- read_excel(input$ABC$datapath, skip = 7)
        
        output$XX <- renderDataTable({
            datatable(data)
        })
    })
    # Filter data based on selections
    observeEvent(input$filtrar, {
        data <- read_excel(input$ABC$datapath, skip = 7)
        if (input$client != "Todos" & input$client != "Empresa") {
            data <- data[data$Cliente == input$client,]
        }
        if (input$client == "Empresa") {
            data <- data %>%
                filter(stri_detect_regex(data$Cliente,"01.*"))
        }
        if (input$ope != "Todos") {
            data <- data[data$Operario == input$ope,]
        }
        if (input$ape != "Todos") {
            data <- data[data$Apero == input$ape,]
        }
        output$table <- renderDataTable({
            datatable(data)
        })
    })
    
    observeEvent(input$show, {
        data <- read_excel(input$ABC$datapath, skip = 7)
        data$x <- data[,input$x]
        data$y <- data[,input$y]
        data$z <- data[,input$z]
    
        output$plot <- renderPlot({
            ggplot(data, mapping = aes(x = x, y = y))+     
                geom_point(mapping = aes(color = z))+         
                labs(title = "Color mapped to continuous column")        })
    })
    
    output$Correlation_plot <- renderPlot({
        ggplot(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410) +
        geom_count(mapping = aes(Cliente, .data[[input$features]], color = Cliente)) + 
            theme(axis.text.x = element_text(angle = 65, vjust = 1, hjust = 1), legend.position = "top") 
        })
    output$comp_ope <- renderPlot({
        ggplot2::ggplot(Informe_Partes_de_Trabajo_Todas_19_07_2021_181410) +
        ggplot2::geom_count(mapping = ggplot2::aes(.data[[input$seleccion1]], .data[[input$seleccion2]], color = Operario)) + 
            ggplot2::theme(axis.text.x = element_text(angle = 65, vjust = 1, hjust = 1), legend.position = "right") 
        
        })
}

shinyApp(ui, server)