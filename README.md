Effortlessly Read Any Rectangular Data Into R: Just readit!
================
Ryan Price <ryapric@gmail.com>
2018-03-01

`readit()` may be the only data-read function you ever need; by wrapping other popular reader packages, like [readr](https://cran.r-project.org/package=readr), [readxl](https://cran.r-project.org/package=readxl), [haven](https://cran.r-project.org/package=haven), [jsonlite](https://cran.r-project.org/package=jsonlite), `readit` provides one self-titled function to read almost anything that isn't formatted like hot garbage. If you have faith that the underlying data is of modest quality, and don't care how it's delimited, or what it's file extension suggests, then `readit` is for you.

This package was inspired by a handover at work; I took over as Maintainer for a package that dealt with a lot of disparate file extensions, and quickly became frustrated with trying to keep track of which filename was delimited in what way. "Why can't I just... ***f@!\#ing read it?!***" And lo, `readit` was born!

------------------------------------------------------------------------

### Features

`readit` is a pretty straightforward R package. It only exports one function, `readit()`, which wraps most of the reader functions in [readr](https://cran.r-project.org/package=readr), [readxl](https://cran.r-project.org/package=readxl) [haven](https://cran.r-project.org/package=haven), and [jsonlite](https://cran.r-project.org/package=jsonlite). You can pass any arguments that you would normally pass to those functions, to `readit()`, as well.

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

### Future work

-   Add support for reader functions from the [foreign](https://cran.r-project.org/package=foreign) package.

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

MIT @ Ryan J. Price, 2018.
