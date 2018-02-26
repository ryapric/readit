context("readit reads reliably")

test_that("Identical .txts, different delimiters", {

  comma_sep_quote <- readit(system.file("examples", "comma_sep_quote.txt", package = packageName()))
  comma_sep_noquote <- readit(system.file("examples", "comma_sep_noquote.txt", package = packageName()))
  semi_sep <- readit(system.file("examples", "semi_sep.txt", package = packageName()))
  tab_sep <- readit(system.file("examples", "tab_sep.txt", package = packageName()))
  pipe_sep <- readit(system.file("examples", "pipe_sep.txt", package = packageName()))
  space_sep <- readit(system.file("examples", "space_sep.txt", package = packageName()))

  txt_list <- list(comma_sep_quote, comma_sep_noquote, semi_sep, tab_sep, pipe_sep, space_sep)

  for (d in txt_list) {
    for (i in 1:length(txt_list)) {
      expect_true(dplyr::all_equal(d, txt_list[[i]]))
    }
  }

})



test_that("Identical files, different formats", {

  tab_sep <- readit(system.file("examples", "tab_sep.txt", package = packageName()))
  csv <- readit(system.file("examples", "csv.csv", package = packageName()))
  xls <- readit(system.file("examples", "xls.xls", package = packageName()))
  xlsx <- readit(system.file("examples", "xlsx.xlsx", package = packageName()))

  file_list <- list(tab_sep, csv, xls, xlsx)

  for (d in file_list) {
    for (i in 1:length(file_list)) {
      expect_true(dplyr::all_equal(d, file_list[[i]]))
    }
  }

})
