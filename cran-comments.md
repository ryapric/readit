## Test environments
* Manjaro Linux (release)
* Debian Stretch (release)
* Debian Stretch (devel)
* win-builder (release)
* win-builder (devel)

## R CMD check results
There were no ERRORs, NOTEs

There was 1 WARNING:

* Warning: 'readit' is deprecated.

This is from the deprecation warnings in the `examples` section of the
documentation. I can remove these by either wrapping the examples in
`suppressWarnings()`, or removing them entirely, since this release indicates
the retirement of the package overall.

## Downstream dependencies
There are no downstream/reverse dependencies for this package.
