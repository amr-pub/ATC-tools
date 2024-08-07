
#' @title
#'   Save an ATC index item page
#'
#' @param pageobj
#'   An ATC page object: a list of the atc_code, page URL, and the page contents.
#'
#' @param atc_type
#'   String: an ACT type ('atc'|'atcvet').
#'
#' @return
#'   NA
#'
#' @importFrom here here
#' @importFrom xml2 write_html
#'
#' @export


save_atc_page <-

  function(pageobj,
           atc_type = '') {

    atc_code   <- pageobj$atc_code

    write_path <- here::here("scrape",
                             "html",
                             atc_type,
                             atc_code)

    write_path <- paste0(write_path, ".html")

    xml2::write_html(x    = pageobj$page,
                     file = write_path)

}




