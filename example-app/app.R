library(shiny)

recursiveModuleUI <- function(id) {
    ns <- NS(id)

    uiOutput(ns("ui_output"))
}

recursiveModule <- function(input, output, session, id, id_max) {
    ns <- session$ns
    output$ui_output <- renderUI({
        browser()
        if (id <= id_max) {
            callModule(recursiveModule, paste0("id_",id+1), id+1, id_max)
        }
        tagList(
            htmltools::tags$b(paste0("ID: ", id)),
            htmltools::tags$br(),
            ifelse(id <= id_max, recursiveModuleUI(ns(paste0("id_", id+1))), htmltools::tags$b("Max Reached"))
        )
    })
}

ui <- fluidPage(

    titlePanel("Example Recursive App"),

    sidebarLayout(
        sidebarPanel(
        ),

        mainPanel(
            uiOutput("ui")
        )
    )
)

server <- function(input, output) {
    callModule(recursiveModule, "root", 0, 2)

    output$ui <- renderUI(
        recursiveModuleUI("root")
    )
}

shinyApp(ui = ui, server = server)
