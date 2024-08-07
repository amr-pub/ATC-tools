
#' @title
#'   Get child codes
#'
#' @param pagedata
#'   Page data.
#'
#' @return
#'   Child codes.
#'
#' @export


get_child_codes <- function(pagedata) {
  unlist(lapply(pagedata, '[[', "child_atc_codes"))
}
