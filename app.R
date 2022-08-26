library(shiny)
library(jsonlite)

ui <- fluidPage(
    class = "container",
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
        tags$link(rel = "stylesheet",
                  href = "app.css"),
        tags$script(src = "app.js"),
        tags$link(rel = "stylesheet",
                  href = paste0(
                      "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/",
                      "bulma.min.css")),
        # CSS to override the color settings in the bootstrap file
        tags$style(
            HTML(
                "
                .form-control.selectize-control .selectize-input.focus {
                      border-color: #00008B;
                      box-shadow: 0 0 0 0;
                }

                .form-control.selectize-control .selectize-dropdown .selectize-dropdown-content .option:hover, .form-control.selectize-control .selectize-dropdown .selectize-dropdown-content .option:focus {
                    background-color: #00008B;
                }

                .form-control.selectize-control .selectize-dropdown .selectize-dropdown-content .option.active, .form-control.selectize-control .selectize-dropdown .selectize-dropdown-content .option:active {
                    background-color: #00008B;
                }
                "
            )
        )
    ),

        fluidRow(
            class = "m-3",
            tags$h1("Example Selectize Input")
        ),
        fluidRow(
            class = "m-3",
            # To apply Bootstrap theme, need to add "form-control" class
            tags$select(
                id = "selectize",
                class = "form-control",
                `multiple` = TRUE
            )
        ),
        fluidRow(
            class = "m-3",
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
