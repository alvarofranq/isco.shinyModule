# isco.shinyModule
An International Standard Classification Of Occupations Shiny Module

## Overview

A shiny module which allow the user to include a International Standard Classification of Occupations user interface.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("alvarofranq/isco.shinyModule")
```

## Usage 

```r 
library(shiny)

ui <- fluidPage(

 sidebarLayout(

   sidebarPanel(
     width = 3,
     isco_ui("isco")
   ),

   mainPanel(
     tableOutput("tbl")
   )
 )

)

server <- function(input, output, session) {

 mod_data <- isco_server("isco", lang = 'spa')


 output$tbl <- renderTable({

   get_definitions(lang = 'spa') %>%
     filter(major_code == mod_data$major_code()) %>%
     filter(submajor_code == mod_data$submajor_code()) %>%
     filter(minor_code == mod_data$minor_code()) %>%
     filter(unit_code == mod_data$unit_code()) %>%
     select(
       major_name,
       submajor_name,
       minor_name,
       unit_name
     )

 })



}

shinyApp(ui, server)
```
