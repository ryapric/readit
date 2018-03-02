Effortlessly Read Any Rectangular Data Into R: Just readit!
================
Ryan Price <ryapric@gmail.com>
2018-03-01

`readit()` may be the only data-read function you ever need; by wrapping other popular reader packages, like [readr](https://cran.r-project.org/package=readr), [readxl](https://cran.r-project.org/package=readxl), [haven](https://cran.r-project.org/package=haven), [foreign](https://cran.r-project.org/package=foreign), and [jsonlite](https://cran.r-project.org/package=jsonlite), `readit` provides one self-titled function to read almost anything that isn't formatted like hot garbage. If you have faith that the underlying data is of modest quality, and don't care how it's delimited, or what it's file extension suggests, then `readit` is for you.

This package was inspired by a handover at work; I took over as Maintainer for a package that dealt with a lot of disparate file extensions, and quickly became frustrated with trying to keep track of which filename was delimited in what way. "Why can't I just... ***f@!\#ing read it?!***" And lo, `readit` was born!

------------------------------------------------------------------------

### Features

`readit` is a pretty straightforward R package. It only exports one function, `readit()`, which wraps most of the reader functions in [readr](https://cran.r-project.org/package=readr), [readxl](https://cran.r-project.org/package=readxl) [haven](https://cran.r-project.org/package=haven), [foreign](https://cran.r-project.org/package=foreign), and [jsonlite](https://cran.r-project.org/package=jsonlite). You can pass any arguments that you would normally pass to those functions, to `readit()`, as well.

`readit()` uses some basic heuristics based on the file extension to call the appropriate read function, and if it's too ambigious (like `.txt` files), `readit()` will perform some commonly-implemented checks to guess the correct delimiter. `readit()` will always print out what file type it guessed (in nice, bold, green console text, via [crayon](%5Breadr%5D(https://cran.r-project.org/package=crayon)), as a sanity check, and throw an error if the file path you give it is parsed and determined to be too messy to deal with automatically. For example, say you have some `.txt` file that you receive from a client each month, and it's delimited differently every time (because that's how it goes). Instead of inspecting it with four or five *different* functions first, you can just call `readit()` on it to pass it to `readr`'s... readers:

    > readit("path/to/frustrating/file.txt")
    File guessed to be pipe-delimited ("path/to/frustrating/file.txt")
    Parsed with column specification:
    cols(
      testheader1 = col_character(),
      testheader2 = col_character(),
      testheader3 = col_character(),
      testheader4 = col_character(),
      testheader5 = col_character(),
      testheader6 = col_character()
    )
    # A tibble: 5 x 5
      testheader1 testheader2 testheader3 testheader4 testheader5
      <chr>       <chr>       <chr>       <chr>       <chr>
    1 testdata11  testdata12  testdata13  testdata14  testdata15
    2 testdata21  testdata22  testdata23  testdata24  testdata25
    3 testdata31  testdata32  testdata33  testdata34  testdata35
    4 testdata41  testdata42  testdata43  testdata44  testdata45
    5 testdata51  testdata52  testdata53  testdata54  testdata55

Huzzah! It turns out that someone replaced all the delimiters with pipes (`|`), but with `readit`, that's no problem! Just throw it into the great maw, and watch as the correct data comes back out.

What about if the same file becomes a sneaky tab-delimited file next month?

    > readit("path/to/frustrating/file.txt")
    File guessed to be tab-delimited ("path/to/frustrating/file.txt")
    Parsed with column specification:
    cols(
      testheader1 = col_character(),
      testheader2 = col_character(),
      testheader3 = col_character(),
      testheader4 = col_character(),
      testheader5 = col_character()
    )
    # A tibble: 6 x 5
      testheader1 testheader2 testheader3 testheader4 testheader5
      <chr>       <chr>       <chr>       <chr>       <chr>
    1 testdata11  testdata12  testdata13  testdata14  testdata15
    2 testdata21  testdata22  testdata23  testdata24  testdata25
    3 testdata31  testdata32  testdata33  testdata34  testdata35
    4 testdata41  testdata42  testdata43  testdata44  testdata45
    5 testdata51  testdata52  testdata53  testdata54  testdata55
    6 testdata61  testdata62  testdata63  testdata64  testdata65

Nope, no problem: `readit()` picked it up just fine, including the newest data.

What if your client starts storing the same data in Excel files, instead?

    > readit("path/to/frustrating/file.xlsx")
    File guessed to be xls/xlsx (Excel) ("path/to/frustrating/file.xlsx")
    Parsed with column specification:
    cols(
      testheader1 = col_character(),
      testheader2 = col_character(),
      testheader3 = col_character(),
      testheader4 = col_character(),
      testheader5 = col_character(),
      testheader6 = col_character()
    )
    # A tibble: 6 x 5
      testheader1 testheader2 testheader3 testheader4 testheader5
      <chr>       <chr>       <chr>       <chr>       <chr>
    1 testdata11  testdata12  testdata13  testdata14  testdata15
    2 testdata21  testdata22  testdata23  testdata24  testdata25
    3 testdata31  testdata32  testdata33  testdata34  testdata35
    4 testdata41  testdata42  testdata43  testdata44  testdata45
    5 testdata51  testdata52  testdata53  testdata54  testdata55
    6 testdata61  testdata62  testdata63  testdata64  testdata65

`readit()` has you covered. What if that data is on the second Excel sheet, though? Just pass `sheet = 2` to `readit()`, just like you would to `read_excel()`:

    > readit("path/to/frustrating/file.xlsx", sheet = 2)
    File guessed to be xls/xlsx (Excel) ("path/to/frustrating/file.xlsx")
    Parsed with column specification:
    cols(
      testheader1 = col_character(),
      testheader2 = col_character(),
      testheader3 = col_character(),
      testheader4 = col_character(),
      testheader5 = col_character(),
      testheader6 = col_character()
    )
    # A tibble: 6 x 5
      testheader1 testheader2 testheader3 testheader4 testheader5
      <chr>       <chr>       <chr>       <chr>       <chr>
    1 testdata11  testdata12  testdata13  testdata14  testdata15
    2 testdata21  testdata22  testdata23  testdata24  testdata25
    3 testdata31  testdata32  testdata33  testdata34  testdata35
    4 testdata41  testdata42  testdata43  testdata44  testdata45
    5 testdata51  testdata52  testdata53  testdata54  testdata55
    6 testdata61  testdata62  testdata63  testdata64  testdata65

What if your client is a bunch of academics, and they send you the same data, *but in SAS format*?

    > readit("path/to/frustrating/file.sas7bdat")
    File guessed to be .sas7b*at (SAS) ("path/to/frustrating/file.sas7bdat")
    Parsed with column specification:
    cols(
      testheader1 = col_character(),
      testheader2 = col_character(),
      testheader3 = col_character(),
      testheader4 = col_character(),
      testheader5 = col_character(),
      testheader6 = col_character()
    )
    # A tibble: 6 x 5
      testheader1 testheader2 testheader3 testheader4 testheader5
      <chr>       <chr>       <chr>       <chr>       <chr>
    1 testdata11  testdata12  testdata13  testdata14  testdata15
    2 testdata21  testdata22  testdata23  testdata24  testdata25
    3 testdata31  testdata32  testdata33  testdata34  testdata35
    4 testdata41  testdata42  testdata43  testdata44  testdata45
    5 testdata51  testdata52  testdata53  testdata54  testdata55
    6 testdata61  testdata62  testdata63  testdata64  testdata65

Still no worries (`readit` will pick up both `.sas7bdat` and `.sas7bcat` extensions)

In fact, readit is able to read all of the following data, so long as they have a file extension, and will take any arguments you would want to pass to the underlying functions:

-   `.txt` (but not fixed-width, for obvious reasons)
-   `.csv`
-   `.xls`/`.xlsx`
-   `.sas7bdat`/`.sas7bcat` (SAS files)
-   `.dta` (Stata files)
-   `.sav`/`.por` (SPSS files)
-   `.json` (JSON arrays, which are parsed into data frames, like in [loggit](https://cran.r-project.org/package=loggit)

------------------------------------------------------------------------

### How to Use

Chances are that if you've read this far, you're familiar with R's exception handlers. If so, then there are only two other things that you need to know in order to use `readit`:

1.  As per CRAN policies, ***a package cannot write*** to a user's "home filespace" without approval. Therefore, you need to set the log file before any logs are written to disk, using `setLogFile(logfile)` (I recommend in your working directory, and naming it "readit.json"). If you are using readit in your own package, you can wrap this in a call to `.onLoad()`, so that logging is set on package load. If not, then make the set call as soon as possible (e.g. at the top of your script(s), right after your calls to `library()`); otherwise, no logs will be written to persistent storage!

2.  The logs are output to your log file each time an exception is raised, or when `readit()` is called, and you can review it there. The fields supplied by default are:

-   `timestamp`: when the exception was raised
-   `log_lvl`: the "level" of the exception (INFO, WARN, ERROR, or custom)
-   `log_msg`: the diagnostic message generated by R
-   `log_detail`: additional exception details you can pass to the exception handlers, though not necessary to supply (will be filled with "" if not supplied).

#### ***That's it!***

------------------------------------------------------------------------

However, if you want more control, or care a bit more about the details:

While this package automatically masks the base handlers, the `readit` function that they call is also exported for use, if so desired. This allows you to log arbitrary things as much or as little as you see fit. The `readit` function is called as: `readit(log_lvl, log_msg, log_detail, ...)`. The argument you may not recognize is `...`, which is supplied as *named* vectors (each of length one) providing any additional field names you would like to log:

    readit("INFO", "This is a message", but_maybe = "you want more fields?", sure = "why not?", like = 2, or = 10, what = "ever")

Since `readit()` calls [dplyr::bind\_rows()](http://dplyr.tidyverse.org/reference/bind.html) behind the scenes, you can add as many fields of any type as you want without any append issues or errors. Note, however, that this means that any future calls to `readit()` for the same custom fields, require that those fields are spelled the same as originally provided. If not, then the misspelling will cause *another* field to be created, and (the `data frame` version of) your log file will look like this:

    > readit("INFO", "Result 1", scientist = "Ryan")
    > readit("INFO", "Result 2", scietist = "Thomas")

                timestamp log_lvl  log_msg  log_detail scientist scietist
    1 2018-02-13 18:01:32    INFO Result 1          ""      Ryan     <NA>
    2 2018-02-13 18:02:32    INFO Result 2          ""      <NA>   Thomas

Also note that *you **do not always** have to supply a custom field* once it is created; thanks, JSON and `dplyr`!

    > readit("INFO", "Result 1", scientist = "Ryan")
    > readit("INFO", "Result 2", scientist = "Thomas")
    > readit("INFO", "Result 3")

                timestamp log_lvl  log_msg  log_detail     scientist
    1 2018-02-13 18:01:32    INFO Result 1          ""          Ryan
    2 2018-02-13 18:02:32    INFO Result 2          ""        Thomas
    3 2018-02-13 18:03:32    INFO Result 3          ""          <NA>

As of v1.0.1, you can also supply a `data.frame` or `tbl_df` as the *sole* argument to `readit()`, and the whole data frame will be logged. To do this, you must specify at least "log\_lvl" and "log\_msg" as column names in the data frame; you can then supply as many additional columns as you wish, just like is using `...`. Note that the timestamp is still handled by `readit()`.

------------------------------------------------------------------------

Also, other control options:

-   You can control the output name & location of the log file using `setLogFile(logfile)`. `readit` *will not* write to disk unless an exception is raised, or unless `readit()` is called, but you should specify this change early, if desired. You can see the current log file path at package attachment, or by calling `getLogFile()`.
-   If for any reason you do not want to log the output to a log file, you can set each handler's `.readit` argument to `FALSE`. This will eventually be a global option that the user can set, and leave the handlers without the argument. If using `readit` in your own package, you can just `importFrom(readit, function)` the handlers that you *do* want.
-   You can control the format of the timestamp in the logs; it defaults to ISO format `"%Y-%m-%d %H:%M:%S"`, but you may set it yourself using `setTimestampFormat()`. Note that this format is passed to `format.Date()`, so the supplied format needs to be valid.

------------------------------------------------------------------------

### Note on *What* Gets Logged

Note that this package does not mask the handler functions included in *other* packages, ***including in base R***; for example, running the following will throw an error as usual, but *will not* write to the log file:

    > 2 + "a"
    Error in 2 + "a" : non-numeric argument to binary operator
    > dplyr::left_join(data.frame(a = 1), data.frame(b = 2))
    Error: `by` required, because the data sources have no common variables
    > # Did readit write these exception messages to the logfile?
    > file.exists(getLogFile())
    [1] FALSE

This is integral to how R works with packages, and is by design; it has to do with [namespaces](http://r-pkgs.had.co.nz/namespace.html), which is how R looks for *what* to do when you ask it to do something. Basically, if a package you use doesn't have `readit` in its `NAMESPACE` file, then its internal exception handlers won't be masked by `readit`.

If you really wish to have *all* exception messages logged by `readit`, please be patient, as this feature is in the works.

------------------------------------------------------------------------

### Installation

You can install the latest CRAN release of `readit` via `install.packages("readit")`.

Or, to get the latest development version from GitHub --

Via [devtools](https://github.com/hadley/devtools):

    devtools::install_github("ryapric/readit")

Or, clone & build from source:

    cd /path/to/your/repos
    git clone https://github.com/ryapric/readit.git readit
    R CMD INSTALL readit

To use the most recent development version of `readit` in your own package, you can include it in your `Remotes:` field in your DESCRIPTION file:

    Remotes: github::ryapric/readit

Note that packages being submitted to CRAN *cannot* have a `Remotes` field. Refer [here](https://cran.r-project.org/web/packages/devtools/vignettes/dependencies.html) for more info.

------------------------------------------------------------------------

### License

MIT @ Ryan J. Price,
