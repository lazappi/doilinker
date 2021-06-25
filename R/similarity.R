#' Calculate Jaccard similarity
#'
#' Calculate the Jaccard similarity between two strings. Strings are first
#' tokenised, stop words are removed and tokens are stemmed.
#'
#' @param string1 First string to score similarity
#' @param string2 Second string to score similarity
#'
#' @return Jaccard similarity score
calc_jaccard_similarity <- function(string1, string2) {

    string1 <- stringi::stri_trans_general(string1, "Latin-ASCII")
    string2 <- stringi::stri_trans_general(string2, "Latin-ASCII")

    tokens1 <- stringr::str_split(
        stringr::str_to_lower(string1), "[^\\w\\d/-]"
    )[[1]]
    tokens2 <- stringr::str_split(
        stringr::str_to_lower(string2), "[^\\w\\d/-]"
    )[[1]]

    stopwords <- c(corpus::stopwords_en, "")
    tokens1 <- corpus::stem_snowball(tokens1[!(tokens1 %in% stopwords)])
    tokens2 <- corpus::stem_snowball(tokens2[!(tokens2 %in% stopwords)])

    jaccard <- length(intersect(tokens1, tokens2)) /
        length(union(tokens1, tokens2))

    return(jaccard)
}
