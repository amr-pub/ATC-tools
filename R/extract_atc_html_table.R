
#' @title
#'   Extract a L5 ATC/DDD table from a page object.
#'
#' @description
#'   The ATC/DDD index is reported in an HTML table; get the table.
#'
#' @param atcpageobj
#'   An ATC page object: a list of the atc_code, page URL, and the page contents.
#'
#' @return
#'   A L5 ATC/DDD table.
#'
#' @importFrom dplyr across all_of mutate na_if
#' @importFrom rvest html_table
#' @importFrom tidyr fill
#'
#' @export
#'

extract_atc_ddd_tbl <- function(atcpageobj) {

  # html_table() returns all HTML table objects.
  # On a standard L4 page there is one L5 table, and one or more notes stored
  # as table objects. On a terminal L4 page there is no L5 table, and one
  # or more notes stored as table objects.
  L5_table_objs  <- rvest::html_table(atcpageobj$page, header = TRUE)

  # If there are no table objects, return.
  if (length(L5_table_objs) == 0) {return()}

  # Table objects with six columns are L5 tables.
  L5_tbl        <- L5_table_objs[which(lapply(L5_table_objs, ncol) == 6 )]

  # If there are no L5 table objects, return.
  # This is a terminal L4 table; dropped notes will be captured when making
  # L4 tables.
  if (is_empty(L5_tbl)) {return()}

  # L5_tbl is nested; unnest.
  L5_tbl <- L5_tbl[[1]]

  # Get notes, read as column names across one or more table objects.
  L5_tbl_note   <- L5_table_objs[which(lapply(L5_table_objs, ncol) != 6 )]
  L5_tbl_note   <- paste(lapply(L5_tbl_note, names), collapse = " ")

  # Set column naes
  names(L5_tbl) <-c("atc_level_05_code", "atc_level_05_name", "DDD",
                    "unit", "administration_route", "atc_level_05_note")

  # Add table level (L04) note.
  L5_tbl$atc_level_04_note <- L5_tbl_note

  # Replace empty strings with NA.
  L5_tbl <- dplyr::mutate(L5_tbl,
                          dplyr::across(where(is.character), ~ dplyr::na_if(.,"")))

  # Fill, where multiple routes of administration are given.
  L5_tbl <- tidyr::fill(L5_tbl,
                        .direction = c("down"),
                        dplyr::all_of(c("atc_level_05_code", "atc_level_05_name")))

  return(L5_tbl)

}
