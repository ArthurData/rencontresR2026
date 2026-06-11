library(shiny)
library(DBI)
library(RSQLite)

DB_PATH <- "comments.sqlite"

init_db <- function(path) {
  con <- dbConnect(RSQLite::SQLite(), path)
  dbExecute(
    con,
    "
    CREATE TABLE IF NOT EXISTS comments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pseudo TEXT NOT NULL,
      message TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  "
  )
  con
}

read_comments <- function(con) {
  dbGetQuery(con, "SELECT pseudo, message FROM comments ORDER BY id")
}

add_comment <- function(con, pseudo, message) {
  dbExecute(
    con,
    "INSERT INTO comments (pseudo, message) VALUES (?, ?)",
    params = list(pseudo, message)
  )
}

ui <- fluidPage(
  # Demo: rend alert() visible en bandeau rouge pour la presentation
  # (le dialog natif n'est pas visible dans un screencast)
  tags$head(
    tags$style(HTML(
      '
      .xss-alert {
        position: fixed;
        top: 30%;
        left: 50%;
        transform: translateX(-50%);
        background: #dc2626;
        color: white;
        padding: 24px 48px;
        font-family: system-ui, sans-serif;
        font-size: 32px;
        font-weight: bold;
        border-radius: 12px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
        z-index: 99999;
      }
    '
    )),
    tags$script(HTML(
      '
      // Demo: on intercepte alert() pour quil saffiche dans le DOM
      window.alert = function(msg) {
        var div = document.createElement("div");
        div.className = "xss-alert";
        div.textContent = "alerte: " + msg;
        document.body.appendChild(div);
        setTimeout(function() { div.remove(); }, 4000);
      };
    '
    ))
  ),
  h2("Commentaires des utilisateurs"),
  textInput("pseudo", "Ton pseudo :", ""),
  textAreaInput("message", "Ton message :", rows = 3),
  actionButton("envoyer", "Envoyer"),
  tags$hr(),
  h3("Commentaires recus :"),
  uiOutput("commentaires")
)

server <- function(input, output, session) {
  con <- init_db(DB_PATH)
  session$onSessionEnded(function() {
    dbDisconnect(con)
  })

  commentaires <- reactivePoll(
    500,
    session,
    checkFunc = function()
      dbGetQuery(con, "SELECT COUNT(*) FROM comments")[[1]],
    valueFunc = function() read_comments(con)
  )

  observeEvent(input$envoyer, {
    req(input$message)
    add_comment(con, input$pseudo, input$message)
    updateTextAreaInput(session, "message", value = "")
  })

  output$commentaires <- renderUI({
    coms <- commentaires()
    if (nrow(coms) == 0) {
      return(NULL)
    }
    HTML(paste0(
      apply(coms, 1, function(row) {
        glue::glue(
          "<p><strong>{row[['pseudo']]}</strong> : {row[['message']]}</p>"
        )
      }),
      collapse = "\n"
    ))
  })
}

shinyApp(ui, server, options = list(display.mode = "showcase"))
