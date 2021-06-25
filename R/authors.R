#' Get Crossref authors string
#'
#' Convert the authors table from Crossref into a single string. It has the form
#' "LastName1, FirstName1; LastName2, FirstName2;...".
#'
#' @param cr_authors Authors data.frame from a Crossref query
#'
#' @return Character vector with authors names
get_cr_authors_str <- function(cr_authors) {

    has_family <- "family" %in% colnames(cr_authors)
    has_given  <- "given" %in% colnames(cr_authors)
    has_name   <- "name" %in% colnames(cr_authors)

    if (has_family) {
        if (has_given) {
            authors <- paste0(cr_authors$family, ", ", cr_authors$given)
        } else {
            authors <- cr_authors$family
        }
    } else if (has_name) {
        authors <- cr_authors$name
    } else {
        authors <- ""
    }

    authors_str <- paste(authors, collapse = "; ")

    return(authors_str)
}

#' Get first author ORCiD
#'
#' Return the ORCiD for the first author of a reference.
#'
#' @param cr_authors Authors data.frame from a Crossref query
#'
#' @return Character vector with ORCiD or `NA` if not found
get_first_orcid <- function(cr_authors) {

    if (!("ORCID" %in% colnames(cr_authors))) {
        return(NA)
    }

    orcid <- cr_authors$ORCID[1]

    return(orcid)
}

#' Same first author
#'
#' Check if two author strings have the same first author.
#'
#' @param authors_str1 Character vector containing first authors list
#' @param authors_str2 Character vector containing second authors list
#'
#' @details
#' Last names of the first authors are compared. If these match then first names
#' are checked and `TRUE` is returned if either the whole first name or first
#' initial matches. If first and last names cannot be separated the whole author
#' names are compared. Some simplification of characters in names is performed
#' to improve matches.
#'
#' @return Logical whether first authors are the same
same_first_author <- function(authors_str1, authors_str2) {

    authors_str1 <- stringi::stri_trans_general(authors_str1, "Latin-ASCII")
    authors_str2 <- stringi::stri_trans_general(authors_str2, "Latin-ASCII")

    author1 <- stringr::str_split(authors_str1, ";")[[1]][1]
    author2 <- stringr::str_split(authors_str2, ";")[[1]][1]

    author1 <- stringr::str_to_lower(stringr::str_replace(author1, "-", " "))
    author2 <- stringr::str_to_lower(stringr::str_replace(author2, "-", " "))

    author_names1 <- stringr::str_squish(stringr::str_split(author1, ",")[[1]])
    author_names2 <- stringr::str_squish(stringr::str_split(author2, ",")[[1]])

    # No separable first/last names
    if (length(author_names1) == 1 || length(author_names1) == 2) {
        return(author1 == author2)
    }

    # Last names don't match
    if (author_names1[1] != author_names2[1]) {
        return(FALSE)
    }

    # First names match
    if (author_names1[2] == author_names2[2]) {
        return(TRUE)
    }

    initial1 <- stringr::str_sub(author_names1[2], start = 1, end = 1)
    initial2 <- stringr::str_sub(author_names2[2], start = 1, end = 1)

    # First initials match
    if (initial1 == initial2) {
        return(TRUE)
    }

    return(FALSE)
}
