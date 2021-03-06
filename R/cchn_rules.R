#' Notifications: add, list, get, delete notification rules
#'
#' @name cchn_rules
#' @param status (character) a check status, one of: error, warn, note, fail
#' @param platform (character) a platform, a string to match against the
#' platform strings used by cran checks. e.g., "osx" would match any osx
#' platform check results, whereas you could limit the rule to just a single
#' specific platform by using the target platforms exact string
#' "r-oldrel-osx-x86_64"
#' @param time (character) number of days
#' @param regex  (character) a regex string
#' @param package (character) a package name. if `NULL`, we attempt to
#' get the package name from the working directory, and fail out if there's
#' not a valid package structure/package name
#' @param email (character) email address to use for interaction with
#' the CRAN checks API. we use the email address in the maintainers slot
#' of the DESCRIPTION file of your working directory. you can supply an 
#' email address instead
#' @param path (character) path to a directory containing an R package
#' @param id (integer) a rule id. note that you can not get or delete
#' rules that are not yours. required
#' @param quiet (logical) suppress messages? default: `FALSE`
#' @param ... Curl options passed to [crul::verb-GET], [crul::verb-POST], or
#' [crul::verb-DELETE]
#' 
#' @details
#'
#' - `cchn_rule_add()`: add a rule, one rule per function call
#' - `cchn_rule_get()`: get a rule by rule id (see `cchn_rule_list` to get ids;
#' can only get rules for the authenticated user)
#' - `cchn_rule_list()`: list all rules for the authenticated user
#' - `cchn_rule_delete()`: delete a rule by rule id (only those for the
#' authenticated user)
#' 
#' @section example rules:
#' 
#' - ERROR for 3 days in a row across 2 or more platforms
#'     - `cchn_rule_add(status = 'error', time = 3, platform = 2)`
#' - ERROR for 2 days in a row on all osx platforms
#'     - `cchn_rule_add(status = 'error', time = 2, platform = "osx")`
#' - ERROR for 2 days in a row on all release R versions
#'     - `cchn_rule_add(status = 'error', time = 2, platform = "release")`
#' - WARN for 4 days in a row on any platform except Solaris
#'     - `cchn_rule_add(status = 'warn', time = 4, platform = "-solaris")`
#' - WARN for 2 days in a row across 9 or more platforms
#'     - `cchn_rule_add(status = 'warn', time = 2, platform = 10)`
#' - NOTE across all osx platforms
#'     - `cchn_rule_add(status = 'note', platform = "osx")`
#' - NOTE
#'     - `cchn_rule_add(status = 'note')`
#' - error details contain regex 'install'
#'     - `cchn_rule_add(regex = "install")`
#' 
#' @return 
#' 
#' - `cchn_rule_add()`: message about the rule added, and a note about 
#' using `cchn_rule_list()` to list your rules
#' - `cchn_rule_get()`: list with elements `error` and `data` (a list of
#' the parts of the rule)
#' - `cchn_rule_list()`: list with elements `error` and `data` (a data.frame
#' of all the rules associated with your email)
#' - `cchn_rule_delete()`: if deletion works, a message saying "ok"
#'
#' @examples \dontrun{
#' # (x <- cchn_rule_list())
#' # cchn_rule_get(x$data$id[1])
#' # cchn_rule_delete(x$data$id[1])
#' # cchn_rule_get(id = x$data$id[1])
#' }

#' @export
#' @rdname cchn_rules
cchn_rule_add <- function(status = NULL, platform = NULL,
  time = NULL, regex = NULL, package = NULL, email = NULL,
  path = ".", quiet = FALSE, ...) {

  if (is.null(email)) email <- get_maintainer_email(path)
  email_token_check(email, path)
  package <- package_name(package)
  assert(package, "character")
  assert(status, "character")
  assert(platform, c("numeric", "integer", "character"))
  assert(time, c("numeric", "integer"))
  assert(regex, "character")
  assert(quiet, "logical")
  body <- ct(list(package = package, status = status, platforms = platform,
    time = time, regex = regex))
  x <- ccc_POST("notifications/rules", body = list(body), email = email, ...)
  if (!quiet) add_mssg(package, rule = jsonlite::toJSON(body, auto_unbox = TRUE))
  return(TRUE)
}

add_mssg <- function(package, rule) {
  cli::rule(
    left = "success ", line = 2, line_col = "blue", width = 30
  )
  cli::cat_line(
    paste("rule added for package", crayon::style(package, "lightblue"))
  )
  cli::cat_line(
    paste("rule:", crayon::style(rule, "purple"))
  )
  cli::cat_line("use ", crayon::style("cchn_rule_list()", "underline"),
    " to get your rules")
}

#' @export
#' @rdname cchn_rules
cchn_rule_list <- function(email = NULL, path = ".", ...) {
  if (is.null(email)) email <- get_maintainer_email(path)
  email_token_check(email, path)
  x <- ccc_GET("notifications/rules", list(), email = email, ...)
  cch_parse(x, TRUE)
}

#' @export
#' @rdname cchn_rules
cchn_rule_get <- function(id, email = NULL, path = ".", ...) {
  if (is.null(email)) email <- get_maintainer_email(path)
  email_token_check(email, path)
  assert(id, c('integer', 'numeric'))
  stopifnot("id length can not be 0" = length(id) > 0)
  x <- ccc_GET(path = file.path("notifications/rules", id), list(),
    email = email, ...)
  cch_parse(x, TRUE)
}

#' @export
#' @rdname cchn_rules
cchn_rule_delete <- function(id, email = NULL, path = ".", ...) {
  if (is.null(email)) email <- get_maintainer_email(path)
  email_token_check(email, path)
  assert(id, c('integer', 'numeric'))
  stopifnot("id length can not be 0" = length(id) > 0)
  x <- ccc_DELETE(path = file.path("notifications/rules", id),
    email = email, ...)
  if (x$status_code == 204) message("ok")
}
