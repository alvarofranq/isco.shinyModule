#' @title International Standard Classification of Occupations Server
#'
#' @description This functions allows the user to build the ISCO server
#' in a shiny app.
#'
#' @param id The input slot that will be used to access the value
#' @param lang Un carácter indicando el lenguaje que queremos recuperar en formato
#' ISO 639-2 Alpha-3 (https://www.loc.gov/standards/iso639-2/php/code_list.php). This
#' parameter is 'eng' by default. Could be 'eng', 'spa', 'fre' or 'cat'.
#'
#' @return The function return a list containing reactives values. The list has 4 elements
#' major_code, submajor_code, minor_code and unit_code.
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
#' @import shiny
#' @import dplyr
#' @importFrom stats setNames
#'
#' @export
isco_server <- function(id, lang = 'SPA') {

  moduleServer(id, function(input, output, session) {

    definitions <- reactiveVal(get_definitions(lang = lang))

    output$major <- renderUI({

      def <- definitions() %>%
        select(.data$major_code, .data$major_name) %>%
        unique()

      choices <- setNames(def$major_code, def$major_name)

      shiny::selectInput(
        inputId = session$ns('major'),
        label = 'Major group:',
        choices = choices
      )

    })

    output$submajor <- renderUI({

      if(is.null(input$major)) {

        return(NULL)

      } else {

        def <- definitions() %>%
          filter(.data$major_code == input$major) %>%
          select(.data$submajor_code, .data$submajor_name) %>%
          unique()

        choices <- setNames(def$submajor_code, def$submajor_name)

        shiny::selectInput(
          inputId = session$ns('submajor'),
          label = 'Sub major group:',
          choices = choices
        )

      }

    })

    output$minor <- renderUI({

      if(is.null(input$submajor)){

        return(NULL)

      } else {

        def <- definitions() %>%
          filter(.data$major_code == input$major) %>%
          filter(.data$submajor_code == input$submajor) %>%
          select(.data$minor_code, .data$minor_name) %>%
          unique()

        choices <- setNames(def$minor_code, def$minor_name)

        shiny::selectInput(
          inputId = session$ns('minor'),
          label = 'Minor group:',
          choices = choices
        )

      }

    })

    output$unit <- renderUI({

      if(is.null(input$minor)){

        return(NULL)

      } else {

        def <- definitions() %>%
          filter(.data$major_code == input$major) %>%
          filter(.data$submajor_code == input$submajor) %>%
          filter(.data$minor_code == input$minor) %>%
          select(.data$unit_code, .data$unit_name) %>%
          unique()

        choices <- setNames(def$unit_code, def$unit_name)

        shiny::selectInput(
          inputId = session$ns('unit'),
          label = 'Minor group:',
          choices = choices
        )

      }

    })

    return(
      list(
        major_code = reactive(input$major),
        submajor_code = reactive(input$submajor),
        minor_code = reactive(input$minor),
        unit_code = reactive(input$unit)
      )
    )


  })

}
