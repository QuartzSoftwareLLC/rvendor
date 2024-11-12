#' install
#' @inheritParams devtools::install
#' @export
#' @description Installs the vendored package to the `./rvendor` directory
install <- function(...) {
  withr::with_libpaths(here::here("./rvendor"), devtools::install(..., force = TRUE))
}

#' activate
#' @export
#' @description Activates the vendored package by adding the `./rvendor` directory to the search path
activate <- function() {
  .libPaths(c(here::here("./rvendor"), .libPaths()))
}
