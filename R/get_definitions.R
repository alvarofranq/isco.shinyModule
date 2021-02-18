#' @export
get_definitions <- function(lang = 'eng'){

  lang <- tolower(lang)

  file <- switch (lang,
                  'eng' = 'isco-08-eng.json',
                  'spa' = 'isco-08-spa.json',
                  'fre' = 'isco-08-fre.json',
                  'isco-08-eng.json'
  )

  path <- system.file("isco-08", file, package = "isco.shinyModule")

  jsonlite::read_json(path, simplifyVector = TRUE)

}
