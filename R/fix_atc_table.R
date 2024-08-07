
#' @title
#'   Clean DDD columns
#'
#' @description
#'   pivot_wider() of DDD cols creates unsafe column names. Rename those columns.
#'
#' @param ATCtable
#'   An ATC table with unsafe column names.
#'
#' @return
#'   An ATC table with safe column names.
#'
#' @importFrom dplyr if_else mutate rename select
#'
#' @export


clean_DDD_cols <- function(ATCtable) {

  col_map <- c(DDD_inhalesolution  = "DDD_Inhal.solution",
               unit_inhalesolution = "unit_Inhal.solution",
               DDD_oral_aerosol    = "DDD_oral aerosol",
               unit_oral_aerosol   = "unit_oral aerosol",
               DDD_sc_implant      = "DDD_s.c. implant",
               unit_sc_implant     = "unit_s.c. implant",
               DDD_inhalepowder    = "DDD_Inhal.powder",
               unit_inhalepowder   = "unit_Inhal.powder",
               DDD_chewing_gum     = "DDD_Chewing gum",
               unit_chewing_gum    = "unit_Chewing gum",
               DDD_inhale          = "DDD_Inhal",
               unit_inhale         = "unit_Inhal",
               DDD_inhaleaerosol   = "DDD_Inhal.aerosol",
               unit_inhaleaerosol  = "unit_Inhal.aerosol",
               DDD_instillsolution = "DDD_Instill.solution",
               unit_instillsolution= "unit_Instill.solution")

  ATCtable <- dplyr::rename(ATCtable, dplyr::any_of(col_map))


  # Fix for ATC-R, where two variations of the same column appear.
  if ('unit_"Inhal.powder"' %in% names(ATCtable)) {

    ATCtable <- dplyr::mutate(ATCtable,
                              DDD_inhalepowder =  dplyr::if_else(is.na(.data$'DDD_"Inhal.powder"'),
                                                                 DDD_inhalepowder,
                                                                 .data$'DDD_"Inhal.powder"'),
                              unit_inhalepowder =  dplyr::if_else(is.na(.data$'unit_"Inhal.powder"'),
                                                                  unit_inhalepowder,
                                                                  .data$'unit_"Inhal.powder"'))

    dplyr::select(ATCtable, -c('DDD_"Inhal.powder"', 'unit_"Inhal.powder"'))}

}


