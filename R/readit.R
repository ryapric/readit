#' Read Files of Any Type
#'
#' Given a file path, read the data into R, regardless of file type/extension.
#' `readit` is a thick wrapper around many of the
#' [tidyverse](https://www.tidyverse.org/) libraries, but can be forced to use
#' base functions where possible. Note that the caveat is that the file
#' _**needs**_ to have an extension, as well as be of a relatively common type.
#' "Common types" are any file type that can be handled by the
#' [readr](http://readr.tidyverse.org/), [readxl](http://readxl.tidyverse.org/),
#' or [haven](http://haven.tidyverse.org/) packages.
#'
#' @param .data File path to read data from.
#' @param tidyverse Should `readit` use functions available in the tidyverse?
#'   Defaults to
#' @param sheet If known to be an Excel file (`.xls`/`.xlsx`), this indicates
#'   the sheet to read. Defaults to the first sheet, and is passed on to
#'   [read_excel].
#' @param ... Additional arguments passed to tidyverse read functions.
#'
#' @examples
#' readit(system.file("examples", "csv.csv", package = "readit"))
#' readit(system.file("examples", "tab_sep.txt", package = "readit"))
#' readit(system.file("examples", "semi_sep.txt", package = "readit"))
#' readit(system.file("examples", "space_sep.txt", package = "readit"))
#' readit(system.file("examples", "xlsx.xlsx", package = "readit"))
#' readit(system.file("examples", "xls.xls", package = "readit"))
#'
#' @export
readit <- function(.data, tidyverse = TRUE, sheet = 1, ...) {

  dots <- list(...)

  if (tidyverse) {

    if (tolower(file_ext(.data)) == "txt") {

      delims <- list(
        comma_sep = function(x) read_csv(x, ...),
        tab_sep = function(x) read_tsv(x, ...),
        semi_sep = function(x) read_csv2(x, ...),
        pipe_sep = function(x) read_delim(x, delim = "|", ...),
        space_sep = function(x) read_delim(x, delim = " ", ...))

      best_delim <- lapply(delims, function(y)
        length(colnames(suppressMessages(suppressWarnings(y(.data))))))
      best_delim <- unlist(best_delim)
      best_delim <- names(best_delim[which(best_delim == max(best_delim))])

      stopifnot(length(best_delim) == 1)
      read_fun <- delims[[best_delim]]

    } else if (tolower(file_ext(.data)) == "csv") {
      read_fun <- function(x) read_csv(x)
    } else if (grepl("xls", tolower(file_ext(.data)))) {
      read_fun <- function(x) read_excel(x, sheet = sheet)
    } else {
      stop("Unrecognized file extension, or file does not exist")
    }

  } else {
    stop("Currently, only tidyverse functions are supported.")
  }

  read_fun(.data)

}
