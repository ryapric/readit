#' Read Files of Any Type
#'
#' @inheritParams readr::read_delim
#' @inheritParams readxl::read_excel
#'
#' @export
readit <- function(.data, tidyverse = TRUE, ...) {

  dots <- list(...)

  if (tidyverse) {

    if (tolower(file_ext(.data)) == "txt") {

      # delims <- list(
      #   tab_sep = function(x) read_tsv(x, n_max = 1),
      #   semi_sep = function(x) read_csv2(x, n_max = 1),
      #   pipe_sep = function(x) read_delim(x, delim = "|", trim_ws = TRUE, n_max = 1),
      #   space_sep = function(x) read_delim(x, delim = " ", trim_ws = TRUE, n_max = 1))
      #
      # delims <- lapply(names(delims), function(y) length(colnames(delims[[y]](.data))))
      # print(delims)
      message("I'll figure out .txt files later")

    } else if (tolower(file_ext(.data)) == "csv") {
      read_fun <- function(y) read_csv(y)
    } else if (grepl("xls", tolower(file_ext(.data)))) {
      read_fun <- function(y) read_excel(y, sheet = sheet)
    } else {
      stop("Unrecognized file extension when trying to validate data")
    }

  }

  read_fun(.data)

}
