
library(shiny)
library(htmltools)

mod3ui <- function(id) {
    ns <- NS(id)

    tagList(
        tags$b("Three"),
        tags$br()
    )
}

mod3 <- function(input,output,session) {
    ns <- session$ns
}
mod2ui <- function(id) {
    ns <- NS(id)

    tagList(
        tags$b("Two"),
        tags$br(),
        mod3ui(ns("3"))
    )
}

mod2 <- function(input,output,session) {
    ns <- session$ns
    callModule(mod3, ns("3"))
}

mod1ui <- function(id) {
    ns <- NS(id)

    tagList(
        tags$b("One"),
        tags$br(),
        mod2ui(ns("2"))
    )
}

mod1 <- function(input,output,session) {
    ns <- session$ns
    callModule(mod2, ns("2"))
}

ui <- fluidPage(

    titlePanel("Old Faithful Geyser Data"),

    sidebarLayout(
        sidebarPanel(
        ),

        mainPanel(
            mod1ui("1")
        )
    )
)

server <- function(input, output) {
    callModule(mod1, "1")
}

shinyApp(ui = ui, server = server)
