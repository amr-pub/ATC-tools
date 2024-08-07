
#' @title
#'   Extract the ATC hierarchy from an ACT page object
#'
#' @param atcpageobj
#'   An ATC page object: a list of the atc_code, page URL, and the page contents.
#'
#' @param atc_type
#'   String: an ACT type ('atc'|'atcvet').
#'
#' @return
#'   A list of page data.
#'
#' @importFrom rvest html_elements html_text2
#' @importFrom stringr str_detect str_extract
#'
#' @export


extract_atc_hierarchy <-

  function(atcpageobj,
           atc_type) {

  # Get atcpageobj elements.
  atc_code <- atcpageobj$atc_code
  pageurl  <- atcpageobj$pageurl
  page     <- atcpageobj$page

  # Get all page link elements.
  nodeset <- rvest::html_elements(page, "a")

  # Only keep hierarchy elements.
  nodeset <- nodeset[stringr::str_detect(as.character(nodeset), "code=")]

  # Extract ATC codes.
  atc_hierarchy_codes <- stringr::str_extract(as.character(nodeset),
                                              "(?<=code=)(\\w+)")
  # Extract ATC names.
  atc_hierarchy_names <- rvest::html_text2(nodeset)

  # On ATC/DDD pages (not ATCvet pages), the first link with "code=" is not
  # part of the hierarchy, it's a repeat. Drop it.
  if (tolower(atc_type) == "atc") {
    atc_hierarchy_codes <- atc_hierarchy_codes[-1]
    atc_hierarchy_names <- atc_hierarchy_names[-1]}

  # Child codes are codes that are longer than passed in the atcpageobj.
  child_atc_codes <- atc_hierarchy_codes[which(nchar(atc_hierarchy_codes) > nchar(atc_code))]
  child_atc_names <- atc_hierarchy_names[which(nchar(atc_hierarchy_codes) > nchar(atc_code))]

  # Return.
  outlist <- list(atc_code            = atc_code,
                  atc_hierarchy_codes = atc_hierarchy_codes,
                  atc_hierarchy_names = atc_hierarchy_names,
                  child_atc_codes     = child_atc_codes,
                  child_atc_names     = child_atc_names)

  return(outlist)

}
