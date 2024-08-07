
#' @title
#'   Save scrape session
#'
#' @description
#'   Save all objects in the global environment.
#'
#' @param atc_L1_code
#'   String: an ATC level 01 group code.
#'
#' @param atc_type
#'   String: an ACT type ('atc'|'atcvet').
#'
#' @return
#'   None.
#'
#' @importFrom here here
#'
#' @export

save_atc_scrape <-

    function(atc_L1_code,
             atc_type) {

    savename <- paste0(atc_type, "_",
                       atc_L1_code, "_",
                       format(Sys.time(), "%Y_%m_%d"),
                       ".RData")

    savepath <- here::here("scrape", savename)

    save(list = ls(envir = .GlobalEnv), file = savepath, envir = .GlobalEnv)

    return(message("Saved scrape data files."))

}



