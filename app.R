library(shiny)
library(jsonlite)

ui <- fluidPage(
    tags$head(
        # Get selectize js dependency
        tags$script(src = paste0(
            "https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.13.6",
            "/js/standalone/selectize.min.js")),
        # tags$link(rel = "stylesheet",
        #           href = paste0(
        #               "https://cdnjs.cloudflare.com/ajax/libs/selectize.",
        #               "js/0.13.6/css/selectize.css")),
        # Get stylesheet for selectize js (default above)
        tags$link(rel = "stylesheet",
                  href = "selectize.bootstrap4.css"),
        tags$script(src = "app.js"),
        tags$link(rel = "stylesheet",
                  href = paste0(
                      "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/",
                      "bulma.min.css"))
    ),

        fluidRow(
            tags$h1("Example Selectize Input")
        ),
        fluidRow(
            # To apply Bootstrap theme, need to add "form-control" class
            tags$select(
                id = "selectize",
                class = "form-control",
                `multiple` = TRUE
            )
        ),
        fluidRow(
            actionButton(
                inputId = "load_options",
                "Click to load options"
            )
        )


)

server <- function(input, output, session) {

    observeEvent(input$load_options, {
        options <- rownames(mtcars)

        session$sendCustomMessage(
            type = "load_options",
            message = toJSON(options)
        )
    })

    observeEvent(input$selectize, {
        print(input$selectize)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
