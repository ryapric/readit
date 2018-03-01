package <- packageName()

context("readit reads reliably")

test_that("Identical .txts, different delimiters", {

  comma_sep_quote <- readit(system.file("examples", "comma_sep_quote.txt", package = package))
  comma_sep_noquote <- readit(system.file("examples", "comma_sep_noquote.txt", package = package))
  semi_sep <- readit(system.file("examples", "semi_sep.txt", package = package))
  tab_sep <- readit(system.file("examples", "tab_sep.txt", package = package))
  pipe_sep <- readit(system.file("examples", "pipe_sep.txt", package = package))
  space_sep <- readit(system.file("examples", "space_sep.txt", package = package))

  txt_list <- list(comma_sep_quote, comma_sep_noquote, semi_sep, tab_sep, pipe_sep, space_sep)

  for (f in txt_list) {
    for (i in 1:length(txt_list)) {
      expect_true(dplyr::all_equal(f, txt_list[[i]]))
    }
  }

})



test_that("Identical files, different formats", {

  tab_sep <- readit(system.file("examples", "tab_sep.txt", package = package))
  csv <- readit(system.file("examples", "csv.csv", package = package))
  xls <- readit(system.file("examples", "xls.xls", package = package))
  xlsx <- readit(system.file("examples", "xlsx.xlsx", package = package))

  file_list <- list(tab_sep, csv, xls, xlsx)

  for (f in file_list) {
    for (i in 1:length(file_list)) {
      expect_true(dplyr::all_equal(f, file_list[[i]]))
    }
  }

})



test_that("Identical other files, different formats", {

  sas <- readit(system.file("examples", "iris.sas7bdat", package = package))
  stata <- readit(system.file("examples", "iris.dta", package = package))
  spss <- readit(system.file("examples", "iris.sav", package = package))

  others_list <- list(sas, stata, spss)

  for (f in others_list) {
    # Files aren't identical, because of labelling, etc., so test the basics
    expect_equal(nrow(f), 150)
    expect_equal(ncol(f), 5)
    colnames(f) <- tolower(gsub("[[:punct:]]", "", colnames(f)))
    expect_equal(colnames(f), c("sepallength", "sepalwidth", "petallength", "petalwidth", "species"))
  }

})



test_that("Additional arguments are picked up by readit", {

  tab_sep <- readit(system.file("examples", "tab_sep.txt", package = package),
                    n_max = 1)
  expect_equal(nrow(tab_sep), 1)

})
