#' @title Get International Standard Classification of Occupations Definitions
#'
#' @description This functions allows the user to load a data.frame containing
#' all the ISCO definitions in multiple languages.
#'
#' @param lang Un carácter indicando el lenguaje que queremos recuperar en formato
#' ISO 639-2 Alpha-3 (https://www.loc.gov/standards/iso639-2/php/code_list.php). This
#' parameter is 'eng' by default. Could be 'eng', 'spa', 'fre' or 'cat'.
#'
#' @examples
#' get_definitions('spa')
#'
#' @return This functions returns a data.frame containing: the major group code (\code{major_code}),
#' the major group name (\code{major_name}), the sub-major code (\code{submajor_code}), the sub-major
#' name (\code{submajor_name}), minor group code (\code{minor_code}), minor group name (\code{minor_name}),
#' unit group code (\code{unit_code}), unit group name (\code{unit_name})
#'
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
