
# library(tidyverse)
# library(ATCtools)
#
# L1_code  <- "V"
# baseURL  <- "https://atcddd.fhi.no/atc_ddd_index/?code="
# atc_type <- "ATC"
#
# # Get L1 pages ------------------------------------------------------------
# L1_codes              <- L1_code
# L1_pages              <- lapply(L1_codes, polite_scrape_ATC_code, baseURL)
# L1_pages_data         <- lapply(L1_pages, extract_atc_hierarchy, atc_type = atc_type)
# lapply(L1_pages, save_atc_page,  atc_type = atc_type)
# beepr::beep("coin")
#
#
# # Get L2 pages ------------------------------------------------------------
# L2_codes              <- get_child_codes(L1_pages_data)
# L2_pages              <- lapply(L2_codes, polite_scrape_ATC_code, baseURL)
# L2_pages_data         <- lapply(L2_pages, extract_atc_hierarchy, atc_type = atc_type)
# lapply(L2_pages, save_atc_page,  atc_type = atc_type)
# beepr::beep("coin")
#
#
# # Get L3 pages ------------------------------------------------------------
# L3_codes              <- get_child_codes(L2_pages_data)
# L3_pages              <- lapply(L3_codes, polite_scrape_ATC_code, baseURL)
# L3_pages_data         <- lapply(L3_pages, extract_atc_hierarchy, atc_type = atc_type)
# L3_pages_nochild_data <- L3_pages_data[unlist(lapply(L3_pages_data,
#                                                      \(x) {length(x$child_atc_names) == 0}))]
# lapply(L3_pages, save_atc_page,  atc_type = atc_type)
# beepr::beep("coin")
#
#
# # Get L4 pages ------------------------------------------------------------
# L4_codes              <- get_child_codes(L3_pages_data)
# L4_pages              <- lapply(L4_codes, polite_scrape_ATC_code, baseURL)
# L4_pages_data         <- lapply(L4_pages, extract_atc_hierarchy, atc_type = atc_type)
# L4_pages_nochild_data <- L4_pages_data[unlist(lapply(L4_pages_data,
#                                                      \(x) {length(x$child_atc_names) == 0}))]
# lapply(L4_pages, save_atc_page,  atc_type = atc_type)
# beepr::beep("fanfare")
#
#
# # Get L5 data -------------------------------------------------------------
#
# L4_pages_child        <- L4_pages[unlist(lapply(L4_pages_data,
#                                                 \(x) {length(x$child_atc_names) > 0}))]
# L4_pages_child_data   <- L4_pages_data[unlist(lapply(L4_pages_data,
#                                                      \(x) {length(x$child_atc_names) > 0}))]
#
# L5_codes              <- get_child_codes(L4_pages_data)
#
# L5_table              <- bind_rows(lapply(L4_pages_child_data, build_atc_tbl))
# L3_tables_list        <- lapply(L3_pages_nochild_data, build_atc_tbl)
# L4_tables_list        <- lapply(L4_pages_nochild_data, build_atc_tbl)
#
#
#
# # ATC ONLY
# L5_table_ddd          <- bind_rows(lapply(L4_pages_child, extract_atc_ddd_tbl))
# L5_table              <- left_join(L5_table,
#                                    select(L5_table_ddd, -atc_level_05_name),
#                                    by = c("atc_level_05_code"))
# L5_table              <- pivot_wider(L5_table,
#                                      names_from = "administration_route",
#                                      values_from = c("DDD", "unit"))
# L5_table              <- select(L5_table, !contains("_NA", ignore.case = FALSE))
#
#
#
# # Format ------------------------------------------------------------------
# ATCtable  <- bind_rows(L5_table, L4_tables_list, L3_tables_list)
# ATCtable  <- arrange(ATCtable, across(everything(ATCtable)))
# ATCtable  <- relocate(ATCtable, sort(tidyselect::peek_vars()))
#
# ATCtable  <- clean_DDD_cols(ATCtable)
#
#
# write_atc_table_csv(ATCtable, L1_code, "ATC")
#
# save_atc_scrape(L1_code, atc_type = atc_type)
#

