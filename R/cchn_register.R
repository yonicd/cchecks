#' Notifications: register your email address and get a token
#'
#' @export
#' @param email (character) email address to use for interaction with 
#' the CRAN checks API
#' @param token (character) your CRAN checks API token. you shouldn't need
#' to pass a token in here. if you used [cchn_register()] your token should
#' be cached
#' @param ... Curl options passed to [crul::verb-GET]
#' @return list, with `email` and `token` slots
#' @details We cache a file with details at the path 
#' `file.path(rappdirs::user_data_dir("cranchecks", "cchecks"), "emails.csv")`
cchn_register <- function(email = NULL, token = NULL, ...) {
  if (is.null(email) || is.null(token)) {
    if (!interactive()) {
      stop("No email or no token and not in interactive mode")
    }
    return(interactive_validate_email(email, token, ...))
  }
  add_token(email, token)
  message("Token added for ", sQuote(email))
  cat("\n")
}

# cchn_validate <- function(token = NULL) {
#   z <- tryCatch(cchn_rule_list(token = token), error = function(e) e)
#   if (!inherits(z, "error")) return(TRUE)
#   mssg <- "\n you may have an old token in your emails.csv file
#  if so, remove it and re-run cchn_register()"
#   stop(z$message, mssg, call.=FALSE)
# }
