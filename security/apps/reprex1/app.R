library(shiny)

ui <- fluidPage(
  textInput("message", "Entre ton message"),
  uiOutput("template")
)

server <- function(input, output, session) {
  output$template <- renderUI({
    htmlTemplate(
      "template.html",
      message = input$message
    )
  })
}

shinyApp(ui, server, options = list(display.mode = "showcase"))
