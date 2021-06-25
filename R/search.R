#' Search DOI links
#'
#' Search Crossref for potential linked references for a DOI
#'
#' @param doi DOI to query
#' @param preprint Logical. Whether `doi` is a preprint (`TRUE`) or publication
#' (`FALSE`). If `NULL` (default) attempt to determine this from `doi`.
#' @param limit Number of Crossref results to return. Default is 20, max is
#' 1000.
#' @param filter_matches Logical. If `TRUE` only return matches rather than all
#' Crossref results.
#' @param verbose Logical. Whether or not to print progress messages.
#'
#' @details
#' Based on the method described in "Day-to-day discovery of
#' preprint–publication links" https://doi.org/10.1007/s11192-021-03900-7 and
#' code from https://github.com/gcabanac/preprint-publication-linker. Query
#' filters have been modified to allow reverse linking publications to preprints
#' as well as preprints to publications.
#'
#' @return tibble of potential links
#' @export
#'
#' @examples
#' search_doi_links("10.1101/133173")
search_doi_links <- function(doi, preprint = NULL, limit = 20,
                             filter_matches = FALSE, verbose = TRUE) {

    if (verbose) {message("Retrieving query data from Crossref...")}
    query_data <- rcrossref::cr_works(doi)$data

    query_title   <- query_data$title
    query_authors <- get_cr_authors_str(query_data$author[[1]])
    query_issued  <- query_data$issued
    query_orcid   <- get_first_orcid(query_data$author[[1]])

    if (is.null(preprint)) {
        query_preprint <- is_doi_preprint(
            doi,
            container_title = "container.title" %in% colnames(query_data)
        )
        if (verbose) {
            if (query_preprint) {
                message("Decided query is a preprint")
            } else {
                message("Decided query is a publication")
            }
        }
    } else {
        query_preprint <- preprint
    }

    if (query_preprint) {
        filters <- c(
            from_created_date = query_issued,
            type              = "journal-article",
            type              = "proceedings-article",
            type              = "book-chapter",
            type              = "book-part",
            type              = "book-section"
        )
    } else {
        filters <- c(
            until_created_date = query_issued,
            type               = "posted-content"
        )
    }

    if (verbose) {message("Retrieving results data from Crossref...")}
    results <- rcrossref::cr_works(
        query = "", # Fails if query is not set
        flq   = c(
            query.bibliographic = query_title,
            query.author        = query_authors
        ),
        filter = filters,
        limit  = limit,
        sort   = "score",
        order  = "desc"
    )$data
    if (verbose) {message("Found ", nrow(results), " results")}

    if (verbose) {message("Checking results for matches...")}
    is_match <- purrr::map_lgl(seq_len(nrow(results)), function(.idx) {

        results_row <- results[.idx, ]

        result_title   <- results_row$title
        result_authors <- get_cr_authors_str(results_row$author[[1]])
        result_orcid   <- get_first_orcid(results_row$author[[1]])

        is_result_match(query_title, result_title, query_orcid, result_orcid,
                        query_authors, result_authors)
    })

    results$match <- is_match

    if (filter_matches) {
        if (verbose) {message("Filtering matches...")}
        results <- results[is_match, ]
    }

    if (verbose) {message("Done!")}
    return(results)
}
