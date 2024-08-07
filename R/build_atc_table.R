
#' @title
#'   Build an ATC table from page data
#'
#' @param pagedata
#'   Page data, created through extract_atc_hierarchy.
#'
#' @return
#'   An ATC table.
#'
#' @importFrom dplyr  as_tibble bind_cols
#'
#' @export


build_atc_tbl <-

  function(pagedata) {

    atc_hierarchy_codes <- pagedata$atc_hierarchy_codes
    atc_hierarchy_names <- pagedata$atc_hierarchy_names
    child_atc_codes     <- pagedata$child_atc_codes
    child_atc_names     <- pagedata$child_atc_names
    parent_atc_codes    <- atc_hierarchy_codes[!atc_hierarchy_codes %in%  child_atc_codes]
    parent_atc_names    <- atc_hierarchy_names[!atc_hierarchy_codes %in%  child_atc_codes]
    nchildren           <- length(child_atc_codes)
    nparents            <- length(parent_atc_codes)


    colns               <- c("atc_level_01",
                             "atc_level_02",
                             "atc_level_03",
                             "atc_level_04",
                             "atc_level_05")


    # If there are no children (a terminal page), return a one-row table.
    if (nchildren == 0) {

      newrow   <- c(atc_hierarchy_codes,
                    atc_hierarchy_names)

      newnames <- c(paste0(colns[1:(nparents)], "_code"),
                    paste0(colns[1:(nparents)], "_name"))

      names(newrow) <- newnames
      return(as_tibble(t(as.data.frame(newrow))))}


    # Build a code matrix, and append the child code column.
    codem <- matrix(rep(parent_atc_codes, nchildren),
                    ncol  = nparents,
                    byrow = TRUE)

    codem <- dplyr::bind_cols(codem,
                              child_atc_codes,
                              .name_repair = c("unique_quiet"))

    names(codem) <- paste0(colns[1:(nparents+1)], "_code")


    # Build a name matrix, and append the child name column.
    namem <- matrix(rep(parent_atc_names, nchildren),
                    ncol  = nparents,
                    byrow = TRUE)

    namem <- dplyr::bind_cols(namem,
                              child_atc_names,
                              .name_repair = c("unique_quiet"))

    names(namem) <- paste0(colns[1:(nparents+1)], "_name")

    # Bind tables and return.
    return(dplyr::bind_cols(codem, namem))

}
