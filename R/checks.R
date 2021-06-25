#' Is DOI preprint
#'
#' Check whether a DOI is from a preprint server.
#'
#' @param doi DOI to check
#' @param container_title Whether or not there is a container title (journal
#' name) associated with the DOI
#'
#' @return Logical whether the DOI is from a preprint
is_doi_preprint <- function(doi, container_title) {

    peerj    <- stringr::str_detect(doi, "^10.7287/")
    square   <- stringr::str_detect(doi, "^10.21203/")
    biorxiv  <- stringr::str_detect(doi, "^10.1101/") && !container_title
    preprint <- biorxiv || peerj || square

    return(preprint)
}

#' Is result a match
#'
#' Decide if a results from a DOI query is a match or not.
#'
#' @param query_title Title of the query reference
#' @param result_title Title of the result reference
#' @param query_orcid ORCiD of the query first author
#' @param result_orcid ORCiD of the result first author
#' @param query_authors Authors string for the query
#' @param result_authors Authors string for the result
#'
#' @details
#' Result is a match if the similarity between titles is sufficiently high or
#' if the similarity is lower by the first author ORCiDs match or the first
#' author names match.
#'
#' @return Logical whether the result is a match or not
is_result_match <- function(query_title, result_title, query_orcid,
                            result_orcid, query_authors, result_authors) {
    title_similarity <- calc_jaccard_similarity(query_title, result_title)

    if (title_similarity >= 0.8) {
        # High title similarity
        return(TRUE)
    } else if (title_similarity >= 0.1) {
        # Low title similarity...
        if (!is.na(query_orcid) && !is.na(result_orcid) &&
            (result_orcid == query_orcid)) {
            # ...and same first author ORCiD
            return(TRUE)
        }
        if (same_first_author(query_authors, result_authors)) {
            # ...or same first author name
            return(TRUE)
        }
    }

    return(FALSE)
}
