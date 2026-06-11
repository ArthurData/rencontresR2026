library(shiny)

ui <- fluidPage(
  h2("Upload d'un objet RDS"),
  fileInput(
    inputId = "file",
    label = "Choisis un fichier stp"
  ),
  verbatimTextOutput(
    outputId = "result"
  )
)

server <- function(input, output, session) {
  output$result <- renderPrint({
    req(input$file)

    obj <- readRDS(input$file$datapath)

    obj()
  })
}

shinyApp(ui = ui, server = server, options = list(display.mode = "showcase"))
