test_that("basic search works", {
    results <- search_doi_links("10.1101/133173")
    expect_s3_class(results, "tbl_df")
    expect_true(all(c("doi", "score", "match") %in% colnames(results)))
})
