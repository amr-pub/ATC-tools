
#' @title
#'   Write an ATC table to .csv
#'
#' @param atc_table
#'   An ATC table.
#'
#' @param atc_L1_code
#'   String: an ATC level 01 group code.
#'
#' @param atc_type
#'   String: an ACT type ('ATC'|'ATCvet').
#'
#' @return
#'   None.
#'
#' @importFrom here here
#' @importFrom readr write_csv
#'
#' @export

write_atc_table_csv <- function(atc_table,
                                atc_L1_code = '',
                                atc_type     = '') {

  write_path <- here::here(atc_type, atc_L1_code)
  write_path <- paste0(write_path, ".csv")

  readr::write_csv(atc_table,
                   file = write_path)

}
