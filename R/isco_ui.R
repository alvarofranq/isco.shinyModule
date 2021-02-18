#' @title International Standard Classification of Occupations UI
#'
#' @description This functions allows the user to build the ISCO user
#' interface in a shiny app.
#'
#' @examples
#' \dontrun{
#' ## Only run examples in interactive R sessions
#' if(interactive()) {
#'
#' options(device.ask.default = FALSE)
#'
#' library(shiny)
#'
#' ui <- fluidPage(
#'
#'  sidebarLayout(
#'
#'    sidebarPanel(
#'      width = 3,
#'      isco_ui("isco")
#'    ),
#'
#'    mainPanel(
#'      tableOutput("tbl")
#'    )
#'  )
#'
#' )
#'
#' server <- function(input, output, session) {
#'
#'  mod_data <- isco_server("isco", lang = 'spa')
#'
#'
#'  output$tbl <- renderTable({
#'
#'    get_definitions(lang = 'spa') %>%
#'      filter(major_code == mod_data$major_code()) %>%
#'      filter(submajor_code == mod_data$submajor_code()) %>%
#'      filter(minor_code == mod_data$minor_code()) %>%
#'      filter(unit_code == mod_data$unit_code()) %>%
#'      select(
#'        major_name,
#'        submajor_name,
#'        minor_name,
#'        unit_name
#'      )
#'
#'  })
#'
#'
#'
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#' }
#'
#' @param id The input slot that will be used to access the value
#'
#' @import shiny
#' @import dplyr
#' @importFrom stats setNames
#'
#' @export
isco_ui <- function(id) {

  ns <- NS(id)

  tagList(

    uiOutput(ns("major")),
    uiOutput(ns("submajor")),
    uiOutput(ns("minor")),
    uiOutput(ns("unit"))

  )

}

