library(shiny)
library(DBI)
library(RSQLite)


con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbExecute(con, "CREATE TABLE users (id INTEGER, name TEXT)")
dbExecute(con, "INSERT INTO users (id, name) VALUES (1, 'Robert'), (2, 'Little'), (3, 'Bobby'), (4, 'Tables'), (5, 'Mom')")

ui <- fluidPage(
  h2("Test d'injection SQL"),
  textInput(
    inputId = "user_input",
    label = "Entrez 1 seul ID pour trouver votre individu"
  ),
  actionButton(
    inputId = "submit",
    label = "Soumettre"
  ),
  tableOutput(
    outputId = "result"
  )
)

server <- function(input, output, session) {
  rv <- reactiveValues()

  observeEvent(input$submit, {
    req(input$user_input)

    rv$query <- paste0("SELECT * FROM users WHERE id = ", input$user_input)
    cat("Requête exécutée : ", rv$query, "\n")

    rv$result <- dbGetQuery(con, rv$query)
  })

  output$result <- renderTable({
    req(rv$result)
    rv$result
  })
}

shinyApp(
  ui = ui,
  server = server,
  options = list(
    display.mode = "showcase"
  )
)
