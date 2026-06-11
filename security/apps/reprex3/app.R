library(shiny)
library(glue)

ui <- fluidPage(
  textInput(
    inputId = "template",
    label = "Tape ton template (ex: Hello {Sys.Date()}):",
    value = ""
  ),
  h3("Résultat de l'évaluation :"),
  verbatimTextOutput(
    outputId = "result"
  )
)

server <- function(input, output, session) {
  output$result <- renderText({
    glue("Ton choix est : {input$template}")
  })
}

shinyApp(ui = ui, server = server, options = list(display.mode = "showcase"))
