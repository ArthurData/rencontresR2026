library(shiny)
library(glue)

ui <- fluidPage(
  h2("Exemple :"),
  selectInput(
    inputId = "color",
    label = "Choisis une couleur :",
    choices = c(
      "red",
      "green",
      "blue"
    )
  ),
  verbatimTextOutput(
    outputId = "message"
  )
)

server <- function(input, output, session) {
  output$message <- renderText({
    glue(input$color)
  })
}

shinyApp(ui = ui, server = server, options = list(display.mode = "showcase"))
