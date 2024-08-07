
#' @title
#'   Politely scrape an ATC index item page
#'
#' @param atc_code
#'   String: an ATC index code.
#'
#' @param baseURL
#'   String: the base URL to prepend to the ATC index code.
#'
#' @details
#'   The baseURL for the ATC index: "https://atcddd.fhi.no/atc_ddd_index/?code="
#'   The baseURL for the ATCvet index: "https://www.whocc.no/atcvet/atcvet_index/?code="
#'
#' @return
#'   An ATC page object: a list of the atc_code, page URL, and the page contents.
#'
#' @export


polite_scrape_ATC_code <-

  function(atc_code,
           baseURL = "") {

    pageurl    <- paste0(baseURL, atc_code)
    page       <- polite_read_html(pageurl)
    atcpageobj <- list(atc_code = atc_code,
                    pageurl  = pageurl,
                    page     = page)

    return(atcpageobj)

}
