cchecks
=======



[![Build Status](https://travis-ci.com/ropenscilabs/cchecks.svg?branch=master)](https://travis-ci.com/ropenscilabs/cchecks)
[![codecov.io](https://codecov.io/github/ropenscilabs/cchecks/coverage.svg?branch=master)](https://codecov.io/github/ropenscilabs/cchecks?branch=master)

R client for the CRAN checks API at <https://cranchecks.info>

[CRAN checks API docs][docs]

authentication is only needed for the CRAN checks API for the functions that start with `cchn`

## Install


```r
remotes::install_github("ropenscilabs/cchecks")
```


```r
library("cchecks")
```

## heartbeat


```r
cch_heartbeat()
#> $routes
#>  [1] "/"                               "/docs"                          
#>  [3] "/heartbeat/?"                    "/pkgs"                          
#>  [5] "/pkgs/:name"                     "/maintainers"                   
#>  [7] "/maintainers/:email"             "/badges/:type/:package"         
#>  [9] "/badges/flavor/:flavor/:package" "/pkgs/:name/history"            
#> [11] "/history/:date"                  "/notifications/rules"           
#> [13] "/notifications/rules/:id"
```

## packages

all


```r
cch_pkgs(limit = 1)
#> $found
#> [1] 16498
#> 
#> $count
#> [1] 1
#> 
#> $offset
#> [1] 0
#> 
#> $error
#> NULL
#> 
#> $data
#>       _id package
#> 1 localIV localIV
#>                                                                 url summary.any
#> 1 https://cloud.r-project.org/web/checks/check_results_localIV.html       FALSE
#>   summary.ok summary.note summary.warn summary.error summary.fail
#> 1         12            0            0             0            0
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              checks
#> 1 r-devel-linux-x86_64-debian-clang, r-devel-linux-x86_64-debian-gcc, r-devel-linux-x86_64-fedora-clang, r-devel-linux-x86_64-fedora-gcc, r-devel-windows-ix86+x86_64, r-patched-linux-x86_64, r-patched-solaris-x86, r-release-linux-x86_64, r-release-osx-x86_64, r-release-windows-ix86+x86_64, r-oldrel-osx-x86_64, r-oldrel-windows-ix86+x86_64, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 0.3.0, 2.65, 2.35, 0, 0, 11, 2.44, 0, 2.14, 0, 18, 0, 7, 42.61, 33.88, 0, 0, 68, 42.17, 0, 41.53, 0, 73, 0, 59, 45.26, 36.23, 54.85, 53.87, 79, 44.61, 82.4, 43.67, 0, 91, 0, 66, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, https://www.R-project.org/nosvn/R.check/r-devel-linux-x86_64-debian-clang/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-devel-linux-x86_64-debian-gcc/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-devel-linux-x86_64-fedora-clang/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-devel-linux-x86_64-fedora-gcc/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-devel-windows-ix86+x86_64/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-patched-linux-x86_64/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-patched-solaris-x86/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-release-linux-x86_64/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-release-osx-x86_64/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-release-windows-ix86+x86_64/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-oldrel-osx-x86_64/localIV-00check.html, https://www.R-project.org/nosvn/R.check/r-oldrel-windows-ix86+x86_64/localIV-00check.html
#>   check_details             date_updated
#> 1            NA 2020-05-04T21:03:11.221Z
```

by name


```r
x <- cch_pkgs(c("geojsonio", "leaflet", "MASS"))
lapply(x, "[[", c("data", "summary"))
#> [[1]]
#> [[1]]$any
#> [1] TRUE
#> 
#> [[1]]$ok
#> [1] 11
#> 
#> [[1]]$note
#> [1] 1
#> 
#> [[1]]$warn
#> [1] 0
#> 
#> [[1]]$error
#> [1] 0
#> 
#> [[1]]$fail
#> [1] 0
#> 
#> 
#> [[2]]
#> [[2]]$any
#> [1] TRUE
#> 
#> [[2]]$ok
#> [1] 11
#> 
#> [[2]]$note
#> [1] 1
#> 
#> [[2]]$warn
#> [1] 0
#> 
#> [[2]]$error
#> [1] 0
#> 
#> [[2]]$fail
#> [1] 0
#> 
#> 
#> [[3]]
#> [[3]]$any
#> [1] FALSE
#> 
#> [[3]]$ok
#> [1] 12
#> 
#> [[3]]$note
#> [1] 0
#> 
#> [[3]]$warn
#> [1] 0
#> 
#> [[3]]$error
#> [1] 0
#> 
#> [[3]]$fail
#> [1] 0
```

## maintainers

all


```r
cch_maintainers(limit = 1)
#> $found
#> [1] 9369
#> 
#> $count
#> [1] 1
#> 
#> $offset
#> [1] 0
#> 
#> $error
#> NULL
#> 
#> $data
#>                      _id                  email             name
#> 1 f.briatte_at_gmail.com f.briatte_at_gmail.com François Briatte
#>                                                                                url
#> 1 https://cloud.r-project.org/web/checks/check_results_f.briatte_at_gmail.com.html
#>                         table
#> 1 ggnetwork, TRUE, 7, 5, 0, 0
#>                                                                                             packages
#> 1 ggnetwork, https://cloud.r-project.org/web/checks/check_results_ggnetwork.html, NOTE, OK, 5, 7, NA
#>               date_updated
#> 1 2020-05-04T20:00:50.553Z
```

by name


```r
cch_maintainers(c("maelle.salmon_at_yahoo.se", "13268259225_at_163.com"))
#> [[1]]
#> [[1]]$error
#> NULL
#> 
#> [[1]]$data
#> [[1]]$data$`_id`
#> [1] "maelle.salmon_at_yahoo.se"
#> 
#> [[1]]$data$email
#> [1] "maelle.salmon_at_yahoo.se"
#> 
#> [[1]]$data$name
#> [1] "Maëlle Salmon"
#> 
#> [[1]]$data$url
#> [1] "https://cloud.r-project.org/web/checks/check_results_maelle.salmon_at_yahoo.se.html"
#> 
#> [[1]]$data$table
#>       package   any ok note warn error
#> 1 monkeylearn  TRUE  7    5    0     0
#> 2    opencage  TRUE  6    6    0     0
#> 3        riem FALSE 12    0    0     0
#> 4     ropenaq FALSE 12    0    0     0
#> 5 rtimicropem  TRUE  7    5    0     0
#> 
#> [[1]]$data$packages
#>       package
#> 1 monkeylearn
#> 2    opencage
#> 3        riem
#> 4     ropenaq
#> 5 rtimicropem
#>                                                                     url
#> 1 https://cloud.r-project.org/web/checks/check_results_monkeylearn.html
#> 2    https://cloud.r-project.org/web/checks/check_results_opencage.html
#> 3        https://cloud.r-project.org/web/checks/check_results_riem.html
#> 4     https://cloud.r-project.org/web/checks/check_results_ropenaq.html
#> 5 https://cloud.r-project.org/web/checks/check_results_rtimicropem.html
#>     check_result version
#> 1 NOTE, OK, 5, 7      NA
#> 2 NOTE, OK, 6, 6      NA
#> 3         OK, 12      NA
#> 4         OK, 12      NA
#> 5 NOTE, OK, 5, 7      NA
#> 
#> [[1]]$data$date_updated
#> [1] "2020-05-04T20:00:50.572Z"
#> 
#> 
#> 
#> [[2]]
#> [[2]]$error
#> NULL
#> 
#> [[2]]$data
#> [[2]]$data$`_id`
#> [1] "13268259225_at_163.com"
#> 
#> [[2]]$data$email
#> [1] "13268259225_at_163.com"
#> 
#> [[2]]$data$name
#> [1] "Xiao-Ping You"
#> 
#> [[2]]$data$url
#> [1] "https://cloud.r-project.org/web/checks/check_results_13268259225_at_163.com.html"
#> 
#> [[2]]$data$table
#>   package  any ok note warn error
#> 1    XHWE TRUE  0   12    0     0
#> 
#> [[2]]$data$packages
#>   package                                                            url
#> 1    XHWE https://cloud.r-project.org/web/checks/check_results_XHWE.html
#>   check_result version
#> 1         NULL      NA
#> 
#> [[2]]$data$date_updated
#> [1] "2020-05-04T20:00:50.692Z"
```

## notifications

Functions for working with notifications are all prefixed with `cchn`. 

`cchn` functions are designed to be used from within an R package directory. The functions
look for the package name and maintainer email address. Functions copy heavily from 
https://github.com/r-hub/rhub

The functions

- `cchn_register()`: registration
- `cchn_rule_list()`: list your own rules
- `cchn_rule_get()`: get a rule by id
- `cchn_rule_add()`: create a rule
- `cchn_rule_delete()`: delete a rule by id (get id from `cchn_rule_list`)

The first thing to do is to register an email address. In an R session in a working directory for 
one of your packages that is on CRAN, run `cchn_register()`. This function:

- registers your email address
- a validation email is sent to you right away with your token
- paste the token from the amil into the R session
- the email and token are then saved in a file on your machine
- all `cchn_rule*` functions use this cached token
- you don't need to pass the token in any `cchn` function calls

If you run `cchn_register()` in the same package directory (with the same email address), 
you'll be issued a new token, which will be updated in your cached token file.

It's entirely possible to have more than one email address you use across different R packages. 
If you run `cchn_register()` in a different package directory (with a different email address
from a previous run of `cchn_register()`), you'll be issued a different token associated 
with that new email address.

See `?cchn_rules` for details on how the rules work and many examples of adding rules.

Note that you can only manage your own rules. You can not list, get, or delete rules 
of other users.

to do:

- may create other functions for use cases where users want to work across packages rather
than within a single package.

## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/cchecks/issues).
* License: MIT
* Get citation information for `cchecks` in R doing `citation(package = 'cchecks')`
* Please note that this project is released with a [Contributor Code of Conduct][coc]. By participating in this project you agree to abide by its terms.

[docs]: https://cranchecks.info/docs
[coc]: https://github.com/ropenscilabs/cchecks/blob/master/CODE_OF_CONDUCT.md
